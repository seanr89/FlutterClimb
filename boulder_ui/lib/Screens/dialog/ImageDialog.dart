import 'package:flutter/material.dart';
import 'package:namer_app/Repositories/BoulderRepository.dart';
import 'package:namer_app/Services/storage.service.dart';

//https://stackoverflow.com/questions/68930109/flutter-get-image-from-firebase-storage-and-show-it-in-app

// Dialog example to show an image
class ImageDialog extends StatelessWidget {
  Storage fileStorage = Storage();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 600,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //SizedBox(height: 10.0),
            FutureBuilder<String>(
              future: loadImage(),
              builder: (BuildContext context, AsyncSnapshot<String> image) {
                if (image.hasData) {
                  return Image.network(
                    image.data.toString(),
                    width: 270,
                    height: 500,
                  ); // image is ready
                  //return Text('data');
                } else {
                  return Container(); // placeholder
                }
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close")),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }

  Future<String> loadImage() async {
    //select the image url
    String url = await fileStorage.getDownloadURLFromRef('Orange_2.jpg');
    print('url: $url');
    return url;
  }
}
