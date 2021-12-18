import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:workout_tracker/utils/helperFunction.dart';
import 'package:workout_tracker/utils/routes.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final String id;
  const ItemCard({
    Key? key,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (name)
            .text
            .bold
            .makeCentered()
            .onInkTap(() {
              Navigator.pushNamed(context, MyRoute.detailsRoute,
                  arguments: <String, String>{"id": id});
            })
            .card
            .color(getRandomColor())
            .make()
            .w(context.screenWidth * 0.9)
            .h(60),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
