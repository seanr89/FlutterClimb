import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namer_app/models/Boulder.dart';

class BoulderCreate extends StatefulWidget {
  Boulder boulder = Boulder();
  static const List<String> gradeColours = <String>[
    'Orange',
    'Blue',
    'White',
    'Green',
    'Yellow',
    'Purple',
    'Red',
    'Black',
    'Pink'
  ];

  @override
  State<BoulderCreate> createState() => _BoulderCreateState();
}

class _BoulderCreateState extends State<BoulderCreate> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  Future saveBoulder() async {
    print('saveBoulder');

    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

    var file = File(image!.path);

    // Create a reference to "mountains.jpg"
    final testRef = storageRef.child(image!.name);
    testRef.putFile(file);
  }

  String dropdownValue = BoulderCreate.gradeColours.first;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
          child: Column(children: [
        SizedBox(height: 50),
        DropdownButton<String>(
            value: dropdownValue,
            isExpanded: true,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            underline: Container(
              height: 2,
            ),
            onChanged: (String? value) {
              dropdownValue = value!;
            },
            items: BoulderCreate.gradeColours
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()),
        // TextFormField(
        //   decoration: const InputDecoration(
        //     border: UnderlineInputBorder(),
        //     labelText: 'Enter boulder colour',
        //   ),
        // ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
              border: UnderlineInputBorder(), labelText: "Enter a grade"),
        ),
        SizedBox(height: 10),
        Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(2, 2),
                  spreadRadius: 2,
                  blurRadius: 1,
                ),
              ],
            ),
            child: (imageUrl != null)
                ? Image.network(imageUrl!)
                : Image.network('https://i.imgur.com/sUFH1Aq.png')),
        ElevatedButton.icon(
          onPressed: () {
            //appState.toggleFavorite();
            getImage(ImageSource.gallery);
          },
          icon: Icon(Icons.add_a_photo),
          label: Text('Photo'),
        ),
        SizedBox(height: 10),
        CheckboxListTile(
          title: Text("Completed"),
          value: false,
          onChanged: (newValue) {},
        ),
        SizedBox(height: 10),
        ElevatedButton(
          child: Text("Save"),
          onPressed: () async {
            //print('Save');
            await saveBoulder();
          },
        )
      ])),
    ));
  }
}
