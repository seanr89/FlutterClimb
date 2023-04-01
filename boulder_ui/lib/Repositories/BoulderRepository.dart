import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Boulder.dart';

class BoulderRepository {
  final _db = FirebaseFirestore.instance;

  Future<bool> createBoulder(Boulder boulder) async {
    bool result = false;
    await _db
        .collection("Boulders")
        .add(boulder.toJson())
        .whenComplete(() => {print("createBoulder done"), result = true})
        .catchError((err) {
      print(err.toString());
    });

    return result;
  }
}
