import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Climb.dart';

class ClimbRepository {
  final _db = FirebaseFirestore.instance;

  // just a simple get for all appUser Data
  Future<List<Climb>> getAll() async {
    return (await _db.collection("Climbs").get())
        .docs
        .map((item) => Climb.fromMap(item.data()))
        .toList();
  }
}
