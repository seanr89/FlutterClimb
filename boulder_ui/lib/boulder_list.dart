import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class BoulderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // BigCard(pair: pair),
          // Text('Boulder List!'),
          // SizedBox(height: 10),
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Boulders').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Text('Loading...');
              return ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: snapshot.data!.docs.mapIndexed((index, document) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text((index + 1).toString()),
                    ),
                    title: Center(child: Text(document['name'])),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    contentPadding: EdgeInsets.all(10.0),
                    onTap: () {
                      print('Clicked');
                    },
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// class BoulderCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
