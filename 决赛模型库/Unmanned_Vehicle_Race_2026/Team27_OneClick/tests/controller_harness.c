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
static int reverse_steps = 0;
static int reverse_episodes = 0;
static int was_reversing = 0;

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
    if (id == 2 && speed < -1e-9) reverse_steps++;
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
    int now_reversing;
    output_speed = 0.0;
    output_motor_1 = 0.0;
    output_motor_2 = 0.0;
    Step();
    now_reversing = output_motor_2 < -1e-9;
    if (now_reversing && !was_reversing) reverse_episodes++;
    was_reversing = now_reversing;
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
    reverse_steps = 0;
    reverse_episodes = 0;
    was_reversing = 0;
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
    input_fc = 27.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 140.0) < 1e-9,
        "27 cm approach must retain speed 140 outside the avoid zone")) return 1;
    return require_true(fabs(output_steer) < 1e-9,
        "27 cm symmetric corridor must not start a locked turn");
}

static int test_clockwise_tie(void)
{
    start_clear();
    input_fc = 25.0;
    run_steps(10);
    if (require_true(fabs(output_speed - 130.0) < 1e-9,
        "25 cm early avoidance must retain useful speed 130")) return 1;
    return require_true(output_steer < -0.47 && output_steer > -0.49,
        "near-tie obstacle must use clockwise right fallback");
}

static int test_left_open(void)
{
    start_clear();
    input_fc = 18.0;
    input_fl = 35.0;
    input_fr = 10.0;
    run_steps(10);
    return require_true(output_steer > 0.55,
        "larger front-left opening must command a left turn");
}

static int test_right_open(void)
{
    start_clear();
    input_fc = 18.0;
    input_fl = 10.0;
    input_fr = 35.0;
    run_steps(10);
    return require_true(output_steer < -0.55,
        "larger front-right opening must command a right turn");
}

static int test_dis2_is_front_right(void)
{
    start_clear();
    input_fc = 18.0;
    input_fr = 10.0;  /* Only dis2 restricted, outside wedge range. */
    input_fl = 35.0;
    run_steps(10);
    return require_true(output_steer > 0.55,
        "blocking dis2/front-right must steer vehicle left");
}

static int test_dis5_is_front_left(void)
{
    start_clear();
    input_fc = 18.0;
    input_fl = 10.0;  /* Only dis5 restricted, outside wedge range. */
    input_fr = 35.0;
    run_steps(10);
    return require_true(output_steer < -0.55,
        "blocking dis5/front-left must steer vehicle right");
}

static int test_dis4_side_left(void)
{
    start_clear();
    input_sl = 3.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 90.0) < 1e-9,
        "close dis4/side-left must reduce speed")) return 1;
    return require_true(output_steer < -0.56,
        "close dis4/side-left must steer right");
}

static int test_dis3_side_right(void)
{
    start_clear();
    input_sr = 3.0;
    run_steps(8);
    return require_true(output_steer > 0.56,
        "close dis3/side-right must steer left");
}

static int test_early_diagonal_turn(void)
{
    start_clear();
    input_fc = 35.0;
    input_fl = 12.0;
    input_fr = 35.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 100.0) < 1e-9,
        "front-left diagonal warning must keep useful cornering speed")) return 1;
    return require_true(output_steer < -0.55,
        "front-left diagonal warning must start an early right turn");
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

static int test_confirmed_backup(void)
{
    start_clear();
    input_fc = 5.0;
    input_fl = 8.0;
    input_fr = 8.0;
    run_steps(1);
    if (require_true(output_speed == 0.0,
        "first valid close sample must stop before reversing")) return 1;
    if (require_true(!reverse_seen,
        "one close sample must not trigger reverse")) return 1;
    run_steps(2);
    if (require_true(output_speed == 0.0 && !reverse_seen,
        "confirmed obstacle must stop and centre before reversing")) return 1;
    run_steps(3);
    if (require_true(reverse_seen && fabs(output_speed - 55.0) < 1e-9,
        "confirmed stop must begin backup within 0.30 s")) return 1;
    if (require_true(output_motor_1 > 54.9 && output_motor_2 < -54.9,
        "backup must use the calibrated reverse motor polarity")) return 1;
    return require_true(fabs(output_steer) < 1e-9,
        "the initial reverse disengagement phase must remain straight");
}

static int test_backup_retry_limit(void)
{
    start_clear();
    input_fc = 5.0;
    input_fl = 8.0;
    input_fr = 8.0;
    run_steps(80);
    if (require_true(reverse_seen,
        "persistent valid close obstacle must produce recovery backup")) return 1;
    if (require_true(reverse_episodes == 2,
        "one uncleared obstacle may use exactly two bounded recovery attempts")) return 1;
    if (require_true(reverse_steps >= 32 && reverse_steps <= 50,
        "two bounded backups must each honour their finite time cap")) return 1;
    return require_true(output_speed == 0.0,
        "same uncleared obstacle must stop after the two-attempt safety limit");
}

static int test_backup_distance_release(void)
{
    start_clear();
    input_fc = 5.0;
    input_fl = 8.0;
    input_fr = 8.0;
    run_steps(8);
    if (require_true(reverse_seen,
        "precondition must enter backup")) return 1;
    input_fc = 13.0;
    input_fl = 35.0;
    input_fr = 12.0;
    run_steps(24);
    if (require_true(reverse_steps >= 16,
        "clearance recovery must not cancel the mandatory reverse distance")) return 1;
    if (require_true(output_motor_1 < -1.0 && output_motor_2 > 1.0,
        "front clearance above 12 cm must release backup and resume forward")) return 1;
    return require_true(output_steer > 0.55,
        "post-backup escape must discard the old choice and rescan current geometry");
}

static int test_backup_countersteers_for_right_escape(void)
{
    start_clear();
    input_fc = 5.0;
    input_fl = 8.0;
    input_fr = 35.0;
    run_steps(24);
    if (require_true(reverse_seen,
        "persistent close obstacle with open right path must enter backup")) return 1;
    return require_true(output_steer > 0.30,
        "reverse for a forward-right escape must counter-steer left");
}

static int test_backup_countersteers_for_left_escape(void)
{
    start_clear();
    input_fc = 5.0;
    input_fl = 35.0;
    input_fr = 8.0;
    run_steps(24);
    if (require_true(reverse_seen,
        "persistent close obstacle with open left path must enter backup")) return 1;
    return require_true(output_steer < -0.30,
        "reverse for a forward-left escape must counter-steer right");
}

static int test_tight_stationary_stop_uses_backup(void)
{
    start_clear();
    input_fc = 16.0;
    input_fl = 14.0;
    input_fr = 14.0;
    input_sl = 6.0;
    input_sr = 6.0;
    run_steps(10);
    return require_true(reverse_seen,
        "a valid tight stop with both swept paths blocked must reverse-reset");
}

static int test_narrow_open_ray_rejected(void)
{
    start_clear();
    input_fc = 18.0;
    input_fl = 15.0;
    input_sl = 12.0;
    input_fr = 35.0; /* Long ray alone must not win. */
    input_sr = 5.5;  /* Physical right-side gap is too narrow to turn into. */
    run_steps(10);
    return require_true(output_steer > 0.55,
        "long front-right echo must not override narrow side-right clearance");
}

static int test_invalid_ray_not_open(void)
{
    start_clear();
    input_fc = 18.0;
    input_fl = 18.0;
    input_fr = 0.0;
    run_steps(12);
    return require_true(output_steer > 0.55,
        "persistent missing front-right echo must not be treated as 40 cm open space");
}

static int test_single_front_corner_turnaway(void)
{
    start_clear();
    input_fc = 30.0;
    input_fl = 4.0;
    input_fr = 35.0;
    run_steps(6);
    if (require_true(!reverse_seen,
        "one close front corner must receive a turn-away attempt before reverse")) return 1;
    if (require_true(fabs(output_speed - 45.0) < 1e-9,
        "one close front corner with an open opposite path must turn away slowly")) return 1;
    return require_true(output_steer < -0.56,
        "close front-left corner must command maximum right turn-away");
}

static int test_persistent_extreme_corner_escape(void)
{
    start_clear();
    input_fc = 30.0;
    input_fl = 4.0;
    input_fr = 35.0;
    run_steps(26);
    return require_true(reverse_seen,
        "an extreme corner that survives the timed turn-away must trigger one backup");
}

static int test_transient_extreme_corner_no_backup(void)
{
    start_clear();
    input_fc = 30.0;
    input_fl = 4.0;
    input_fr = 35.0;
    run_steps(6);
    set_clear_inputs();
    run_steps(24);
    return require_true(!reverse_seen,
        "a transient extreme corner that clears during turn-away must not reverse");
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
    if (require_true(output_steer > 0.55,
        "precondition must establish a left avoidance turn")) return 1;
    input_fl = 8.0;
    input_sl = 6.0;
    input_fr = 35.0;
    input_sr = 12.0;
    run_steps(8);
    return require_true(output_steer < -0.45,
        "new narrow bottleneck on selected left path must veto and turn right");
}

static int test_static_single_corner_not_backup(void)
{
    start_clear();
    input_fc = 25.0;
    input_fl = 6.0;
    input_fr = 35.0;
    input_sl = 12.0;
    input_sr = 12.0;
    run_steps(20);
    if (require_true(!reverse_seen,
        "a static isolated front corner must not be mistaken for a trapped pocket")) return 1;
    return require_true(output_steer < -0.55,
        "a static isolated front-left corner must continue turning right");
}

static int test_moving_bend_not_wedge(void)
{
    int i;
    start_clear();
    input_fl = 6.0;
    input_fr = 35.0;
    input_sl = 12.0;
    input_sr = 12.0;
    for (i = 0; i < 24; ++i) {
        /* The close corner stays constant, but another ray proves motion. */
        input_fc = 25.0 + (double)i;
        model_step();
    }
    return require_true(!reverse_seen,
        "changing multi-ray bend geometry must not be misclassified as stuck");
}

static int test_both_sides_narrow(void)
{
    start_clear();
    input_sl = 3.0;
    input_sr = 3.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 90.0) < 1e-9,
        "both close side walls must use slow speed")) return 1;
    return require_true(fabs(output_steer) < 1e-9,
        "symmetric narrow corridor must continue straight, not oscillate");
}

static int test_parallel_corridor_release(void)
{
    start_clear();
    input_fc = 35.0;
    input_fl = 18.0;
    input_fr = 18.0;
    input_sl = 3.0;
    input_sr = 3.0;
    run_steps(12);
    if (require_true(!reverse_seen,
        "parallel side walls with a clear forward sector must not reverse")) return 1;
    if (require_true(fabs(output_speed - 90.0) < 1e-9,
        "parallel narrow corridor must keep enough speed to leave the boundary")) return 1;
    return require_true(fabs(output_steer) < 1e-9,
        "symmetric parallel corridor must drive straight instead of remaining stopped");
}

static int test_front_dropout(void)
{
    start_clear();
    input_fc = 0.0;
    run_steps(6);
    if (require_true(output_speed == 0.0,
        "persistent invalid front-centre channel must fail safe")) return 1;
    return require_true(!reverse_seen,
        "invalid front-centre data must never trigger blind reverse");
}

static int test_centre_plus_one_corner_delayed_backup(void)
{
    start_clear();
    input_fc = 5.0;
    input_fl = 4.0;
    input_fr = 35.0;
    input_sl = 12.0;
    input_sr = 12.0;
    run_steps(6);
    if (require_true(!reverse_seen,
        "centre plus one corner must first try the open path before reverse")) return 1;
    if (require_true(fabs(output_speed - 45.0) < 1e-9,
        "centre emergency may use only the guarded low-speed open-path escape")) return 1;
    if (require_true(output_steer < -0.56,
        "centre plus front-left blockage must turn strongly into the open right path")) return 1;
    run_steps(20);
    return require_true(reverse_seen,
        "persistent centre plus one-corner contact must escape by one delayed backup");
}

static int test_blocked_paths_never_push_forward(void)
{
    start_clear();
    input_fc = 35.0; /* Centre ray passes through the misleading slit. */
    input_fl = 8.0;
    input_fr = 8.0;
    input_sl = 12.0;
    input_sr = 12.0;
    run_steps(2);
    if (require_true(output_speed == 0.0 && !reverse_seen,
        "two forbidden swept paths must stop instead of crawling into the slit")) return 1;
    run_steps(6);
    return require_true(reverse_seen,
        "confirmed two-sided pocket must enter bounded backup even when centre is open");
}

static int test_front_corner_drives_turn_tier(void)
{
    start_clear();
    input_fc = 35.0;
    input_fl = 12.0;
    input_fr = 35.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 100.0) < 1e-9,
        "closest front corner, not open centre, must select speed tier")) return 1;
    return require_true(output_steer < -0.55,
        "closest front corner, not open centre, must demand strong turn-away");
}

static int test_steer_slew(void)
{
    start_clear();
    max_steer_step = 0.0;
    previous_steer = output_steer;
    input_sr = 3.0;
    run_steps(8);
    return require_true(max_steer_step <= 0.160001,
        "steering command change must stay within 0.16 rad per 50 ms");
}

static int test_speed_tiers(void)
{
    start_clear();
    input_fc = 27.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 140.0) < 1e-9,
        "27 cm must use approach speed 140")) return 1;
    input_fc = 20.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 130.0) < 1e-9,
        "20 cm must use open-turn speed 130")) return 1;
    input_fc = 10.0;
    run_steps(8);
    if (require_true(fabs(output_speed - 70.0) < 1e-9,
        "10 cm must use near-obstacle speed 70")) return 1;
    input_fc = 7.0;
    run_steps(8);
    return require_true(fabs(output_speed - 45.0) < 1e-9,
        "7 cm must crawl at speed 45 rather than reverse");
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
    else if (!strcmp(name, "early_diagonal")) rc = test_early_diagonal_turn();
    else if (!strcmp(name, "deadband")) rc = test_normal_deadband();
    else if (!strcmp(name, "raw_stop")) rc = test_raw_emergency();
    else if (!strcmp(name, "backup")) rc = test_confirmed_backup();
    else if (!strcmp(name, "backup_retry_limit")) rc = test_backup_retry_limit();
    else if (!strcmp(name, "backup_release")) rc = test_backup_distance_release();
    else if (!strcmp(name, "backup_right_arc")) rc = test_backup_countersteers_for_right_escape();
    else if (!strcmp(name, "backup_left_arc")) rc = test_backup_countersteers_for_left_escape();
    else if (!strcmp(name, "tight_stop_backup")) rc = test_tight_stationary_stop_uses_backup();
    else if (!strcmp(name, "narrow_ray")) rc = test_narrow_open_ray_rejected();
    else if (!strcmp(name, "invalid_ray")) rc = test_invalid_ray_not_open();
    else if (!strcmp(name, "corner_turnaway")) rc = test_single_front_corner_turnaway();
    else if (!strcmp(name, "persistent_corner")) rc = test_persistent_extreme_corner_escape();
    else if (!strcmp(name, "transient_corner")) rc = test_transient_extreme_corner_no_backup();
    else if (!strcmp(name, "release")) rc = test_release_to_straight();
    else if (!strcmp(name, "path_veto")) rc = test_selected_path_veto();
    else if (!strcmp(name, "static_single")) rc = test_static_single_corner_not_backup();
    else if (!strcmp(name, "moving_bend")) rc = test_moving_bend_not_wedge();
    else if (!strcmp(name, "narrow")) rc = test_both_sides_narrow();
    else if (!strcmp(name, "parallel_corridor")) rc = test_parallel_corridor_release();
    else if (!strcmp(name, "front_dropout")) rc = test_front_dropout();
    else if (!strcmp(name, "centre_one_side")) rc = test_centre_plus_one_corner_delayed_backup();
    else if (!strcmp(name, "blocked_paths")) rc = test_blocked_paths_never_push_forward();
    else if (!strcmp(name, "corner_tier")) rc = test_front_corner_drives_turn_tier();
    else if (!strcmp(name, "steer_slew")) rc = test_steer_slew();
    else if (!strcmp(name, "speed_tiers")) rc = test_speed_tiers();
    else {
        fprintf(stderr, "unknown scenario: %s\n", name);
        return 2;
    }
    if (rc == 0) printf("PASS: %s\n", name);
    return rc;
}
