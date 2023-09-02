import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/models/AppUser.dart';
import 'package:namer_app/models/Gender.dart';
import '../models/Boulder.dart';
import '../models/Location.dart';

class FirestoreCollection {
  // just a simple get for all genders
  static Future<List<Gender>> getAllGenderEntries(String collection) async {
    return (await FirebaseFirestore.instance.collection(collection).get())
        .docs
        .map((item) => Gender.fromMap(item.data()))
        .toList();
  }

  // just a simple get for all boulders
  static Future<List<Boulder>> getAllBoulderEntries(String collection) async {
    return (await FirebaseFirestore.instance.collection(collection).get())
        .docs
        .map((item) => Boulder.fromMap(item.data()))
        .toList();
  }

  // just a simple get for all locations
  static Future<List<Location>> getAllLocationEntries(String collection) async {
    return (await FirebaseFirestore.instance.collection(collection).get())
        .docs
        .map((item) => Location.fromMap(item.data()))
        .toList();
  }

  static Future<List<AppUser>> getAllAppUsersEntries(String collection) async {
    return (await FirebaseFirestore.instance.collection(collection).get())
        .docs
        .map((item) => AppUser.fromMap(item.data()))
        .toList();
  }
}
