import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/data/store.dart';
import 'package:workout_tracker/data/models.dart';
import 'package:workout_tracker/utils/helperFunction.dart';

class AddWorkoutForm extends StatefulWidget {
  final Function onUpdate;
  const AddWorkoutForm({
    Key? key,
    required this.onUpdate,
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
    MyStore store = VxState.store;

    Future<void> addData(String workoutName) async {
      WorkOut myWorkout = WorkOut(id: getRandomId(), workoutName: workoutName);
      DocumentReference workoutDocument =
          (store.data['myCollection'] as CollectionReference).doc("workout");

      List<WorkOut> myWorkoutList = [];
      if (store.data['workouts'] != null) {
        myWorkoutList = store.data['workouts'];
      }
      workoutDocument.set({
        "data": [
          ...myWorkoutList.map((e) => e.toMap()).toList(),
          myWorkout.toMap()
        ]
      }).then((value) {
        context.showToast(msg: "Workout added");
        widget.onUpdate();
      }).catchError((error) {
        context.showToast(msg: "Failed to add workout");
      });
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
