import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Services/storage.service.dart';

import 'Screens/dialog/ImageDialog.dart';

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
        SizedBox(height: 20),
        FutureBuilder<ListResult>(
            future: storage.listAllFiles(),
            builder: (context, future) {
              if (!future.hasData) {
                return Text(
                    'Waiting'); // Display empty container if the list is empty
              } else {
                List<Reference> list = future.data!.items;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Center(child: Text(list[index].fullPath)),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => ImageDialog());
                              });
                        }),
                  ),
                );
              }
            }),
      ])),
    );
  }
}
