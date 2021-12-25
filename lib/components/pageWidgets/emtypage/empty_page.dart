import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/empty.svg';
    return SingleChildScrollView(
      child: [
        SvgPicture.asset(
          assetName,
          semanticsLabel: 'Empty Logo',
        ).w(context.screenWidth * 0.5).box.makeCentered(),
        "No data present".text.bold.size(20).make()
      ].column(
          alignment: MainAxisAlignment.center,
          crossAlignment: CrossAxisAlignment.center),
    );
  }
}
