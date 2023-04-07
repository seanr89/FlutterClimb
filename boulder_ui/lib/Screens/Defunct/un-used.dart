

//  IconButton(
//               icon: const Icon(Icons.bug_report),
//               tooltip: 'Show Dialog',
//               onPressed: () {
//                 showDialog(context: context, builder: (_) => ExampleDialog());
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text("Success"),
//                         content: Text("Saved successfully"),
//                       );
//                     });
//               },
//             ),

// IconButton(
//   icon: const Icon(Icons.add_alert),
//   tooltip: 'Show Snackbar',
//   onPressed: () {
//     ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('This is a snackbar')));
//   },
// ),

  //Load Image via querying storage URL
  // Future<String> loadImage() async {
  //   //select the image url
  //   String url = await fileStorage.getDownloadURLFromRef(currentBoulder.imgRef);
  //   //print('url: $url');
  //   return url;
  // }

  //padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),