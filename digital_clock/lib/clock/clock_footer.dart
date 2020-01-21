import 'package:digital_clock/util/time_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class ClockFooter extends StatelessWidget {
  final ClockModel model;
  final TimeHandler timeHandler;
  final bool is24HourFormat;

  const ClockFooter({
    Key key,
    @required this.model,
    @required this.timeHandler,
    @required this.is24HourFormat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 25;

    return Container(
      alignment: Alignment(0.0, 0.6),
      child: Text(
          "${timeHandler.formattedDate}     "
          "${model.temperature.toStringAsFixed(0)} "
          "${model.unitString}     "
          "${is24HourFormat ? '' : timeHandler.hourFormatString} ",
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w200,
              color: Colors.white)),
    );
  }
}
