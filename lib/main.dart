import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/data/store.dart';
import 'package:workout_tracker/screens/addSession.dart';
import 'package:workout_tracker/screens/details.dart';
import 'package:workout_tracker/screens/homepage.dart';
import 'package:workout_tracker/utils/helperFunction.dart';
import 'package:workout_tracker/utils/routes.dart';
import 'package:workout_tracker/utils/theme.dart';

Future<String> _getMyAccountAddress() async {
  String myAccountAddress = await getDataFromLocalStorage("myAccountAddress");
  return myAccountAddress;
}

Future<String> _createMyAccountAddress() async {
  String myAccountAddress = getRandomId();
  setDataToLocalStorage("myAccountAddress", myAccountAddress);
  return myAccountAddress;
}

Future<String> _getOrCreateMyAddress() async {
  String myAddress = await _getMyAccountAddress();
  if (myAddress.isEmpty) {
    myAddress = await _createMyAccountAddress();
  }
  return myAddress;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String myAddress = await _getOrCreateMyAddress();
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
        appBarTheme: appBarTheme,
      ),
      initialRoute: MyRoute.homeRoute,
      routes: {
        MyRoute.homeRoute: (context) => const MyHomePage(),
        MyRoute.detailsRoute: (context) => const DetailsPage(),
        MyRoute.addSessionRoute: (context) => const AddSession(),
      },
    );
  }
}
