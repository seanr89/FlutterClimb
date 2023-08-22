import 'package:flutter/material.dart';

class SessionOverlayWidget extends StatefulWidget {
  @override
  State createState() => _SessionOverlayWidget();
}

class _SessionOverlayWidget extends State<SessionOverlayWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Stateful Widget'),
      ),
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
