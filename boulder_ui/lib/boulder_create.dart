import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namer_app/Repositories/BoulderRepository.dart';
import 'package:namer_app/models/Boulder.dart';

class BoulderCreate extends StatefulWidget {
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

  static const List<String> grades = <String>[
    '3',
    '4-',
    '4',
    '4+',
    '5-',
    '5',
    '5+',
    '6A',
    '6A+',
    '6B',
    '6B+',
  ];
  //https://www.mountainproject.com/international-climbing-grades

  @override
  State<BoulderCreate> createState() => _BoulderCreateState();
}

class _BoulderCreateState extends State<BoulderCreate> {
  Boulder boulder = Boulder();
  XFile? image;
  String? imageUrl;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  bool saveEnabled = false;

  final ImagePicker picker = ImagePicker();
  final boulderRepo = BoulderRepository();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      imageUrl = img!.path;
      saveEnabled = true;
    });
  }

  /// Start the saving process
  Future<bool> saveBoulder() async {
    print('saveBoulder');
    var ref = uploadImage();
    createBoulderFromInputs(ref);
    return await boulderRepo.createBoulder(boulder);
  }

  // support image uploading!
  Reference uploadImage() {
    //print('Uploading image');
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

    var file = File(image!.path);

    // Create a reference to "mountains.jpg"
    final testRef = storageRef.child(image!.name);
    testRef.putFile(file);
    return testRef;
  }

  /// ensure the boulder model is properly updated
  Boulder? createBoulderFromInputs(Reference ref) {
    //print("createBoulderFromInputs");
    boulder.imgRef = ref.fullPath;
    boulder.activeDate = startDate;
    boulder.colour = colourValue;
    boulder.grade = gradeValue;
    return boulder;
  }

  String colourValue = BoulderCreate.gradeColours.first;
  String gradeValue = BoulderCreate.grades.first;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
          child: Column(children: [
        SizedBox(height: 35),
        TextField(
          decoration: InputDecoration(
              border: UnderlineInputBorder(), labelText: "Enter a name"),
          onChanged: (text) {
            boulder.name = text;
          },
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Text("Select a Colour:"),
            DropdownButton<String>(
                hint: Text('Select a colour'),
                value: colourValue,
                //isExpanded: true,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                underline: Container(
                  height: 2,
                ),
                onChanged: (String? value) {
                  colourValue = value!;
                },
                items: BoulderCreate.gradeColours
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Text("Select a Colour:"),
            DropdownButton<String>(
                hint: Text('Select a grade'),
                value: gradeValue,
                //isExpanded: true,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                underline: Container(
                  height: 2,
                ),
                onChanged: (String? value) {
                  gradeValue = value!;
                },
                items: BoulderCreate.grades
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
          ],
        ),
        SizedBox(height: 5),
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
                ? Image.file(
                    File(image!.path),
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : Image.network('https://i.imgur.com/sUFH1Aq.png')),
        ElevatedButton.icon(
          onPressed: () {
            getImage(ImageSource.gallery);
          },
          icon: Icon(Icons.add_a_photo),
          label: Text('Photo'),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text(
                'Start: ${startDate.year}/${startDate.month}/${startDate.day}'),
            onPressed: () async {
              final date = await pickDate(startDate);
              if (date != null) {
                setState(() {
                  startDate = date;
                });
              }
              return;
            },
          ),
        ),
        // SizedBox(height: 5),
        // ElevatedButton(
        //   child: Text('Time: ${startDate.hour}:${startDate.minute}'),
        //   onPressed: () async {
        //     final t = await pickTime(startDate);
        //     if (t != null) {
        //       setState(() {
        //         time = t;
        //       });
        //     }
        //     return;
        //   },
        // ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text('End: ${endDate.year}/${endDate.month}/${endDate.day}'),
            onPressed: () async {
              final date = await pickDate(endDate);
              if (date != null) {
                setState(() {
                  endDate = date;
                });
              }
              return;
            },
          ),
        ),
        SizedBox(height: 5),
        ElevatedButton(
          onPressed: saveEnabled
              ? () async {
                  final res = await saveBoulder();
                  if (res) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Record Saved')));
                  }
                }
              : null,
          child: Text("Save"),
        )
      ])),
    ));
  }

  Future<DateTime?> pickDate(date) => showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2022),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> pickTime(date) => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: date.hour, minute: date.minute));
}
