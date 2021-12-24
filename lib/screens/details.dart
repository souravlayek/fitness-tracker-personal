import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/components/pageWidgets/detailsPage/my_workout_details_card.dart';
import 'package:workout_tracker/data/workout.modal.dart';
import 'package:workout_tracker/utils/helperFunction.dart';
import 'package:workout_tracker/utils/routes.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myObj =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final WorkOut myWorkout = getIndevidualWorkout(myObj["id"] as String);
    final List<WorkoutDone> myWorkoutData =
        getTrackingDataBasedOnWorkout(myWorkout.id);

    return Scaffold(
      appBar: AppBar(
        title: (myWorkout.workoutName).text.bold.make(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoute.addSessionRoute,
                    arguments: <String, String>{"id": myWorkout.id});
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: myWorkoutData.length,
        itemBuilder: (context, index) => MyWorkoutDetailsCard(
          workedOutData: myWorkoutData[index],
        ),
      ),
    );
  }
}


// "blog".text.makeCentered().onInkTap(() {
//                 Navigator.pop(context);
//               }),
