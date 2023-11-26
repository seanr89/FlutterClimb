import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Services/Firestore.Collection.dart';
import 'package:namer_app/Screens/Boulder/boulder_detail.dart';
import '../../models/Boulder.dart';

/**
 * BoulderList - Boulder listing page
 * Steps:
 * 1. Initialize the BoulderList class
 * 2. Build the Scaffold
 * 3. Query the boulder data from Firestore
 * 4. visualize the data in a ListView
 */
class BoulderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boulder List"),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.plus_one),
              tooltip: 'Add',
              onPressed: () {
                //showOverlay(context);
              })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<Boulder>>(
            future: FirestoreCollection.getAllBoulderEntries("Boulders"),
            builder: (context, AsyncSnapshot<List<Boulder>> snapshot) {
              if (!snapshot.hasData) return Text('Loading...');
              return Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data!.mapIndexed((index, boulder) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        tileColor: Colors.orange,
                        title: Center(child: Text(boulder.name ?? "Boulder")),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.all(12.0),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BoulderDetail(currentBoulder: boulder)),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print("Create New Clicked!");
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => BoulderCreate()),
      //     );
      //     //showOverlay(context);
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
