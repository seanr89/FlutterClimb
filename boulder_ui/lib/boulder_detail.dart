import 'package:flutter/material.dart';

class BoulderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ListView(
          children: [
            Text('Available Boulders'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InteractiveViewer(
                panEnabled: false, // Set it to false
                boundaryMargin: EdgeInsets.all(100),
                minScale: 1,
                maxScale: 3,
                child: Image.asset(
                  'images/Orange_1.jpg',
                  width: 200,
                  height: 500,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            buttonSection,
            textSection
          ],
        ),
      ),
    );
  }

  /**
   * draw out the three buttons into a singular row
   */
  Widget buttonSection = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn(Colors.orange, Icons.call, 'CALL'),
      _buildButtonColumn(Colors.orange, Icons.near_me, 'ROUTE'),
      _buildButtonColumn(Colors.orange, Icons.share, 'SHARE'),
    ],
  );

  Widget textSection = const Padding(
    padding: EdgeInsets.all(32),
    child: Text(
      'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
      'Alps. Situated 1,578 meters above sea level, it is one of the '
      'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
      'half-hour walk through pastures and pine forest, leads you to the '
      'lake, which warms to 20 degrees Celsius in the summer. Activities '
      'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true,
    ),
  );
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
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}
