import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/auth/SignUp.dart';
import 'package:flutter_app/screens/auth/landingPage.dart';
import 'package:flutter_app/screens/auth/phoneLogin.dart';
import 'package:flutter_app/screens/auth/phoneVerification.dart';
import 'package:flutter_app/screens/auth/signIn.dart';
import 'package:flutter_app/screens/main_screen.dart';
import 'package:flutter_app/screens/walkthrough.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final SharedPreferences prefs;
  MyApp({this.prefs});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder>{
        '/walkthrough': (BuildContext context) => new WalkthroughScreen(),
        '/root': (BuildContext context) => new LandingPage(),
        '/signin': (BuildContext context) => new SignIn(),
        '/signup': (BuildContext context) => new SignUp(),
        '/main': (BuildContext context) => new MainScreen(),
        '/phonesignin': (BuildContext context) => new phoneLogin(),
        '/phoneverify': (BuildContext context) => new phoneVerification(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _screenHandler(),

    );
  }

  Widget _screenHandler() {
    bool seen = (prefs.getBool('seen') ?? false);
    if (seen) {
      return new LandingPage();
    } else {
      return new WalkthroughScreen(prefs: prefs);
    }
  }
}