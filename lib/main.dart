import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.white,
        title: "Workout Tracker".text.bold.black.make(),
        elevation: 2,
        centerTitle: true,
      ),
      body: [
        WorkoutItem(
          workoutName: "Decline benchpress",
        ),
      ]
          .column(crossAlignment: CrossAxisAlignment.center)
          .box
          .width(context.screenWidth)
          .height(context.screenHeight)
          .make(),
    );
  }
}

class WorkoutItem extends StatelessWidget {
  final String workoutName;
  const WorkoutItem({Key? key, required this.workoutName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (workoutName)
            .text
            .bold
            .makeCentered()
            .card
            .make()
            .h(30)
            .w(context.screenWidth * 0.9),
        box.height(20).make()
      ],
    );
  }
}
