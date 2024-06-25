import 'dart:async';
import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late Timer _timer;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        setState(() {
          _dateTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_dateTime.hour.toString().padLeft(2, '0')}:${_dateTime.minute.toString().padLeft(2, '0')}:${_dateTime.second.toString().padLeft(2, '0')}',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
