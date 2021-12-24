import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/components/pageWidgets/detailsPage/each_set_row.dart';
import 'package:workout_tracker/components/smallWidgets/workout_input_form.dart';
import 'package:workout_tracker/data/store.dart';
import 'package:workout_tracker/data/workout.modal.dart';
import 'package:workout_tracker/utils/helperFunction.dart';

class AddSession extends StatefulWidget {
  const AddSession({Key? key}) : super(key: key);

  @override
  State<AddSession> createState() => _AddSessionState();
}

class _AddSessionState extends State<AddSession> {
  List<TrackingData> trackingDatas = [];
  Future<void> addData(WorkoutDone myWorkout) async {
    MyStore store = VxState.store;
    DocumentReference workoutDocument =
        (store.data['myCollection'] as CollectionReference).doc("mySession");
    List<dynamic> workoutToStore = [];
    await workoutDocument.get().then((value) {
      dynamic myValue = value.get("data");
      myValue.forEach((e) => workoutToStore.add(e));
    });
    await workoutDocument
        .set({
          "data": [...workoutToStore, myWorkout.toMap()]
        })
        .then((value) => context.showToast(msg: "Workout added"))
        .catchError((error) {
          context.showToast(msg: "Failed to add workout");
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add your session".text.bold.make(),
        actions: [
          IconButton(
              onPressed: () async {
                final myObj = ModalRoute.of(context)!.settings.arguments
                    as Map<String, String>;
                final WorkOut myWorkout =
                    getIndevidualWorkout(myObj["id"] as String);
                WorkoutDone workoutDone = WorkoutDone(
                    workout: myWorkout,
                    workedOutAt: DateTime.now(),
                    workoutSets: trackingDatas);
                await addData(workoutDone);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save_alt_outlined))
        ],
      ),
      body: Column(
        children: [
          [
            "Here are your last added data".text.bold.size(22).makeCentered(),
            [
              ...trackingDatas
                  .mapIndexed((e, index) => EachSetRow(
                      index: index,
                      weightTaken: getWeightTakenWithUnit(e),
                      reps: e.reps.toString(),
                      sets: e.sets.toString()))
                  .toList()
            ]
                .column()
                .box
                .blueGray300
                .margin(const EdgeInsets.symmetric(vertical: 20))
                .withConstraints(const BoxConstraints(
                    minHeight: 100, minWidth: double.infinity))
                .make(),
          ].column(),
          WorkoutInputForm(
            handleSubmit: (TrackingData data) {
              setState(() {
                trackingDatas.add(data);
              });
            },
          )
        ],
      ).pSymmetric(v: 20, h: 10),
    );
  }
}
