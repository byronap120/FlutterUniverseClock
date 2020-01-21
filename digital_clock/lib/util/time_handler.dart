import 'package:intl/intl.dart';

class TimeHandler {
  String _currentHour;
  String _currentMinute;
  String _lastHour;
  String _lastMinute;
  String _currentSecond;
  String _lastSecond;
  String _formattedDate;
  String _hourFormatString;

  String get lastMinute => _lastMinute;

  String get lastHour => _lastHour;

  String get currentMinute => _currentMinute;

  String get currentHour => _currentHour;

  String get lastSecond => _lastSecond;

  String get currentSecond => _currentSecond;

  String get formattedDate => _formattedDate;

  String get hourFormatString => _hourFormatString;

  TimeHandler() {
    updateTime();
  }

  void updateTime({bool is24HourFormat = false}) {
    final _dateTime = DateTime.now();

    _hourFormatString = DateFormat('a').format(_dateTime);

    _formattedDate = DateFormat('EEEE, MMM d').format(_dateTime);

    final seconds = DateFormat('ss').format(_dateTime);
    _lastSecond = _currentSecond;
    _currentSecond = seconds;

    final minute = DateFormat('mm').format(_dateTime);
    _lastMinute = _currentMinute;
    _currentMinute = minute;

    final hour = DateFormat(is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    _lastHour = _currentHour;
    _currentHour = hour;
  }
}
