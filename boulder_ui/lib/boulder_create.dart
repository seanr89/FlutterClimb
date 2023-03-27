import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoulderCreate extends StatelessWidget {
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
  String dropdownValue = gradeColours.first;
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
            items: gradeColours.map<DropdownMenuItem<String>>((String value) {
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
        CheckboxListTile(
          title: Text("Completed"),
          value: false,
          onChanged: (newValue) {},
        ),
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
