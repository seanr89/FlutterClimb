import 'package:flutter/material.dart';

import '../../models/Location.dart';

class UserCreate extends StatefulWidget {
  final List<Location> locations;

  UserCreate({super.key, required this.locations});
  @override
  State<UserCreate> createState() => _UserCreateState(locations);
}

class _UserCreateState extends State<UserCreate> {
  List<Location> locations;
  _UserCreateState(this.locations);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("User Create"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            //replace with our own icon data.
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 35),
            TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Enter a firstname"),
              onChanged: (text) {
                //boulder.name = text;
              },
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Enter a lastname"),
              onChanged: (text) {
                //boulder.name = text;
              },
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Enter an email"),
              onChanged: (text) {
                //boulder.name = text;
              },
            ),
            SizedBox(height: 15),
            DropdownButton(
                hint: Text("Select Location"),
                items: locations.map((location) {
                  return DropdownMenuItem(
                    child: Text(location.name ?? "Unknown"),
                    value: location.id,
                  );
                }).toList(),
                onChanged: (String? newValue) {}),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              child: Text("Save"),
            )
          ],
        )),
      ),
    );
  }
}
