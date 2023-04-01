import 'package:flutter/material.dart';

//https://stackoverflow.com/questions/68930109/flutter-get-image-from-firebase-storage-and-show-it-in-app

class ExampleDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10.0),
            new FutureBuilder<String>(
              future: loadImage(),
              builder: (BuildContext context, AsyncSnapshot<String> image) {
                if (image.hasData) {
                  return Image.network(image.data.toString()); // image is ready
                  //return Text('data');
                } else {
                  return new Container(); // placeholder
                }
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close")),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Future<String> loadImage() async {
    //current user id
    // final _userID = FirebaseAuth.instance.currentUser!.uid;

    // //collect the image name
    // DocumentSnapshot variable = await FirebaseFirestore.instance
    //     .collection('data_user')
    //     .doc('user')
    //     .collection('personal_data')
    //     .doc(_userID)
    //     .get();

    //a list of images names (i need only one)
    //var _file_name = variable['path_profile_image'];

    //select the image url
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("images/user/profile_images/${_userID}")
        .child(_file_name[0]);

    //get image url from firebase storage
    var url = await ref.getDownloadURL();
    print('url: ' + url);
    return url;
  }
}
