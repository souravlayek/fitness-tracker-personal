import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/components/smallWidgets/workout_card.dart';
import 'package:workout_tracker/data/store.dart';
import 'package:workout_tracker/data/workout.modal.dart';

class HomepageList extends StatefulWidget {
  const HomepageList({
    Key? key,
  }) : super(key: key);

  @override
  State<HomepageList> createState() => _HomepageListState();
}

class _HomepageListState extends State<HomepageList> {
  List<WorkOut> myWorkouts = [];
  @override
  initState() {
    super.initState();
    MyStore store = VxState.store;
    DocumentReference workoutDocument =
        (store.data['myCollection'] as CollectionReference).doc("workout");
    workoutDocument.get().then((value) {
      List<WorkOut> workoutToStore = [];
      value.get("data").forEach((e) => workoutToStore.add(WorkOut.fromMap(e)));
      UpdateMyStore({"workouts": workoutToStore});
      setState(() {
        myWorkouts = workoutToStore;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: myWorkouts.length,
      itemBuilder: (context, index) => ItemCard(
        name: myWorkouts[index].workoutName,
        id: myWorkouts[index].id,
      ),
    );
  }
}
