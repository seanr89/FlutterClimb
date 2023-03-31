import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  Future<ListResult> listAllFiles() async {
    // Get a non-default Storage bucket
    final storage =
        FirebaseStorage.instanceFor(bucket: "gs://boulderme-8e2a7.appspot.com");
    final storageRef = storage.ref();
    final listResult = await storageRef.listAll();
    for (var item in listResult.items) {
      // The items under storageRef.
      //print(item);
    }
    return listResult;
  }

  // Future<void> PushImageToStorage() async {
  //   final storage =
  //       FirebaseStorage.instanceFor(bucket: "gs://boulderme-8e2a7.appspot.com");
  // }
}
