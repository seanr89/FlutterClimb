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
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter boulder colour',
          ),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
              border: UnderlineInputBorder(), labelText: "Enter your grade"),
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
          onPressed: () {
            print('Save');
          },
        )
      ])),
    ));
  }
}
