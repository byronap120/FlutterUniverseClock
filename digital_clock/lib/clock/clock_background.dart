import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class ClockBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FlareActor(
          "assets/animations/black_hole_background.flr",
          alignment: Alignment.center,
          animation: "stars",
          fit: BoxFit.cover,
        ),
        FlareActor(
          "assets/animations/comet.flr",
          alignment: Alignment.center,
          animation: "translate",
          fit: BoxFit.cover,
        )
      ],
    );
  }
}
