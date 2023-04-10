import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Boulder.dart';

class FirestoreBoulders {
  // just a simple get
  static Future<List<Boulder>> getAllEntries(String collection) async {
    return (await FirebaseFirestore.instance.collection(collection).get())
        .docs
        .map((item) => Boulder.fromMap(item.data()))
        .toList();
  }
}
