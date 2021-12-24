import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/data/data.dart';
import 'package:workout_tracker/data/store.dart';

import 'dart:math' as math;

import 'package:workout_tracker/data/models.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

Color getRandomColor() {
  return colors[math.Random().nextInt(colors.length)];
}

String getRandomId() {
  return uuid.v4();
}

Future<void> setDataToLocalStorage(String key, dynamic value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<dynamic> getDataFromLocalStorage(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic data = (prefs.getString(key));
  return data;
}

WorkOut getIndevidualWorkout(String id) {
  MyStore store = VxState.store;
  List<WorkOut> workouts = store.data['workouts'];
  if (workouts.isNotEmpty) {
    return workouts.firstWhere((element) => element.id == id);
  }
  throw Exception("Something went wrong");
}

Future<List<WorkoutDone>> getTrackingDataBasedOnWorkout(String id) async {
  MyStore store = VxState.store;
  DocumentReference workoutDocument =
      (store.data['myCollection'] as CollectionReference).doc("mySession");
  List<WorkoutDone> workedOutData = [];
  await workoutDocument.get().then((value) {
    value.get("data").forEach((e) => workedOutData.add(WorkoutDone.fromMap(e)));
  });
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
