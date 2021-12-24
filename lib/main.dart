import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/screens/addSession.dart';
import 'package:workout_tracker/screens/details.dart';
import 'package:workout_tracker/screens/homepage.dart';
import 'package:workout_tracker/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        appBarTheme: const AppBarTheme(
            actionsIconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 5,
            centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black)),
      ),
      initialRoute: MyRoute.homeRoute,
      routes: {
        "/": (context) => const MyHomePage(),
        MyRoute.homeRoute: (context) => const MyHomePage(),
        MyRoute.detailsRoute: (context) => const DetailsPage(),
        MyRoute.addSessionRoute: (context) => const AddSession(),
      },
    );
  }
}
