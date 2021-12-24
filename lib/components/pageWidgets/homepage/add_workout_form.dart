import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/data/store.dart';
import 'package:workout_tracker/data/models.dart';
import 'package:workout_tracker/utils/helperFunction.dart';

class AddWorkoutForm extends StatefulWidget {
  const AddWorkoutForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddWorkoutForm> createState() => _AddWorkoutFormState();
}

class _AddWorkoutFormState extends State<AddWorkoutForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController workout = TextEditingController();

  @override
  void dispose() {
    workout.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get access to the store
    MyStore store = VxState.store;
    List myWorkoutList = [];

    Future<void> addData(String workoutName) async {
      WorkOut myWorkout = WorkOut(id: getRandomId(), workoutName: workoutName);
      DocumentReference workoutDocument =
          (store.data['myCollection'] as CollectionReference).doc("workout");
      await workoutDocument.get().then((value) {
        myWorkoutList = value.get("data");
        List<WorkOut> workoutToStore =
            myWorkoutList.map((e) => WorkOut.fromMap(e)).toList();
        UpdateMyStore({"workouts": workoutToStore});
      });

      workoutDocument
          .set({
            "data": [...myWorkoutList, myWorkout.toMap()]
          })
          .then((value) => context.showToast(msg: "Workout added"))
          .catchError(
              (error) => context.showToast(msg: "Failed to add workout"));
    }

    return Form(
        key: _formKey,
        child: [
          TextFormField(
            decoration: InputDecoration(label: "Workout Name".text.make()),
            autofocus: true,
            controller: workout,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter workout name";
              }
              return null;
            },
          ).pSymmetric(v: 20, h: 30),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  addData(workout.text);
                  workout.text = "";
                }
              },
              child: "Submit".text.make())
        ].column());
  }
}
