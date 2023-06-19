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
}
