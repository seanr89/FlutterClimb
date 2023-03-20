import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Location.dart';

class FirestoreLocations {
  // just a simple get
  static Future<List<Location>> getAllEntries(String collection) async {
    return (await FirebaseFirestore.instance.collection(collection).get())
        .docs
        .map((item) => Location.fromMap(item.data()))
        .toList();
  }

  static Future<List<Location>> getAllLocations(String collection) async {
    return (await FirebaseFirestore.instance.collection(collection).get())
        .docs
        .map((item) => Location.fromMap(item.data()))
        .toList();
  }
}
