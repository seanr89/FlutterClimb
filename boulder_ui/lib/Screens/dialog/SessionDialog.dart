import 'package:flutter/material.dart';
import 'package:namer_app/Repositories/BoulderRepository.dart';
import 'package:namer_app/Services/storage.service.dart';

class SessionDialog extends StatelessWidget {
  Storage fileStorage = Storage();
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Text("Session Dialog"),
        elevation: 0,
        backgroundColor: Colors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        children: [
          SizedBox(
            height: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Session Dialog'),
                SizedBox(height: 10.0),
                FlutterLogo(
                  size: 125,
                ),
                Text(
                  "This is a Custom Dialog",
                  style: TextStyle(fontSize: 20),
                ),
                //SizedBox(height: 5.0),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close")),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ]);
  }

  // Future<String> loadImage() async {
  //   //select the image url
  //   String url = await fileStorage.getDownloadURLFromRef('Orange_2.jpg');
  //   print('url: $url');
  //   return url;
  // }
}
