import 'package:flutter/material.dart';
import 'package:namer_app/Services/storage.service.dart';

class MySettings extends StatelessWidget {
  var storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Text('My Settings'),
      SizedBox(height: 20),
      ElevatedButton(
        child: Text("Query Storage"),
        onPressed: () {
          final myFuture = storage.listAllFiles();
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
