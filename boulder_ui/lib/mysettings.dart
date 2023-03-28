import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Services/storage.service.dart';

class MySettings extends StatelessWidget {
  var storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      SizedBox(height: 20),
      Text('My Settings'),
      SizedBox(height: 20),
      ElevatedButton(
        child: Text("Query Storage"),
        onPressed: () {
          final myFuture = storage.listAllFiles();
          myFuture.then((response) {
            print('Success!');
            // }
          });
        },
      ),
      FutureBuilder<ListResult>(
          future: storage.listAllFiles(),
          builder: (context, future) {
            if (!future.hasData) {
              return Text(
                  'Waiting'); // Display empty container if the list is empty
            } else {
              List<Reference> list = future.data!.items;
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Text(list[index].fullPath);
                  });
            }
          }),
    ]));
  }
}
