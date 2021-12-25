import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/components/pageWidgets/emtypage/empty_page.dart';
import 'package:workout_tracker/components/pageWidgets/homepage/add_workout_form.dart';
import 'package:workout_tracker/components/pageWidgets/homepage/homepage_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_tracker/data/models.dart';
import 'package:workout_tracker/data/store.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<WorkOut> myWorkouts = [];

  void getWorkouts() {
    MyStore store = VxState.store;
    DocumentReference workoutDocument =
        (store.data['myCollection'] as CollectionReference).doc("workout");
    workoutDocument.get().then((value) {
      List<WorkOut> workoutToStore = [];
      if (value.data() != null) {
        Map<String, dynamic> myValue = value.data() as Map<String, dynamic>;
        if (myValue.containsKey('data')) {
          myValue['data']
              .forEach((e) => workoutToStore.add(WorkOut.fromMap(e)));
          UpdateMyStore({"workouts": workoutToStore});
          setState(() {
            myWorkouts = workoutToStore;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.white,
        title: "Workout Tracker".text.bold.make(),
        actions: [
          IconButton(
              onPressed: () {
                _showModalBottomSheet(context, getWorkouts);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              )),
        ],
        elevation: 2,
        centerTitle: true,
      ),
      body: myWorkouts.isNotEmpty ? const HomepageList() : const EmptyPage(),
    );
  }
}

void _showModalBottomSheet(BuildContext context, Function updateData) {
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
              AddWorkoutForm(
                onUpdate: updateData,
              )
            ].column(),
          )
        ]);
      },
      isDismissible: false,
      isScrollControlled: true);
}
