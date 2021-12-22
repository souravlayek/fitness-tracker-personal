import 'package:flutter/cupertino.dart';
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
        actions: [
          IconButton(
              onPressed: () {
                print("saveAllData");
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
              print(data.toString());
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
