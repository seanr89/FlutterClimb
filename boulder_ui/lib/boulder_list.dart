import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/boulder_create.dart';
import 'package:namer_app/boulder_detail.dart';

import 'Services/Firestore.Boulders.dart';
import 'models/Boulder.dart';

class BoulderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<Boulder>>(
            future: FirestoreBoulders.getAllEntries("Boulders"),
            builder: (context, AsyncSnapshot<List<Boulder>> snapshot) {
              if (!snapshot.hasData) return Text('Loading...');
              return Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data!.mapIndexed((index, boulder) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        tileColor: Colors.orange,
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text((index + 1).toString()),
                        ),
                        title: Center(child: Text(boulder!.name ?? "Boulder")),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.all(10.0),
                        onTap: () {
                          // BoulderDetail() should be name of the screen to nav too
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BoulderDetail(currentBoulder: boulder)),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton:
          //SizedBox(height: 20),
          FloatingActionButton(
        onPressed: () {
          print("Create New");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BoulderCreate()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
