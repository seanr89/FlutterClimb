import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Boulder.dart';

class BoulderRepository {
  final _db = FirebaseFirestore.instance;

  createBoulder(Boulder boulder) {
    _db
        .collection("collectionPath")
        .add(boulder.toJson())
        .whenComplete(() => print("createBoulder done"));
  }
}
