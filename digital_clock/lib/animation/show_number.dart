import 'package:digital_clock/clock/number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowNumber extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0.0, end: 1.0);

  final String number;
  final Alignment alignment;
  final double fontSize;

  ShowNumber({
    Key key,
    Animation<double> animation,
    @required this.number,
    @required this.alignment,
    @required this.fontSize,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        alignment: alignment,
        child: Number(
          text: number,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
