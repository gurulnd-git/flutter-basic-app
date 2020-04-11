import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/auth/welcomePage.dart';
import 'package:flutter_app/screens/main_screen.dart';
import 'package:flutter_app/services/authService.dart';

class LandingPage extends StatefulWidget {
  FirebaseUser user;
  String error;

  void setUser(FirebaseUser user) {

      this.user = user;
      this.error = null;

  }
  @override
  void initState() {

    FirebaseAuth.instance.currentUser().then(setUser);
  }

  @override
  State<StatefulWidget> createState() => new _RootScreenState();
}

class _RootScreenState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser();
    return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new Container(
            color: Colors.white,
          );
        } else {
          if (snapshot.hasData) {
            return new MainScreen(
              firebaseUser: snapshot.data,
            );
          } else {
            return WelcomePage();
          }
        }
      },
    );
  }
}
