import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/Screens/Auth/signinscreen.dart';
import 'package:namer_app/Screens/Boulder/boulder_list.dart';
import 'package:namer_app/Screens/Locations/locationspage.dart';
import 'package:namer_app/Screens/Sessions/elapsed_timer.dart';
import 'package:namer_app/Screens/Sessions/session_list.dart';
import 'package:namer_app/Screens/Sessions/session_overlay.dart';
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
                seedColor: Colors.orange, brightness: Brightness.dark)),
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
  final timerWidget = ElapsedTime(
      key: UniqueKey(), timestamp: DateTime.now().millisecondsSinceEpoch);

  static List<Widget> _pages = <Widget>[
    BoulderList(),
    SessionList(),
    LocationsPage(),
    //MySettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Boulder UI'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.play_arrow),
                tooltip: 'Start',
                onPressed: () {
                  showOverlay(context);
                }),
            IconButton(
              icon: const Icon(Icons.login),
              tooltip: 'Sign-in',
              onPressed: () {
                // SignInScreen Nav
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignInScreen()),
                // );
              },
            ),
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
              icon: Icon(Icons.access_alarm_sharp),
              label: 'Sessions',
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

  showOverlay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);

    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
              top: 100,
              left: 20,
              child: Material(
                child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.red,
                    child: timerWidget),
              ),
            ));

    overlayState.insert(overlayEntry);

    await Future.delayed(Duration(seconds: 10));

    overlayEntry.remove();
  }
}
