import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/components/pageWidgets/homepage/add_workout_form.dart';
import 'package:workout_tracker/components/pageWidgets/homepage/homepage_list.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Vx.white,
          title: "Workout Tracker".text.bold.make(),
          actions: [
            IconButton(
                onPressed: () {
                  _showModalBottomSheet(context);
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                )),
          ],
          elevation: 2,
          centerTitle: true,
        ),
        body: const HomepageList());
  }
}

void _showModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(children: [
          Container(
            padding: EdgeInsets.zero,
            height: context.screenHeight * 0.9,
            child: [
              [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ].row(alignment: MainAxisAlignment.end).w(double.infinity),
              "Add a new workout".text.bold.size(22).make(),
              const AddWorkoutForm()
            ].column(),
          )
        ]);
      },
      isDismissible: false,
      isScrollControlled: true);
}
