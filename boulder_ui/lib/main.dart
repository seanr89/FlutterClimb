import 'package:flutter/material.dart';
import 'package:namer_app/Screens/Auth/signinscreen.dart';
import 'package:namer_app/boulder_list.dart';
import 'package:namer_app/Screens/Defunct/locationspage.dart';
import 'package:namer_app/mysettings.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'assets/utils.dart';
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
        scaffoldMessengerKey: Utils.messengerKey,
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
            IconButton(
              icon: const Icon(Icons.login),
              tooltip: 'Sign-in',
              onPressed: () {
                // SignInScreen Nav
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                // SettingsScreen Nav
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MySettings()),
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
