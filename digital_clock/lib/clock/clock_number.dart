import 'package:digital_clock/animation/dismiss_number.dart';
import 'package:digital_clock/animation/show_number.dart';
import 'package:flutter/material.dart';

enum DismissNumberDirection {
  right,
  left,
}

class ClockNumber extends StatefulWidget {
  final String newNumber;
  final String oldNumber;
  final Alignment alignment;
  final DismissNumberDirection dismissDirection;
  final bool animate;

  const ClockNumber({
    Key key,
    @required this.newNumber,
    @required this.oldNumber,
    @required this.alignment,
    @required this.dismissDirection,
    @required this.animate,
  }) : super(key: key);

  @override
  _ClockNumberState createState() => _ClockNumberState();
}

class _ClockNumberState extends State<ClockNumber>
    with TickerProviderStateMixin {
  Animation<double> _dismissAnimation;
  AnimationController _dismissController;
  Animation<double> _showAnimation;
  AnimationController _showController;

  @override
  void initState() {
    super.initState();
    _updateAnimations();
  }

  @override
  void didUpdateWidget(ClockNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAnimations();
  }

  _updateAnimations() {
    _showController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _showAnimation =
        CurvedAnimation(parent: _showController, curve: Curves.linear);

    _dismissController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _dismissAnimation =
        CurvedAnimation(parent: _dismissController, curve: Curves.ease)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _showController.forward();
            }
          });

    if (widget.animate && widget.oldNumber != widget.newNumber) {
      _dismissController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 3.5;
    return Stack(
      children: <Widget>[
        DismissNumber(
          animation: _dismissAnimation,
          number: widget.oldNumber,
          alignment: widget.alignment,
          dismissDirection: widget.dismissDirection,
          fontSize: fontSize,
        ),
        ShowNumber(
          animation: _showAnimation,
          number: widget.newNumber,
          alignment: widget.alignment,
          fontSize: fontSize,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _dismissController.dispose();
    _showController.dispose();
    super.dispose();
  }
}
