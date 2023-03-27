import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Services/Firestore.Locations.dart';
import 'package:namer_app/Services/storage.service.dart';

import 'models/Location.dart';

class MySettings extends StatelessWidget {
  var storage = new Storage();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Text('My Settings'),
      ElevatedButton(
        child: Text("Hello Team"),
        onPressed: () {
          const url = 'https://majidhajian.com';
          final myFuture = storage.ListAllFiles();
          myFuture.then((response) {
            // (3)
            // if (response.statusCode == 200) {
            //   print('Success!');
            // }
          });
        },
      )
    ]));
  }
}
