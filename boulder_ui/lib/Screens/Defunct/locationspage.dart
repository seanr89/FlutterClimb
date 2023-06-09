import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Services/Firestore.Collection.dart';
import 'package:namer_app/models/Location.dart';

class LocationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        FutureBuilder<List<Location>>(
            future: FirestoreCollection.getAllLocationEntries("Locations"),
            builder: (context, AsyncSnapshot<List<Location>> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data!.map((location) {
                    return ListTile(
                        title: Text(location.name ?? "Unknown"),
                        subtitle: Text(location.url ?? "Unknown"));
                  }).toList(),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomRight,
          // add your floating action button
          child: FloatingActionButton(
            onPressed: () {
              print("Create New");
            },
            child: Icon(Icons.add),
          ),
        )
      ]),
    );
  }
}
