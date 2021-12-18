import 'package:flutter/material.dart';
import 'package:workout_tracker/components/smallWidgets/workout_card.dart';
import 'package:workout_tracker/data/data.dart';

class HomepageList extends StatelessWidget {
  const HomepageList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: workouts.length,
      itemBuilder: (context, index) => ItemCard(
        name: workouts[index].workoutName,
        id: workouts[index].id,
      ),
    );
  }
}
