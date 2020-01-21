import 'package:flutter/material.dart';

class Number extends StatelessWidget {
  final text;
  final fontSize;

  const Number({
    Key key,
    @required this.text,
    @required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
}
