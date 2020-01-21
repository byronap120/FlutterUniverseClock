// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:digital_clock/clock/clock_background.dart';
import 'package:digital_clock/clock/clock_footer.dart';
import 'package:digital_clock/clock/clock_number.dart';
import 'package:digital_clock/clock/number.dart';
import 'package:digital_clock/util/time_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  TimeHandler timeHandler;
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  bool _animateClockNumber = false;

  @override
  void initState() {
    super.initState();
    timeHandler = TimeHandler();
    widget.model.addListener(_updateModel);
    widget.model.is24HourFormat = false;
    _updateTime();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
    _animateClockNumber = false;
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _animateClockNumber = false;
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
      _animateClockNumber = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final clockFontSize = MediaQuery.of(context).size.width / 3.5;
    timeHandler.updateTime(is24HourFormat: widget.model.is24HourFormat);
    return Stack(
      children: <Widget>[
        ClockBackground(),
        Container(
          alignment: Alignment(0.0, -0.15),
          child: Number(
            text: ":",
            fontSize: clockFontSize,
          ),
        ),
        ClockNumber(
          newNumber: timeHandler.currentHour,
          oldNumber: timeHandler.lastHour,
          alignment: Alignment(-0.70, 0.0),
          dismissDirection: DismissNumberDirection.right,
          animate: _animateClockNumber,
        ),
        ClockNumber(
          newNumber: timeHandler.currentMinute,
          oldNumber: timeHandler.lastMinute,
          alignment: Alignment(0.70, 0.0),
          dismissDirection: DismissNumberDirection.left,
          animate: _animateClockNumber,
        ),
        ClockFooter(
          model: widget.model,
          timeHandler: timeHandler,
          is24HourFormat: widget.model.is24HourFormat,
        ),
      ],
    );
  }
}
