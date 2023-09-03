import 'package:flutter/material.dart';
import 'package:namer_app/Screens/Locations/location_details.dart';
import 'package:namer_app/Services/Firestore.Collection.dart';
import 'package:namer_app/assets/utils.dart';
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
                        subtitle: Text(location.url ?? "Unknown"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocationDetails(),
                              ));
                        });
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
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FloatingActionButton(
              onPressed: () {
                print("Create New");
                Utils.showSnackBar("Create New");
              },
              child: Icon(Icons.add),
            ),
          ),
        )
      ]),
    );
  }
}
