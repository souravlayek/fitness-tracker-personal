import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/data/workout.modal.dart';
import 'package:workout_tracker/utils/helperFunction.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myObj =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final WorkOut myWorkout = getIndevidualWorkout(myObj["id"] as String);
    final List<TrackingData> myTrackingData =
        getTrackingDataBasedOnWorkout(myWorkout.id);

    return Scaffold(
      appBar: AppBar(
        title: (myWorkout.workoutName).text.make(),
      ),
      body: ListView.builder(
        itemCount: myTrackingData.length,
        itemBuilder: (context, index) => MyTrackingDataItem(
          trackingData: myTrackingData[index],
        ),
      ),
    );
  }
}

class MyTrackingDataItem extends StatelessWidget {
  final TrackingData trackingData;
  const MyTrackingDataItem({Key? key, required this.trackingData})
      : super(key: key);

  get weightTaken {
    switch (trackingData.weight.type) {
      case WeightType.kg:
        return "${trackingData.weight.weight.toString()} kg";
      case WeightType.number:
        return "${trackingData.weight.weight.toString()} nos";
      case WeightType.pound:
        return "${trackingData.weight.weight.toString()} lb";
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (DateFormat("d EEE").format(trackingData.date))
          .text
          .makeCentered()
          .box
          .roundedFull
          .blue300
          .make()
          .w(90)
          .h(90),
      title: [
        TrackedDataItems(
          icon: Icons.fitness_center,
          value: weightTaken,
        ),
        TrackedDataItems(
          icon: CupertinoIcons.clock,
          value: trackingData.reps.toString(),
        ),
        TrackedDataItems(
          icon: CupertinoIcons.down_arrow,
          value: weightTaken,
        ),
      ].row(alignment: MainAxisAlignment.spaceAround),
    )
        .box
        .padding(EdgeInsets.symmetric(vertical: 5, horizontal: 2))
        .margin(EdgeInsets.symmetric(vertical: 5))
        .make()
        .card
        .make();
  }
}

class TrackedDataItems extends StatelessWidget {
  final IconData icon;
  final String value;
  const TrackedDataItems({Key? key, required this.icon, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 5,
        ),
        (value).text.make()
      ],
    );
  }
}
