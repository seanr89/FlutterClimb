// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namer_app/models/Boulder.dart';

import 'Services/storage.service.dart';

class BoulderDetail extends StatelessWidget {
  Boulder currentBoulder;

  // var todo;
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
              child: FutureBuilder<String>(
                future: loadImage(),
                builder: (BuildContext context, AsyncSnapshot<String> image) {
                  if (image.hasData) {
                    return InteractiveViewer(
                      panEnabled: true,
                      scaleEnabled: true,
                      //constrained: false,
                      //boundaryMargin: EdgeInsets.all(10),
                      minScale: 1,
                      maxScale: 2,
                      child: Image.network(
                        image.data.toString(),
                        width: 350,
                        height: 425,
                      ),
                    );
                  } else {
                    return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white)); // placeholder
                  }
                },
              ),
              // child: InteractiveViewer(
              //   panEnabled: true,
              //   scaleEnabled: true,
              //   //constrained: false,
              //   //boundaryMargin: EdgeInsets.all(10),
              //   minScale: 1,
              //   maxScale: 2,
              //   child: Image.asset(
              //     'images/Orange_1.jpg',
              //     width: 350,
              //     height: 425,
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
            BoulderSessionForm(currentBoulder)
          ],
        ),
      ),
    );
  }

  Future<String> loadImage() async {
    //select the image url
    String url = await fileStorage.getDownloadURLFromRef(currentBoulder.imgRef);
    print('url: $url');
    return url;
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            boulderSection,
            // SizedBox(height: 10),
            // TextField(
            //   decoration: InputDecoration(labelText: "Enter your number"),
            //   keyboardType: TextInputType.number,
            //   inputFormatters: <TextInputFormatter>[
            //     FilteringTextInputFormatter.digitsOnly
            //   ],
            // ),
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

  Widget boulderSection = Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDetailRow(sessionBoulder?.colour ?? "N/A", Icons.call, 'Grade'),
        // _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        // _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    ),
  );
}

Row _buildDetailRow(String content, IconData icon, String label) {
  return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        Text(label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
        Text(content, style: TextStyle(fontSize: 10))
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
