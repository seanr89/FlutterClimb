import 'package:flutter/material.dart';

class LocationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(children: [
                  Center(
                    child: Column(children: [Text("Location Details")]),
                  )
                ]))));
  }
}
