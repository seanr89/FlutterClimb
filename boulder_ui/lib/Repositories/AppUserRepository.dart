import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/AppUser.dart';

class AppUserRepository {
  final _db = FirebaseFirestore.instance;

  // just a simple get for all appUser Data
  Future<List<AppUser>> getAllAppUsers() async {
    return (await _db.collection("AppUsers").get())
        .docs
        .map((item) => AppUser.fromMap(item.data()))
        .toList();
  }

  Future<AppUser> getAppUserById(String id) async {
    var snapShot = await _db.collection("AppUsers").doc(id).get();
    return AppUser.fromMap(snapShot.data() ?? {});
  }

  Future<bool> createUser(AppUser appUser) async {
    bool result = false;
    await _db
        .collection("AppUsers")
        .add(appUser.toJson())
        .whenComplete(() => {print("createAppUser done"), result = true})
        .catchError((err) {
      print(err.toString());
    });

    return result;
  }
}
