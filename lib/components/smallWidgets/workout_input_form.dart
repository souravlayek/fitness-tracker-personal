import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/data/workout.modal.dart';

class WorkoutInputForm extends StatefulWidget {
  final Function handleSubmit;
  const WorkoutInputForm({Key? key, required this.handleSubmit})
      : super(key: key);

  @override
  _WorkoutInputFormState createState() => _WorkoutInputFormState();
}

class _WorkoutInputFormState extends State<WorkoutInputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  WeightType selectedWeight = WeightType.kg;
  TextEditingController weight = TextEditingController();
  TextEditingController reps = TextEditingController();
  TextEditingController sets = TextEditingController();

  void sendData() {
    TrackingData trackingData = TrackingData(
        weight: Weight(
            weight: double.parse(weight.text).toInt(), type: selectedWeight),
        reps: double.parse(reps.text).toInt(),
        sets: double.parse(sets.text).toInt());
    weight.text = "";
    sets.text = "";
    reps.text = "";
    widget.handleSubmit(trackingData);
  }

  void clearForm() {
    weight.text = "";
    sets.text = "";
    reps.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: [
          "Please Enter Your data".text.bold.size(22).makeCentered(),
          [
            "Select Weight Type:".text.semiBold.make(),
            const SizedBox(
              width: 10,
            ),
            DropdownButton<WeightType>(
                value: selectedWeight,
                items: WeightType.values.map((WeightType weightType) {
                  return DropdownMenuItem<WeightType>(
                      value: weightType,
                      child: ((weightType.toString().split('.').elementAt(1))
                          .text
                          .capitalize
                          .make()));
                }).toList(),
                onChanged: (x) {
                  selectedWeight = x as WeightType;
                })
          ].row(),
          [
            Expanded(
                child: TextFormField(
              controller: weight,
              decoration: InputDecoration(label: "Weight".text.size(8).make()),
              keyboardType: TextInputType.number,
            )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: TextFormField(
              controller: reps,
              decoration: InputDecoration(label: "Reps".text.size(8).make()),
              keyboardType: TextInputType.number,
            )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: TextFormField(
              controller: sets,
              decoration: InputDecoration(label: "Sets".text.size(8).make()),
              keyboardType: TextInputType.number,
            )),
          ].row().pSymmetric(h: 10, v: 15),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: sendData, child: "Submit".text.make()),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent)),
                  onPressed: clearForm,
                  child: "Clear".text.make())
            ],
          )
        ].column(),
      ),
    );
  }
}
