import 'package:flutter/material.dart';
import 'package:namer_app/Repositories/AppUserRepository.dart';
import 'package:namer_app/Screens/Boulder/boulder_list.dart';
import 'package:namer_app/Screens/User/user_create.dart';
import 'package:namer_app/assets/utils.dart';

import '../Services/Firestore.Collection.dart';
import '../models/AppUser.dart';
import '../models/Location.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final appUserRepo = AppUserRepository();

  final List<AppUser> users = [];
  final List<Location> locations = [];
  late bool enabledUsers = false;
  String? locationDropDownValue;
  String? userDropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Boulder App")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              // Repo query and dropdownf or locations
              FutureBuilder<List<Location>>(
                  future:
                      FirestoreCollection.getAllLocationEntries("Locations"),
                  builder: (context, AsyncSnapshot<List<Location>> snapshot) {
                    if (snapshot.hasData) {
                      locations.clear();
                      locations.addAll(snapshot.data!);
                      return DropdownButton(
                          hint: Text("Select Location"),
                          value: locationDropDownValue,
                          items: snapshot.data!.map((location) {
                            return DropdownMenuItem(
                              value: location.id,
                              child: Text(location.name ?? "Unknown"),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            var location = locations.firstWhere(
                                (element) => element.id == newValue);
                            setState(() {
                              locationDropDownValue = location.id;
                            });
                            //print(dropdownValue);
                            loadAppUserData(location.id ?? "Unknown");
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              SizedBox(height: 20),
              // User Dropdown
              DropdownButton(
                  disabledHint: Text("Select Location First"),
                  value: userDropdownValue,
                  hint: Text("Select User"),
                  items: users.map((e) {
                    return DropdownMenuItem(
                      value: e.firstName,
                      child: Text(e.firstName ?? "Unknown"),
                    );
                  }).toList(),
                  onChanged: enabledUsers
                      ? (String? newValue) {
                          //Utils.showSnackBar(newValue ?? "Unknown");
                          setState(() {
                            userDropdownValue = newValue;
                          });
                        }
                      : null),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomLeft,
                // add your floating action button
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      //Utils.showSnackBar("Create New Climber");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UserCreate(locations: locations)),
                      );
                    },
                    tooltip: "Create New Climber",
                    child: Icon(Icons.add),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                // add your floating action button
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      //Utils.showSnackBar("Start Session", color: Colors.green);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoulderList(),
                          ));
                    },
                    tooltip: "Start Session",
                    child: Icon(Icons.play_arrow),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadAppUserData(String locationId) async {
    await appUserRepo.getLocationAppUsers(locationId).then((value) {
      setState(() {
        users.clear();
        users.addAll(value);
        enabledUsers = true;
      });
    });
  }
}
