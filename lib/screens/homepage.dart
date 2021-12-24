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
          title: "Workout Tracker".text.bold.make(),
          actions: [
            IconButton(
                onPressed: () {
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
                              ]
                                  .row(alignment: MainAxisAlignment.end)
                                  .w(double.infinity),
                              "Add a new workout".text.bold.size(22).make(),
                              const AddWorkoutForm()
                            ].column(),
                          )
                        ]);
                      },
                      isDismissible: false,
                      isScrollControlled: true);
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

class AddWorkoutForm extends StatefulWidget {
  const AddWorkoutForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddWorkoutForm> createState() => _AddWorkoutFormState();
}

class _AddWorkoutFormState extends State<AddWorkoutForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController workout = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: [
          TextFormField(
            decoration: InputDecoration(label: "Workout Name".text.make()),
            autofocus: true,
            controller: workout,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter workout name";
              }
              return null;
            },
          ).pSymmetric(v: 20, h: 30),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: "Submit".text.make())
        ].column());
  }
}
