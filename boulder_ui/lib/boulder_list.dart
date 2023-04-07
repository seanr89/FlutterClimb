import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/boulder_create.dart';
import 'package:namer_app/boulder_detail.dart';

import 'models/Boulder.dart';

class BoulderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Boulders').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Text('Loading...');
              return ListView(
                //itemExtent: 100.0,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: snapshot.data!.docs.mapIndexed((index, document) {
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
                      title: Center(child: Text(document['name'])),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      contentPadding: EdgeInsets.all(10.0),
                      onTap: () {
                        // BoulderDetail() should be name of the screen to nav too
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BoulderDetail(
                                  currentBoulder: Boulder.fromMap(document
                                      .data() as Map<String, dynamic>))),
                        );
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            // add your floating action button
            child: FloatingActionButton(
              onPressed: () {
                print("Create New");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BoulderCreate()),
                );
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
