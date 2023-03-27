import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  // Get a non-default Storage bucket
  final storage =
      FirebaseStorage.instanceFor(bucket: "gs://boulderme-8e2a7.appspot.com");

  Future<void> ListAllFiles() async {
    final storageRef = storage.ref();
    final listResult = await storageRef.listAll();
    for (var prefix in listResult.prefixes) {
      // The prefixes under storageRef.
      // You can call listAll() recursively on them.
      //print(prefix);
    }
    for (var item in listResult.items) {
      // The items under storageRef.
      print(item);
    }
  }
}
