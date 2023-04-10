// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namer_app/Screens/Sessions/session_list.dart';
import 'package:namer_app/models/Boulder.dart';

import 'Services/storage.service.dart';

class BoulderDetail extends StatelessWidget {
  Boulder currentBoulder;

  BoulderDetail({super.key, required this.currentBoulder});
  Storage fileStorage = Storage();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder<Image>(
                future: loadImageWithURL(),
                builder: (BuildContext context, AsyncSnapshot<Image> image) {
                  if (image.hasData) {
                    return InteractiveViewer(
                        panEnabled: true,
                        scaleEnabled: true,
                        //constrained: false,
                        //boundaryMargin: EdgeInsets.all(10),
                        minScale: 1,
                        maxScale: 2.5,
                        child: image.data as Image);
                  } else {
                    return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white)); // placeholder
                  }
                },
              ),
            ),
            BoulderSessionForm(currentBoulder)
          ],
        ),
      ),
    );
  }

  // async - Supports image URL querying and return of Image object
  Future<Image> loadImageWithURL() async {
    //select the image url
    String url = await fileStorage.getDownloadURLFromRef(currentBoulder.imgRef);
    return Image.network(
      url,
      width: 350,
      height: 450,
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool? wasSynchronouslyLoaded) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return SizedBox(
          height: 200.0,
          width: 200.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ),
        );
      },
    );
  }
}

class BoulderSessionForm extends StatelessWidget {
  static Boulder? sessionBoulder;
  BoulderSessionForm(Boulder? boulder) {
    sessionBoulder = boulder;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          boulderSection,
          SizedBox(height: 10),
          CheckboxListTile(
            title: Text("Completed"), //    <-- label
            value: false,
            onChanged: (newValue) {},
          ),
          SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
                border: UnderlineInputBorder(), labelText: "Enter Attempts"),
            onChanged: (text) {
              //boulder.name = text;
              //TODO: Updated processes for attempt record
            },
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomRight,
              // add your floating action button
              child: FloatingActionButton(
                onPressed: () {
                  print("Saving");
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Record Saved')));
                },
                child: Icon(Icons.save),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget boulderSection = Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildDetailRow(sessionBoulder?.grade ?? "N/A", Icons.grade, 'Grade: '),
      SizedBox(height: 10),
      _buildDetailRow(
          sessionBoulder?.colour ?? "N/A", Icons.colorize, 'Colour: '),
    ],
  );
}

Row _buildDetailRow(String content, IconData icon, String label) {
  return Row(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(width: 15.0),
        Text(label,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(width: 5.0),
        Text(content, style: TextStyle(fontSize: 18))
      ]);
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
