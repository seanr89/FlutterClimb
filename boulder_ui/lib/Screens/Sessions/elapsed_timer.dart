import 'dart:async';

import 'package:flutter/material.dart';

class ElapsedTime extends StatefulWidget {
  final String timestamp;

  const ElapsedTime({
    required Key key,
    required this.timestamp,
  }) : super(key: key);

  @override
  _ElapsedTimeState createState() => _ElapsedTimeState();
}

class _ElapsedTimeState extends State<ElapsedTime> {
  late Timer _timer;
  late DateTime _initialTime;
  late String _currentDuration;

  @override
  void initState() {
    super.initState();

    _initialTime = _parseTimestamp();
    _currentDuration = _formatDuration(_calcElapsedTime());

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        _currentDuration = _formatDuration(_calcElapsedTime());
      });
    });
  }

  Duration _calcElapsedTime() => _initialTime.difference(DateTime.now());

  DateTime _parseTimestamp() => DateTime.parse(widget.timestamp);

  // TODO update this to fit your own needs
  String _formatDuration(final Duration duration) => duration.toString();

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_currentDuration);
  }
}
