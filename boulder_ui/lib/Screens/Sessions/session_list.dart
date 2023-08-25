import 'package:flutter/material.dart';

class SessionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(height: 20),
        Text('Session Listings'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/session/create');
          },
          child: Text("Start a New Session"),
        )
      ]),
    );
  }
}
