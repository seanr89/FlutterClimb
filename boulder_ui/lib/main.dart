import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/boulder_list.dart';
import 'package:namer_app/locations_listing.dart';
import 'package:namer_app/locationspage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'boulder_detail.dart';
import 'firebase_options.dart';
import 'generatorpage.dart';

Future main() async {
  runApp(MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Boulder App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  // ↓ Add this.
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  // ↓ Add the code below.
  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.call,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = BoulderDetail();
        break;
      case 1:
        page = GeneratorPage();
        break;
      // case 1:
      //   page = FavoritesPage();
      //   break;
      case 2:
        page = LocationsListing();
        break;
      case 3:
        page = LocationsPage();
        break;
      case 4:
        page = BoulderList();
        break;
      default:
        throw UnimplementedError('no widget for $_selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(title: const Text('Boulder UI')),
        bottomNavigationBar: BottomNavigationBar(
          mouseCursor: SystemMouseCursors.grab,
          selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 40),
          selectedItemColor: Colors.amberAccent,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.hiking),
              label: 'Boulder',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_city),
              label: 'Locations',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped, //New
        ),
        //body: BoulderDetail(),
        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),
        // body: Row(
        //   children: [
        //     SafeArea(
        //       child: NavigationRail(
        //         extended:
        //             constraints.maxWidth >= 750, //if width over 500 expand
        //         destinations: [
        //           NavigationRailDestination(
        //             icon: Icon(Icons.hiking),
        //             label: Text('Boulder Det'),
        //           ),
        //           // NavigationRailDestination(
        //           //   icon: Icon(Icons.home),
        //           //   label: Text('Home'),
        //           // ),
        //           // NavigationRailDestination(
        //           //   icon: Icon(Icons.favorite),
        //           //   label: Text('Favorites'),
        //           // ),
        //           NavigationRailDestination(
        //             icon: Icon(Icons.place),
        //             label: Text('Locations'),
        //           ),
        //           NavigationRailDestination(
        //             icon: Icon(Icons.map),
        //             label: Text('Locale'),
        //           ),
        //           NavigationRailDestination(
        //             icon: Icon(Icons.device_unknown),
        //             label: Text('Boulders'),
        //           ),
        //         ],
        //         selectedIndex: selectedIndex,
        //         onDestinationSelected: (value) {
        //           setState(() {
        //             selectedIndex = value;
        //           });
        //         },
        //       ),
        //     ),
        //     Expanded(
        //       child: Container(
        //         color: Theme.of(context).colorScheme.primaryContainer,
        //         child: page,
        //       ),
        //     ),
        //   ],
        // ),
      );
    });
  }

  //New
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
