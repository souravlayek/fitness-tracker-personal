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

List<TrackingData> trackingData = [
  TrackingData(
      date: DateTime.now(),
      workout: workouts[0],
      weight: Weight(weight: 50, type: WeightType.kg),
      reps: 10,
      sets: 1),
  TrackingData(
      date: new DateTime(2020),
      workout: workouts[0],
      weight: Weight(weight: 50, type: WeightType.kg),
      reps: 10,
      sets: 1),
  TrackingData(
      date: DateTime.now(),
      workout: workouts[1],
      weight: Weight(weight: 50, type: WeightType.kg),
      reps: 10,
      sets: 1),
  TrackingData(
      date: DateTime.now(),
      workout: workouts[2],
      weight: Weight(weight: 50, type: WeightType.kg),
      reps: 10,
      sets: 1),
  TrackingData(
      date: DateTime.now(),
      workout: workouts[3],
      weight: Weight(weight: 50, type: WeightType.kg),
      reps: 10,
      sets: 1),
];
