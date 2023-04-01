import 'package:flutter/material.dart';

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
    );
  }
}
