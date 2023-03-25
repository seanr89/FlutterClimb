import 'package:flutter/material.dart';

class BoulderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          //Text('Single Boulder Example'),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InteractiveViewer(
              panEnabled: true, // Set it to false
              boundaryMargin: EdgeInsets.all(50),
              minScale: 1,
              maxScale: 3,
              child: Image.asset(
                'images/Orange_1.jpg',
                width: 250,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          buttonSection,
          //textSection
          BoulderSessionForm()
        ],
      ),
    );
  }

  /// draw out the three buttons into a singular row
  Widget buttonSection = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn(Colors.orange, Icons.call, 'CALL'),
      _buildButtonColumn(Colors.orange, Icons.near_me, 'ROUTE'),
      _buildButtonColumn(Colors.orange, Icons.share, 'SHARE'),
    ],
  );

  // Widget textSection = const Padding(
  //   padding: EdgeInsets.all(22),
  //   child: Text(
  //     'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
  //     'Alps. Situated 1,578 meters above sea level, it is one of the '
  //     'larger Alpine Lakes',
  //     softWrap: true,
  //   ),
  // );
}

/**
 * Base button selector button event
 */
Column _buildButtonColumn(Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 4),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: color,
          ),
        ),
      ),
    ],
  );
}

class BoulderSessionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              print('Saving');
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
