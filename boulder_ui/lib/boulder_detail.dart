import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namer_app/models/Boulder.dart';

class BoulderDetail extends StatelessWidget {
  BoulderDetail(Boulder boulder);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InteractiveViewer(
                panEnabled: true,
                scaleEnabled: true,
                //constrained: false,
                //boundaryMargin: EdgeInsets.all(10),
                minScale: 1,
                maxScale: 2,
                child: Image.asset(
                  'images/Orange_1.jpg',
                  width: 350,
                  height: 425,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //buttonSection,
            //textSection
            BoulderSessionForm()
          ],
        ),
      ),
    );
  }
}

/// Base button selector button event
// Column _buildButtonColumn(Color color, IconData icon, String label) {
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Icon(icon, color: color),
//       Container(
//         margin: const EdgeInsets.only(top: 4),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w300,
//             color: color,
//           ),
//         ),
//       ),
//     ],
//   );
// }

class BoulderSessionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
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
              title: Text("Completed"), //    <-- label
              value: false,
              onChanged: (newValue) {},
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              // add your floating action button
              child: FloatingActionButton(
                onPressed: () {
                  print("Saving");
                },
                child: Icon(Icons.save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
