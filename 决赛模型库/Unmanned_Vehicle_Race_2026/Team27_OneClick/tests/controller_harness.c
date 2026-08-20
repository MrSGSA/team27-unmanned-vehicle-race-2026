/* 开发期黑盒测试桩：只测试MWORKS生成代码，不参与树莓派部署。 */
#include <math.h>
#include <stdio.h>
#include <string.h>

#include "for_code_JGB520_Team27.h"

int fd = -1;

/* 2026-08-20 V3 fixed-sensor physical mapping. */
static double input_fc = 80.0; /* dis1: front centre */
static double input_fr = 35.0; /* dis2: front right, former servo sensor */
static double input_sr = 12.0; /* dis3: side right 90 degrees */
static double input_sl = 12.0; /* dis4: side left 90 degrees */
static double input_fl = 35.0; /* dis5: front left, former rear sensor */

static double output_speed = 0.0;
static double output_motor_1 = 0.0;
static double output_motor_2 = 0.0;
static double output_steer = 0.0;
static double output_servo = 0.0;
static double previous_steer = 0.0;
static double max_steer_step = 0.0;
static int reverse_seen = 0;

void rasInit(void) {}
int serialOpen(const char *device, const int baud)
{
    (void)device;
    (void)baud;
    return 1;
}
void delayMicroseconds(unsigned int how_long) { (void)how_long; }
void serialClose(int descriptor) { (void)descriptor; }
void rear_sensor_cmd(double angle) { (void)angle; }
void steer_cmd(double command)
{
    double step = fabs(command - previous_steer);
    if (step > max_steer_step) max_steer_step = step;
    previous_steer = command;
    output_steer = command;
}
void front_sensor_cmd(double command) { output_servo = command; }

void motor_send_cmd(int id, double speed, int time_ms)
{
    (void)time_ms;
    if (id == 1) output_motor_1 = speed;
    if (id == 2) output_motor_2 = speed;
    if (fabs(speed) > output_speed) output_speed = fabs(speed);
    /* Official forward polarity is ID1 negative, ID2 positive. */
    if ((id == 1 && speed > 1e-9) || (id == 2 && speed < -1e-9))
        reverse_seen = 1;
}

void GetCarMsg(double *dis1, double *dis2, double *dis3,
    double *dis4, double *dis5)
{
    *dis1 = input_fc;
    *dis2 = input_fr;
    *dis3 = input_sr;
    *dis4 = input_sl;
    *dis5 = input_fl;
}

static void model_step(void)
{
    output_speed = 0.0;
    output_motor_1 = 0.0;
    output_motor_2 = 0.0;
    Step();
}

static void run_steps(int count)
{
    int i;
    for (i = 0; i < count; ++i) model_step();
}

static int require_true(int condition, const char *message)
{
    if (condition) return 0;
    fprintf(stderr,
        "FAIL: %s (speed=%.3f steer=%.3f servo=%.3f m1=%.3f m2=%.3f)\n",
        message, output_speed, output_steer, output_servo,
        output_motor_1, output_motor_2);
    return 1;
}

static void set_clear_inputs(void)
{
    input_fc = 80.0;
    input_fr = 35.0;
    input_sr = 12.0;
    input_sl = 12.0;
    input_fl = 35.0;
}

static void reset_observers(void)
{
    output_speed = 0.0;
    output_motor_1 = 0.0;
    output_motor_2 = 0.0;
    output_steer = 0.0;
    output_servo = 0.0;
    previous_steer = 0.0;
    max_steer_step = 0.0;
    reverse_seen = 0;
}

static void start_clear(void)
{
    set_clear_inputs();
    reset_observers();
    Init();
    run_steps(20);
}

static int test_clear(void)
{
    start_clear();
    if (require_true(fabs(output_speed - 160.0) < 1e-9,
        "clear five-sensor corridor must use cruise speed 160")) return 1;
    if (require_true(fabs(output_steer) < 1e-9,
        "symmetric forward sectors must steer straight")) return 1;
    if (require_true(fabs(output_servo) < 1e-9,
        "former scanner servo must remain fixed at zero")) return 1;
    return require_true(fabs(output_motor_1 + 160.0) < 1e-9 &&
        fabs(output_motor_2 - 160.0) < 1e-9,
        "official motor polarity must remain ID1 negative and ID2 positive");
}

static int test_outside_warning(void)
{
    start_clear();
    input_fc = 21.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 110.0) < 1e-9,
        "21 cm must slow down but remain outside the 20 cm avoid zone")) return 1;
    return require_true(fabs(output_steer) < 1e-9,
        "21 cm symmetric corridor must not start a locked turn");
}

static int test_clockwise_tie(void)
{
    start_clear();
    input_fc = 19.0;
    run_steps(10);
    if (require_true(fabs(output_speed - 85.0) < 1e-9,
        "19 cm must enter low-speed avoidance")) return 1;
    return require_true(output_steer < -0.29 && output_steer > -0.31,
        "near-tie obstacle must use clockwise right fallback");
}

static int test_left_open(void)
{
    start_clear();
    input_fc = 18.0;
    input_fl = 35.0;
    input_fr = 10.0;
    run_steps(10);
    return require_true(output_steer > 0.29,
        "larger front-left opening must command a left turn");
}

static int test_right_open(void)
{
    start_clear();
    input_fc = 18.0;
    input_fl = 10.0;
    input_fr = 35.0;
    run_steps(10);
    return require_true(output_steer < -0.29,
        "larger front-right opening must command a right turn");
}

static int test_dis2_is_front_right(void)
{
    start_clear();
    input_fc = 18.0;
    input_fr = 5.0;  /* Only dis2 blocked. */
    input_fl = 35.0;
    run_steps(10);
    return require_true(output_steer > 0.29,
        "blocking dis2/front-right must steer vehicle left");
}

static int test_dis5_is_front_left(void)
{
    start_clear();
    input_fc = 18.0;
    input_fl = 5.0;  /* Only dis5 blocked. */
    input_fr = 35.0;
    run_steps(10);
    return require_true(output_steer < -0.29,
        "blocking dis5/front-left must steer vehicle right");
}

static int test_dis4_side_left(void)
{
    start_clear();
    input_sl = 3.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 70.0) < 1e-9,
        "close dis4/side-left must reduce speed")) return 1;
    return require_true(output_steer < -0.50,
        "close dis4/side-left must steer right");
}

static int test_dis3_side_right(void)
{
    start_clear();
    input_sr = 3.0;
    run_steps(8);
    return require_true(output_steer > 0.50,
        "close dis3/side-right must steer left");
}

static int test_continuous_free_space(void)
{
    start_clear();
    input_fl = 35.0;
    input_fr = 15.0;
    run_steps(8);
    return require_true(output_steer > 0.20 && output_steer <= 0.240001,
        "outside avoid zone, forward opening difference must continuously steer left");
}

static int test_normal_deadband(void)
{
    start_clear();
    input_fl = 31.0;
    input_fr = 29.0;
    run_steps(8);
    return require_true(fabs(output_steer) < 1e-9,
        "small forward opening difference must remain in deadband");
}

static int test_raw_emergency(void)
{
    start_clear();
    input_fc = 5.0;
    run_steps(1);
    return require_true(output_speed == 0.0,
        "one valid raw front-centre sample at 5 cm must stop immediately");
}

static int test_no_reverse(void)
{
    start_clear();
    input_fc = 5.0;
    input_fl = 5.0;
    input_fr = 5.0;
    input_sl = 3.0;
    input_sr = 3.0;
    run_steps(30);
    if (require_true(output_speed == 0.0,
        "fully blocked vehicle must stop")) return 1;
    return require_true(!reverse_seen,
        "V3 controller must never command reverse motion");
}

static int test_release_to_straight(void)
{
    start_clear();
    input_fc = 18.0;
    input_fl = 10.0;
    input_fr = 35.0;
    run_steps(10);
    if (require_true(output_steer < -0.29,
        "precondition must establish a right avoidance turn")) return 1;
    set_clear_inputs();
    run_steps(10);
    return require_true(fabs(output_steer) < 1e-9,
        "turn must release and smoothly return to zero when centre clears");
}

static int test_selected_path_veto(void)
{
    start_clear();
    input_fc = 15.0;
    input_fl = 35.0;
    input_fr = 10.0;
    run_steps(8);
    if (require_true(output_steer > 0.35,
        "precondition must establish a left avoidance turn")) return 1;
    input_fl = 4.0;
    input_sl = 3.0;
    input_fr = 35.0;
    input_sr = 12.0;
    run_steps(8);
    return require_true(output_steer < -0.50,
        "new hard danger on selected left path must veto and turn right");
}

static int test_both_sides_narrow(void)
{
    start_clear();
    input_sl = 3.0;
    input_sr = 3.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 70.0) < 1e-9,
        "both close side walls must use slow speed")) return 1;
    return require_true(fabs(output_steer) < 1e-9,
        "symmetric narrow corridor must continue straight, not oscillate");
}

static int test_front_dropout(void)
{
    start_clear();
    input_fc = 0.0;
    run_steps(6);
    return require_true(output_speed == 0.0,
        "persistent invalid front-centre channel must fail safe");
}

static int test_steer_slew(void)
{
    start_clear();
    max_steer_step = 0.0;
    previous_steer = output_steer;
    input_sr = 3.0;
    run_steps(8);
    return require_true(max_steer_step <= 0.120001,
        "steering command change must stay within 0.12 rad per 50 ms");
}

static int test_speed_tiers(void)
{
    start_clear();
    input_fc = 25.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 110.0) < 1e-9,
        "25 cm must use approach speed 110")) return 1;
    input_fc = 18.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 85.0) < 1e-9,
        "18 cm must use avoidance speed 85")) return 1;
    input_fc = 10.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 65.0) < 1e-9,
        "10 cm must use strong-turn speed 65")) return 1;
    input_fc = 7.0;
    run_steps(8);
    return require_true(fabs(output_speed - 55.0) < 1e-9,
        "7 cm must crawl at speed 55 rather than reverse");
}

int main(int argc, char **argv)
{
    const char *name;
    int rc = 1;
    if (argc != 2) {
        fprintf(stderr, "usage: controller_harness <scenario>\n");
        return 2;
    }
    name = argv[1];
    if (!strcmp(name, "clear")) rc = test_clear();
    else if (!strcmp(name, "outside_warning")) rc = test_outside_warning();
    else if (!strcmp(name, "cw_tie")) rc = test_clockwise_tie();
    else if (!strcmp(name, "left_open")) rc = test_left_open();
    else if (!strcmp(name, "right_open")) rc = test_right_open();
    else if (!strcmp(name, "dis2_fr")) rc = test_dis2_is_front_right();
    else if (!strcmp(name, "dis5_fl")) rc = test_dis5_is_front_left();
    else if (!strcmp(name, "dis4_sl")) rc = test_dis4_side_left();
    else if (!strcmp(name, "dis3_sr")) rc = test_dis3_side_right();
    else if (!strcmp(name, "continuous")) rc = test_continuous_free_space();
    else if (!strcmp(name, "deadband")) rc = test_normal_deadband();
    else if (!strcmp(name, "raw_stop")) rc = test_raw_emergency();
    else if (!strcmp(name, "no_reverse")) rc = test_no_reverse();
    else if (!strcmp(name, "release")) rc = test_release_to_straight();
    else if (!strcmp(name, "path_veto")) rc = test_selected_path_veto();
    else if (!strcmp(name, "narrow")) rc = test_both_sides_narrow();
    else if (!strcmp(name, "front_dropout")) rc = test_front_dropout();
    else if (!strcmp(name, "steer_slew")) rc = test_steer_slew();
    else if (!strcmp(name, "speed_tiers")) rc = test_speed_tiers();
    else {
        fprintf(stderr, "unknown scenario: %s\n", name);
        return 2;
    }
    if (rc == 0) printf("PASS: %s\n", name);
    return rc;
}
