#!/usr/bin/env bash
# Team27 Raspberry Pi dual network setup for legacy dhcpcd + wpa_supplicant.
# Preferred mode: join the already configured phone hotspot.
# Fallback mode: after about 50 seconds without a Wi-Fi link/IP, host Team27-Car at 10.27.0.1.
set -Eeuo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "请使用 sudo bash setup_dual_network.sh 运行。" >&2
  exit 1
fi

interface="${TEAM27_INTERFACE:-wlan0}"
ap_address="10.27.0.1/24"
ap_ssid="Team27-Car"

if ! ip link show "${interface}" >/dev/null 2>&1; then
  echo "未找到无线接口 ${interface}。" >&2
  exit 1
fi

read -r -p "车载热点名称 [${ap_ssid}]: " entered_ssid
if [[ -n ${entered_ssid} ]]; then
  ap_ssid="${entered_ssid}"
fi

read -r -s -p "车载热点密码（8-63位，仅字母/数字/._-）: " ap_password
echo
if [[ ${#ap_password} -lt 8 || ${#ap_password} -gt 63 || ! ${ap_password} =~ ^[A-Za-z0-9._-]+$ ]]; then
  echo "密码格式不合要求。" >&2
  exit 1
fi

echo "将保留现有手机热点配置，并安装自动回退热点。"
echo "当前连接：$(iw dev "${interface}" link 2>/dev/null | head -n 1 || true)"
echo "当前地址：$(ip -4 -brief address show dev "${interface}" 2>/dev/null || true)"

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y hostapd dnsmasq avahi-daemon

backup_once() {
  local source="$1"
  local backup="${source}.team27.bak"
  if [[ -e ${source} && ! -e ${backup} ]]; then
    cp -a "${source}" "${backup}"
  fi
}

backup_once /etc/hostapd/hostapd.conf
backup_once /etc/default/hostapd

install -d -m 0755 /etc/hostapd /etc/dnsmasq.d

cat >/etc/hostapd/hostapd.conf <<EOF
# TEAM27 MANAGED
country_code=CN
interface=${interface}
driver=nl80211
ssid=${ap_ssid}
hw_mode=g
channel=6
wmm_enabled=1
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=${ap_password}
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
EOF
chmod 0600 /etc/hostapd/hostapd.conf

cat >/etc/dnsmasq.d/team27-fallback.conf <<EOF
# TEAM27 MANAGED
interface=${interface}
bind-interfaces
dhcp-range=10.27.0.20,10.27.0.100,255.255.255.0,24h
EOF

if grep -qE '^[#[:space:]]*DAEMON_CONF=' /etc/default/hostapd; then
  sed -i 's|^[#[:space:]]*DAEMON_CONF=.*|DAEMON_CONF="/etc/hostapd/hostapd.conf"|' /etc/default/hostapd
else
  printf '\nDAEMON_CONF="/etc/hostapd/hostapd.conf"\n' >>/etc/default/hostapd
fi

cat >/usr/local/sbin/team27-start-ap <<EOF
#!/usr/bin/env bash
set -Eeuo pipefail
interface="${interface}"
logger -t team27-network "手机热点不可用，切换为车载热点 ${ap_ssid} / ${ap_address}"

systemctl stop dhcpcd.service 2>/dev/null || true
systemctl stop wpa_supplicant.service 2>/dev/null || true
pkill -x wpa_supplicant 2>/dev/null || true
ip link set "\${interface}" down 2>/dev/null || true
ip address flush dev "\${interface}"
ip link set "\${interface}" up
ip address add ${ap_address} dev "\${interface}"
systemctl restart dnsmasq.service

if ! systemctl restart hostapd.service; then
  logger -t team27-network "车载热点启动失败，恢复手机热点客户端模式"
  systemctl stop dnsmasq.service 2>/dev/null || true
  ip address flush dev "\${interface}" 2>/dev/null || true
  systemctl start wpa_supplicant.service 2>/dev/null || true
  systemctl restart dhcpcd.service
  exit 1
fi

logger -t team27-network "车载热点已启动：${ap_ssid}，地址 10.27.0.1"
EOF
chmod 0755 /usr/local/sbin/team27-start-ap

cat >/usr/local/sbin/team27-network-watch <<'EOF'
#!/usr/bin/env bash
set -Eeuo pipefail
interface="wlan0"
misses=0

# 给 wpa_supplicant 和手机热点留出启动、认证及 DHCP 时间。
sleep 20
while true; do
  if iw dev "${interface}" link 2>/dev/null | grep -q 'Connected to ' &&
     ip -4 address show dev "${interface}" scope global | grep -q 'inet '; then
    misses=0
  else
    misses=$((misses + 1))
  fi

  if (( misses >= 6 )); then
    exec /usr/local/sbin/team27-start-ap
  fi
  sleep 5
done
EOF
sed -i "s/interface=\"wlan0\"/interface=\"${interface}\"/" /usr/local/sbin/team27-network-watch
chmod 0755 /usr/local/sbin/team27-network-watch

cat >/usr/local/sbin/team27-ap-mode <<'EOF'
#!/usr/bin/env bash
set -Eeuo pipefail
systemctl stop team27-network-fallback.service 2>/dev/null || true
exec /usr/local/sbin/team27-start-ap
EOF
chmod 0755 /usr/local/sbin/team27-ap-mode

cat >/usr/local/sbin/team27-client-mode <<EOF
#!/usr/bin/env bash
set -Eeuo pipefail
interface="${interface}"
systemctl stop team27-network-fallback.service 2>/dev/null || true
systemctl stop hostapd.service dnsmasq.service 2>/dev/null || true
ip address flush dev "\${interface}" 2>/dev/null || true
systemctl start wpa_supplicant.service 2>/dev/null || true
systemctl restart dhcpcd.service
systemctl start team27-network-fallback.service
EOF
chmod 0755 /usr/local/sbin/team27-client-mode

cat >/etc/systemd/system/team27-network-fallback.service <<'EOF'
[Unit]
Description=Team27 phone Wi-Fi with car access-point fallback
After=dhcpcd.service wpa_supplicant.service
Wants=dhcpcd.service

[Service]
Type=simple
ExecStart=/usr/local/sbin/team27-network-watch
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl unmask hostapd.service
systemctl disable --now hostapd.service dnsmasq.service 2>/dev/null || true
systemctl enable ssh.service avahi-daemon.service
hostnamectl set-hostname team27-car
if grep -q '^127\.0\.1\.1' /etc/hosts; then
    sed -i 's/^127\.0\.1\.1.*/127.0.1.1\tteam27-car/' /etc/hosts
else
    printf '127.0.1.1\tteam27-car\n' >>/etc/hosts
fi
systemctl daemon-reload
systemctl enable --now team27-network-fallback.service

echo
echo "安装完成，当前手机热点连接不会被主动切断。"
echo "正常模式：手机热点 + team27-car.local（保留互联网）。"
echo "回退模式：手机热点不可用约 50 秒后出现 ${ap_ssid}，车地址 10.27.0.1。"
echo "强制车载热点：sudo team27-ap-mode"
echo "切回手机热点：sudo team27-client-mode（连接会中断，随后用 team27-car.local 重连）"
echo "建议现在重启一次并分别测试两种模式：sudo reboot"
