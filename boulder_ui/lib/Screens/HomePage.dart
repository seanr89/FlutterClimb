import 'package:flutter/material.dart';

import '../Services/Firestore.Collection.dart';
import '../models/Location.dart';
import 'Locations/location_details.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Boulder App")),
      body: Center(
        child: Column(
          children: [
            Text("Data Entry!"),
            SizedBox(height: 20),
            FutureBuilder<List<Location>>(
                future: FirestoreCollection.getAllLocationEntries("Locations"),
                builder: (context, AsyncSnapshot<List<Location>> snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                        // Initial Value
                        value: "Select a Location",
                        items: snapshot.data!.map((location) {
                          return DropdownMenuItem(
                            child: Text(location.name ?? "Unknown"),
                            value: location.id,
                          );
                        }).toList(),
                        onChanged: (String? newValue) {});
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
