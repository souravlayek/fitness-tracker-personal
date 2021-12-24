import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/components/pageWidgets/detailsPage/my_workout_details_card.dart';
import 'package:workout_tracker/data/workout.modal.dart';
import 'package:workout_tracker/utils/helperFunction.dart';
import 'package:workout_tracker/utils/routes.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<WorkoutDone> myWorkoutData = [];

  bool isFirstRender = true;
  void updateData(String id) async {
    List<WorkoutDone> myWorkouts = await getTrackingDataBasedOnWorkout(id);
    setState(() {
      myWorkoutData = myWorkouts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final myObj =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final WorkOut myWorkout = getIndevidualWorkout(myObj["id"] as String);
    if (isFirstRender) {
      updateData(myWorkout.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: (myWorkout.workoutName).text.bold.make(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoute.addSessionRoute,
                        arguments: <String, String>{"id": myWorkout.id})
                    .then((value) => updateData(myWorkout.id));
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
