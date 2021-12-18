import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/components/pageWidgets/homepage/homepage_list.dart';

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
        body: HomepageList());
  }
}
