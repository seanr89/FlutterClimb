import 'package:flutter/material.dart';
import 'package:namer_app/Services/Firestore.Locations.dart';
import 'package:namer_app/models/Location.dart';

class LocationsPage extends StatefulWidget {
  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Location>>(
          future: FirestoreLocations.getAllEntries("Locations"),
          builder: (context, AsyncSnapshot<List<Location>> snapshot) {
            if (snapshot.hasData) {
              //return Text(snapshot.data!.first.name ?? "Unknown");
              return ListView(
                children: snapshot.data!.map((location) {
                  return ListTile(title: Text(location.name ?? "Unknown"));
                }).toList(),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
