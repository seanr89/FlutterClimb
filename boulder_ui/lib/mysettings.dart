import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Services/Storage.service.dart';
// import 'Screens/dialog/ImageDialog.dart';

class MySettings extends StatelessWidget {
  var storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        SizedBox(height: 20),
        Text('My Settings'),
        SizedBox(height: 20),
        Text('Show User Name here!'),
      ])),
    );
  }
}
