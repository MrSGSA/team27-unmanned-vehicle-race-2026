#include "for_code_JGB520_Team27.h"
/*** Current Block Name: ObsAvoidController_Team27_FFLFRR.controllerStep ***/
#include <math.h>

static int team27_state = 0;

static int team27_direction = 1;

static int team27_danger_count = 0;

static int team27_hold_count = 0;

static int team27_clear_count = 0;



static double team27_clip_distance(double d)

{

  d = fabs(d);

  if (!isfinite(d) || d <= 0.0) return 1.0;

  if (d > 300.0) return 300.0;

  return d;

}



void Team27_ControllerStep(double frontRaw, double unusedRaw,

  double rightRaw, double leftRaw, double rearRaw,

  double* speedOut, double* steerOut)

{

  const double speedCruise = 30.0;

  const double speedCaution = 20.0;

  const double speedAvoid = 15.0;

  const double speedCrawl = 8.0;

  const double frontWarn = 100.0;

  const double frontEmergency = 40.0;

  const double frontStop = 25.0;

  const double frontClear = 130.0;

  const double diagonalWarn = 48.0;

  const double diagonalStop = 18.0;

  const double diagonalClear = 65.0;

  const double deadband = 6.0;

  const double diagonalGain = 0.0034;

  const double nearGain = 0.26;

  const double switchMargin = 28.0;

  const double avoidSteer = 0.28;

  const double emergencySteer = 0.42;

  const double maxSteer = 0.45;

  const int confirmSamples = 2;

  const int minAvoidSamples = 14;

  const int clearSamples = 5;

  double front = team27_clip_distance(frontRaw);

  double left = team27_clip_distance(leftRaw);

  double right = team27_clip_distance(rightRaw);

  double diagonalMin = left < right ? left : right;

  double error = left - right;

  double correction = fabs(error) <= deadband ? 0.0 :

    diagonalGain * (error - (error > 0.0 ? deadband : -deadband));

  double nearCorrection = 0.0;

  double steer;

  (void)unusedRaw;

  (void)rearRaw;



  if (left < diagonalWarn)

    nearCorrection -= nearGain * (diagonalWarn-left)/diagonalWarn;

  if (right < diagonalWarn)

    nearCorrection += nearGain * (diagonalWarn-right)/diagonalWarn;



  if (front <= frontStop ||

      (left <= diagonalStop && right <= diagonalStop)) {

    team27_state = 4;

    team27_clear_count = 0;

  } else if (front <= frontEmergency) {

    team27_direction = left >= right ? 1 : 2;

    team27_state = 3;

    team27_hold_count++;

    team27_clear_count = 0;

  } else if (team27_state == 4) {

    if (front > frontEmergency &&

        (left > diagonalStop || right > diagonalStop)) {

      team27_state = team27_direction;

      team27_danger_count = 0;

      team27_hold_count = 0;

    }

  } else if (team27_state == 1 || team27_state == 2 || team27_state == 3) {

    if (team27_state == 1 && right > left + switchMargin) {

      team27_state = team27_direction = 2;

      team27_hold_count = team27_clear_count = 0;

    } else if (team27_state == 2 && left > right + switchMargin) {

      team27_state = team27_direction = 1;

      team27_hold_count = team27_clear_count = 0;

    } else if (front >= frontClear && left >= diagonalClear &&

               right >= diagonalClear) {

      team27_clear_count++;

      if (team27_hold_count >= minAvoidSamples &&

          team27_clear_count >= clearSamples) {

        team27_state = 0;

        team27_hold_count = team27_clear_count = 0;

      } else {

        team27_state = team27_direction;

        team27_hold_count++;

      }

    } else {

      team27_state = team27_direction;

      team27_hold_count++;

      team27_clear_count = 0;

    }

  } else if (front <= frontWarn || left <= diagonalWarn ||

             right <= diagonalWarn) {

    team27_danger_count++;

    if (team27_danger_count >= confirmSamples) {

      if (left <= diagonalWarn && right > left) team27_direction = 2;

      else if (right <= diagonalWarn && left > right) team27_direction = 1;

      else team27_direction = left >= right ? 1 : 2;

      team27_state = team27_direction;

      team27_danger_count = team27_hold_count = team27_clear_count = 0;

    }

  } else {

    team27_state = 0;

    team27_danger_count = team27_hold_count = team27_clear_count = 0;

  }



  if (team27_state == 4) steer = 0.0;

  else if (team27_state == 3)

    steer = (team27_direction == 1 ? emergencySteer : -emergencySteer) +

      0.20*correction + nearCorrection;

  else if (team27_state == 1)

    steer = avoidSteer + 0.25*correction + nearCorrection;

  else if (team27_state == 2)

    steer = -avoidSteer + 0.25*correction + nearCorrection;

  else steer = correction + nearCorrection;



  if (steer > maxSteer) steer = maxSteer;

  if (steer < -maxSteer) steer = -maxSteer;

  *steerOut = steer;

  if (team27_state == 4) *speedOut = 0.0;

  else if (team27_state == 3) *speedOut = speedCrawl;

  else if (team27_state == 1 || team27_state == 2) *speedOut = speedAvoid;

  else if (front < frontClear || diagonalMin < diagonalClear ||

           fabs(steer) > 0.16) *speedOut = speedCaution;

  else *speedOut = speedCruise;

}
