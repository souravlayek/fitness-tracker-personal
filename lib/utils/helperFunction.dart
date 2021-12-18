import 'package:flutter/material.dart';
import 'package:workout_tracker/data/data.dart';

import 'dart:math' as math;

import 'package:workout_tracker/data/workout.modal.dart';

Color getRandomColor() {
  return colors[math.Random().nextInt(colors.length)];
}

WorkOut getIndevidualWorkout(String id) {
  return workouts.firstWhere((element) => element.id == id);
}

List<TrackingData> getTrackingDataBasedOnWorkout(String id) {
  return trackingData.where((e) => e.workout.id == id).toList();
}
