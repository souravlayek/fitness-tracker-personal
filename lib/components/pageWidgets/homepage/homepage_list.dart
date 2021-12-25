import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/components/smallWidgets/workout_card.dart';
import 'package:workout_tracker/data/models.dart';
import 'package:workout_tracker/data/store.dart';

class HomepageList extends StatelessWidget {
  const HomepageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    VxState.watch(context, on: [UpdateMyStore]);

    final List<WorkOut> myWorkouts = store.data['workouts'] ?? [];
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
