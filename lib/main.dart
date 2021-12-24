import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/data/store.dart';
import 'package:workout_tracker/data/workout.modal.dart';
import 'package:workout_tracker/screens/addSession.dart';
import 'package:workout_tracker/screens/details.dart';
import 'package:workout_tracker/screens/homepage.dart';
import 'package:workout_tracker/utils/routes.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

Future<String> _getMyAccountAddress() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String myAccountAddress = (prefs.getString('myAccountAddress') ?? ""); //
  return myAccountAddress;
}

Future<String> _createMyAccountAddress() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String myAccountAddress = uuid.v4();
  await prefs.setString('myAccountAddress', myAccountAddress);
  return myAccountAddress;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String myAddress = await _getMyAccountAddress();
  if (myAddress.isEmpty) {
    myAddress = await _createMyAccountAddress();
  }
  runApp(VxState(store: MyStore(myAddress), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [UpdateMyStore]);
    MyStore store = VxState.store;
    if (store.data['myCollection'] == null) {
      CollectionReference myCollection =
          FirebaseFirestore.instance.collection(store.myAccountAddress);
      UpdateMyStore({'myCollection': myCollection});
    }

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
        "/": (context) => MyHomePage(),
        MyRoute.homeRoute: (context) => MyHomePage(),
        MyRoute.detailsRoute: (context) => const DetailsPage(),
        MyRoute.addSessionRoute: (context) => const AddSession(),
      },
    );
  }
}
