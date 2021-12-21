import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final String value;
  const TextWithIcon({Key? key, required this.icon, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 5,
        ),
        (value).text.make()
      ],
    );
  }
}
