import 'dart:async';

import 'package:flutter/material.dart';

class ElapsedTime extends StatefulWidget {
  final int timestamp;

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
  bool startedTimer = false;

  @override
  void initState() {
    super.initState();

    _initialTime = _parseTimestamp();
    _currentDuration = _formatDuration(_calcElapsedTime());

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      setState(() {
        _currentDuration = _formatDuration(_calcElapsedTime());
      });
    });
  }

  void startTimer(int timeStamp) {
    startedTimer = true;
  }

  void endTimer() {
    startedTimer = false;
  }

  // Duration _calcElapsedTime() => _initialTime.difference(DateTime.now());
  Duration _calcElapsedTime() => DateTime.now().difference(_initialTime);

  DateTime _parseTimestamp() =>
      DateTime.fromMillisecondsSinceEpoch(widget.timestamp);

  // TODO update this to fit your own needs
  String _formatDuration(final Duration duration) => duration.toString();

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (startedTimer) return Text(_currentDuration);

    //return Text('Start Session');
    return Center(
        child: Column(
      children: [
        Text("Start Session"),
        ElevatedButton.icon(
            onPressed: () {
              startTimer(DateTime.now().microsecondsSinceEpoch);
            },
            icon: Icon(Icons.start),
            label: Text("Start"))
      ],
    ));
  }
}
