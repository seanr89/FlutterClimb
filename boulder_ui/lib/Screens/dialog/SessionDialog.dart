import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namer_app/Repositories/BoulderRepository.dart';
import 'package:namer_app/Services/Storage.service.dart';

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
            height: 400,
            width: 370,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 5),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Enter Attempt Count"),
                    onChanged: (text) {
                      //boulder.name = text;
                      //TODO: Updated processes for attempt record
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Completed"),
                    value: false,
                    onChanged: (newValue) {},
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Save")),
                      SizedBox(width: 20.0),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel")),
                    ],
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
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
