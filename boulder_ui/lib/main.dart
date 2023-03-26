import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/boulder_list.dart';
import 'package:namer_app/locations_listing.dart';
import 'package:namer_app/locationspage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'boulder_detail.dart';
import 'firebase_options.dart';

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
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
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
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(title: const Text('Boulder UI')),
        bottomNavigationBar: BottomNavigationBar(
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
        ),
        body: BoulderDetail(),
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
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Basic favorites pages
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text('You have '
                    '${appState.favorites.length} favorites:'),
              ),
              for (var pair in appState.favorites)
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text(pair.asLowerCase),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Example of a big card for showing the Random Text control
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // ← Add this.
    // ↓ Add this.
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary, // ← And also this.
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}
