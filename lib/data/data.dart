import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';
import './workout.modal.dart';

var uuid = Uuid();

List<WorkOut> workouts = [
  WorkOut(id: uuid.v4(), workoutName: "Flat Bench Press"),
  WorkOut(id: uuid.v4(), workoutName: "Inclined Bench Press"),
  WorkOut(id: uuid.v4(), workoutName: "Inclined dumble Press"),
  WorkOut(id: uuid.v4(), workoutName: "Declined dumble Press"),
  WorkOut(id: uuid.v4(), workoutName: "Declined bench Press"),
];

List<Color> colors = [Vx.amber400, Vx.green400, Vx.blue400, Vx.purple400];

List<WorkoutDone> workedOutData = [
  WorkoutDone(
    workout: workouts[0],
    workedOutAt: DateTime.now(),
    workoutSets: [
      TrackingData(
          weight: Weight(weight: 50, type: WeightType.kg), reps: 10, sets: 1),
      TrackingData(
          weight: Weight(weight: 50, type: WeightType.kg), reps: 10, sets: 1),
      TrackingData(
          weight: Weight(weight: 50, type: WeightType.kg), reps: 10, sets: 1),
    ],
  )
];
