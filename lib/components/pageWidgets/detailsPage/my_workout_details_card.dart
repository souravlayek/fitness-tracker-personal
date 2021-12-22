import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker/components/pageWidgets/detailsPage/each_set_row.dart';
import 'package:workout_tracker/data/workout.modal.dart';
import 'package:workout_tracker/utils/helperFunction.dart';
import 'package:velocity_x/velocity_x.dart';

class MyWorkoutDetailsCard extends StatelessWidget {
  final WorkoutDone workedOutData;
  const MyWorkoutDetailsCard({Key? key, required this.workedOutData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            DateFormat("d EEE").format(workedOutData.workedOutAt),
            textAlign: TextAlign.center,
          ).w(double.infinity).box.p12.blue100.make(),
          Column(
            children: workedOutData.workoutSets
                .mapIndexed((e, index) => EachSetRow(
                    index: index,
                    weightTaken: getWeightTakenWithUnit(e),
                    reps: e.reps.toString(),
                    sets: e.sets.toString()))
                .toList(),
          )
        ],
      ),
    );
  }
}
