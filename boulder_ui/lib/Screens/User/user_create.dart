import 'package:flutter/material.dart';
import 'package:namer_app/assets/utils.dart';

import '../../Repositories/AppUserRepository.dart';
import '../../models/AppUser.dart';
import '../../models/Location.dart';

class UserCreate extends StatefulWidget {
  final List<Location> locations;
  String? dropdownValue;

  UserCreate({super.key, required this.locations});
  @override
  State<UserCreate> createState() => _UserCreateState(locations);
}

class _UserCreateState extends State<UserCreate> {
  List<Location> locations;
  final appUserRepo = AppUserRepository();
  final appUser = AppUser();
  String? locationDropDownValue;

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
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 35),
            // User name entry
            TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Enter a firstname"),
              onChanged: (text) {
                appUser.firstName = text;
              },
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Enter a lastname"),
              onChanged: (text) {
                appUser.lastName = text;
              },
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Enter an email"),
              onChanged: (text) {
                appUser.email = text;
              },
            ),
            // Location drop down
            SizedBox(height: 15),
            DropdownButton(
                hint: Text("Select Location"),
                //value: locationDropDownValue,
                items: locations.map((location) {
                  return DropdownMenuItem(
                    value: location.id,
                    child: Text(location.name ?? "Unknown"),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  appUser.locationId = newValue;
                  print(newValue);
                }),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                bool res = await appUserRepo.createUser(appUser);
                if (res) {
                  Navigator.pop(context);
                  return;
                }
                // No good we get a snack bar!
                Utils.showSnackBar("User Failed");
              },
              child: Text("Save"),
            )
          ],
        )),
      ),
    );
  }
}
