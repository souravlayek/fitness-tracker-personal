import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/components/pageWidgets/detailsPage/each_set_row.dart';
import 'package:workout_tracker/components/smallWidgets/workout_input_form.dart';
import 'package:workout_tracker/data/workout.modal.dart';
import 'package:workout_tracker/utils/helperFunction.dart';

class AddSession extends StatefulWidget {
  const AddSession({Key? key}) : super(key: key);

  @override
  State<AddSession> createState() => _AddSessionState();
}

class _AddSessionState extends State<AddSession> {
  List<TrackingData> trackingDatas = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add your session".text.make(),
      ),
      body: Column(
        children: [
          [
            "Here your last added data".text.bold.size(22).makeCentered(),
            ...trackingDatas
                .map((e) => EachSetRow(
                    weightTaken: getWeightTakenWithUnit(e),
                    reps: e.reps.toString(),
                    sets: e.sets.toString()))
                .toList(),
          ].column(),
          WorkoutInputForm(
            handleSubmit: (TrackingData data) {
              print(data.toString());
            },
          )
        ],
      ),
    );
  }
}
