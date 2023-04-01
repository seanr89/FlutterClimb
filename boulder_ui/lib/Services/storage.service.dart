import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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

  Future<Image> getFileFromPath(String imgRef) async {
    // Create a reference to a file from a Google Cloud Storage URI
    final storage =
        FirebaseStorage.instanceFor(bucket: "gs://boulderme-8e2a7.appspot.com");

    final imageRef = storage.ref().child(imgRef);
    var url = await imageRef.getDownloadURL();

    Image img = Image.network(url);

    return img;
  }
}
