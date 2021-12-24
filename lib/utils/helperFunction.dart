import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/data/data.dart';
import 'package:workout_tracker/data/store.dart';

import 'dart:math' as math;

import 'package:workout_tracker/data/workout.modal.dart';

Color getRandomColor() {
  return colors[math.Random().nextInt(colors.length)];
}

WorkOut getIndevidualWorkout(String id) {
  MyStore store = VxState.store;
  List<WorkOut> workouts = store.data['workouts'];
  if (workouts.isNotEmpty) {
    return workouts.firstWhere((element) => element.id == id);
  }
  throw Exception("Something went wrong");
}

List<WorkoutDone> getTrackingDataBasedOnWorkout(String id) {
  return workedOutData.where((e) => e.workout.id == id).toList();
}

String getWeightTakenWithUnit(TrackingData trackingData) {
  switch (trackingData.weight.type) {
    case WeightType.kg:
      return "${trackingData.weight.weight.toString()} kg";
    case WeightType.number:
      return "${trackingData.weight.weight.toString()} nos";
    case WeightType.pound:
      return "${trackingData.weight.weight.toString()} lb";
    case WeightType.bodyWeight:
      return "No weight";
    default:
      return "";
  }
}

// ============================= [[FIREBASE]] ===================================

// import 'package:cloud_firestore/cloud_firestore.dart';

    // Future<void> getData() async {
    //   CollectionReference data =
    //       FirebaseFirestore.instance.collection('dummycollection');
    //   return await data.get().then((value) {
    //     value.docs.forEach((e) => print(e.data()));
    //   }).catchError((error) => print("Failed to add user: $error"));
    // }
