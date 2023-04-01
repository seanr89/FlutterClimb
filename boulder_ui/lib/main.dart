import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Screens/dialog/ExampleDialog.dart';
import 'package:namer_app/Screens/signinscreen.dart';
import 'package:namer_app/boulder_list.dart';
import 'package:namer_app/locationspage.dart';
import 'package:namer_app/mysettings.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue, brightness: Brightness.dark)),
        themeMode: ThemeMode.dark,
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;
  static List<Widget> _pages = <Widget>[
    //BoulderDetail(),
    //LocationsPage(),
    BoulderList(),
    LocationsPage(),
    MySettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Boulder UI'),
          actions: <Widget>[
            // IconButton(
            //   icon: const Icon(Icons.add_alert),
            //   tooltip: 'Show Snackbar',
            //   onPressed: () {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text('This is a snackbar')));
            //   },
            // ),
            IconButton(
              icon: const Icon(Icons.bug_report),
              tooltip: 'Show Dialog',
              onPressed: () {
                showDialog(context: context, builder: (_) => ExampleDialog());
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         title: Text("Success"),
                //         content: Text("Saved successfully"),
                //       );
                //     });
              },
            ),
            IconButton(
              icon: const Icon(Icons.login),
              tooltip: 'Sign-in',
              onPressed: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('This is a snackbar')));
                // BoulderDetail() should be name of the screen to nav too
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          mouseCursor: SystemMouseCursors.grab,
          selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 40),
          selectedItemColor: Colors.amberAccent,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.hiking),
              label: 'Boulders',
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
        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),
      );
    });
  }

  //New - navigation click events
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
