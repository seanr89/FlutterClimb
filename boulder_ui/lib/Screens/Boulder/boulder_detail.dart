import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namer_app/Screens/dialog/SessionDialog.dart';
import 'package:namer_app/models/Boulder.dart';
import '../../Services/Storage.service.dart';
import '../../assets/utils.dart';

class BoulderDetail extends StatefulWidget {
  final Boulder currentBoulder;

  BoulderDetail({super.key, required this.currentBoulder});

  @override
  State<BoulderDetail> createState() => _BoulderDetailState();
}

class _BoulderDetailState extends State<BoulderDetail> {
  final Storage fileStorage = Storage();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                          maxScale: 2.7,
                          child: image.data as Image);
                    } else {
                      return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white)); // placeholder
                    }
                  },
                ),
              ),
              BoulderSessionForm(widget.currentBoulder)
            ],
          ),
        ),
      ),
    );
  }

  // async - Supports image URL querying and return of Image object
  Future<Image> loadImageWithURL() async {
    String url = await fileStorage
        .getDownloadURLFromRef(widget.currentBoulder.imgRef ?? "Unknown");
    return Image.network(
      url,
      width: 400,
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
          width: 210.0,
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
  final Boulder sessionBoulder;
  BoulderSessionForm(this.sessionBoulder);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          //boulderSection,
          createBoulderSection(sessionBoulder),
          SizedBox(height: 10),
          CheckboxListTile(
            title: Text("Completed"), //    <-- label
            value: false,
            onChanged: (newValue) {},
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomRight,
              // add your floating action button
              child: FloatingActionButton(
                onPressed: () {
                  print("Open Session Dialog");
                  Utils.showSnackBar("Showing Snacks");
                  showDialog(context: context, builder: (_) => SessionDialog());
                },
                child: Icon(Icons.edit),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget createBoulderSection(Boulder blder) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDetailRow(blder.grade, Icons.grade, 'Grade: '),
        SizedBox(height: 10),
        _buildDetailRow(blder.colour, Icons.colorize, 'Colour: '),
      ],
    );
  }

  // Widget boulderSection = Column(
  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //   children: [
  //     _buildDetailRow(sessionBoulder.grade, Icons.grade, 'Grade: '),
  //     SizedBox(height: 10),
  //     _buildDetailRow(sessionBoulder.colour, Icons.colorize, 'Colour: '),
  //   ],
  // );
}

Row _buildDetailRow(String content, IconData icon, String label) {
  return Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon),
    SizedBox(width: 15.0),
    Text(label, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    SizedBox(width: 5.0),
    Text(content, style: TextStyle(fontSize: 18))
  ]);
}
