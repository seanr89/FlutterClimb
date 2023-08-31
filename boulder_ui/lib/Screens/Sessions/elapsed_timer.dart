import 'dart:async';

import 'package:flutter/material.dart';
import 'package:namer_app/assets/globals.dart' as globals;

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
  late bool startedTimer = false;

  @override
  void initState() {
    print('Elapsed Init State');
    super.initState();

    startedTimer = globals.startedTimer;

    _initialTime = _parseTimestamp();
    _currentDuration = _formatDuration(_calcElapsedTime());

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        _currentDuration = _formatDuration(_calcElapsedTime());
      });
    });
  }

  void startTimer(int timeStamp) {
    globals.startedTimer = true;
    setState(() {
      startedTimer = true;
    });
  }

  void endTimer() {
    globals.startedTimer = false;
    setState(() {
      startedTimer = false;
    });
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
    if (startedTimer) {
      return Center(
          child: Column(
        children: [
          Text(_currentDuration),
          ElevatedButton.icon(
              onPressed: () {
                endTimer();
              },
              icon: Icon(Icons.stop),
              label: Text("End"))
        ],
      ));
    }

    //return Text('Start Session');
    return Center(
        child: Column(
      children: [
        Text("Start Session"),
        ElevatedButton.icon(
            onPressed: () {
              startTimer(DateTime.now().microsecondsSinceEpoch);
            },
            icon: Icon(Icons.play_arrow),
            label: Text("Start"))
      ],
    ));
  }
}
