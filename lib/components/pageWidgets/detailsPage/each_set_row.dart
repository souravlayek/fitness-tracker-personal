import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/components/smallWidgets/data_with_icon.dart';
import 'package:velocity_x/velocity_x.dart';

class EachSetRow extends StatelessWidget {
  final String weightTaken;
  final String reps;
  final String sets;
  final int index;
  const EachSetRow(
      {Key? key,
      required this.weightTaken,
      required this.reps,
      required this.sets,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      width: double.infinity,
      child: [
        "#${index + 1}".text.bold.make(),
        TextWithIcon(
          icon: Icons.fitness_center,
          value: weightTaken,
        ),
        TextWithIcon(
          icon: CupertinoIcons.clock,
          value: reps,
        ),
        TextWithIcon(
          icon: CupertinoIcons.down_arrow,
          value: sets,
        ),
      ].row(alignment: MainAxisAlignment.spaceAround),
    );
  }
}
