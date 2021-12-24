import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/components/pageWidgets/homepage/homepage_list.dart';
import 'package:workout_tracker/data/store.dart';
import 'package:workout_tracker/data/workout.modal.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Vx.white,
          title: "Workout Tracker".text.bold.make(),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Wrap(children: [
                          Container(
                            padding: EdgeInsets.zero,
                            height: context.screenHeight * 0.9,
                            child: [
                              [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.close))
                              ]
                                  .row(alignment: MainAxisAlignment.end)
                                  .w(double.infinity),
                              "Add a new workout".text.bold.size(22).make(),
                              const AddWorkoutForm()
                            ].column(),
                          )
                        ]);
                      },
                      isDismissible: false,
                      isScrollControlled: true);
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                )),
          ],
          elevation: 2,
          centerTitle: true,
        ),
        body: const HomepageList());
  }
}

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
  Widget build(BuildContext context) {
    // Get access to the store
    MyStore store = VxState.store;
    List myWorkoutList = [];

    Future<void> addData(String workoutName) async {
      // Call the user's CollectionReference to add a new user
      WorkOut myWorkout = WorkOut(id: uuid.v4(), workoutName: workoutName);
      DocumentReference workoutDocument =
          (store.data['myCollection'] as CollectionReference).doc("workout");
      await workoutDocument.get().then((value) {
        myWorkoutList = value.get("data");
        List<WorkOut> workoutToStore =
            myWorkoutList.map((e) => WorkOut.fromMap(e)).toList();
        UpdateMyStore({"workouts": workoutToStore});
      });

      workoutDocument
          .update({
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
