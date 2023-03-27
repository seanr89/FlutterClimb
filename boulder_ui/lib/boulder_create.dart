import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoulderCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
            child: Column(children: [
      SizedBox(height: 20),
      TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Enter boulder name',
        ),
      ),
      SizedBox(height: 10),
      TextField(
        decoration: InputDecoration(labelText: "Enter your number"),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
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
    ])));
  }
}
