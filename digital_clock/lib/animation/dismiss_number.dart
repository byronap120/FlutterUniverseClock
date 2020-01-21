import 'dart:math' as math;

import 'package:digital_clock/clock/clock_number.dart';
import 'package:digital_clock/clock/number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DismissNumber extends AnimatedWidget {
  final String number;
  final Alignment alignment;
  final DismissNumberDirection dismissDirection;
  final double fontSize;

  DismissNumber({
    Key key,
    @required Animation<double> animation,
    @required this.number,
    @required this.alignment,
    @required this.dismissDirection,
    @required this.fontSize,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    var rotationY = math.pi / 2;
    if (dismissDirection == DismissNumberDirection.left) {
      rotationY = -math.pi / 3;
    }
    final _positionXTween = Tween<double>(begin: alignment.x, end: 0.0);
    final _positionYTween = Tween<double>(begin: 0.0, end: -0.4);
    final _opacityTween = Tween<double>(begin: 1, end: 0.0);
    final _rotationYTween = Tween<double>(begin: 0.0, end: rotationY);
    final _rotationXTween = Tween<double>(begin: 0.0, end: math.pi);
    final _sizeTweenDismiss = Tween<double>(begin: fontSize, end: 0);

    return Container(
      alignment: Alignment(
        _positionXTween.evaluate(animation),
        _positionYTween.evaluate(animation),
      ),
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Transform(
          transform: Matrix4.identity()
            ..rotateX(_rotationXTween.evaluate(animation))
            ..rotateY(_rotationYTween.evaluate(animation)),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Number(
              text: number,
              fontSize: _sizeTweenDismiss.evaluate(animation),
            ),
          ),
        ),
      ),
    );
  }
}
