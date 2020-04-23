import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/scopedModel/app.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/auth/SignUp.dart';
import 'package:flutter_app/screens/auth/phoneLogin.dart';
import 'package:flutter_app/screens/auth/phoneVerification.dart';
import 'package:flutter_app/screens/auth/signIn.dart';
import 'package:flutter_app/screens/main_screen.dart';
import 'package:flutter_app/screens/walkthrough.dart';
import 'package:flutter_app/services/authService.dart';
import 'package:flutter_app/services/userManagement.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

UserManagement userObj = new UserManagement();

void main()  async {
   // Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AppModel _model = AppModel();
  final SharedPreferences prefs;
  MyApp({this.prefs});



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder>{
        '/walkthrough': (BuildContext context) => new WalkthroughScreen(),
        '/root': (BuildContext context) => userObj.handleAuth(this._model),
        '/signin': (BuildContext context) => new SignIn(),
        '/signup': (BuildContext context) => new SignUp(),
        '/main': (BuildContext context) => new MainScreen(),
        '/phonesignin': (BuildContext context) => new phoneLogin(),
        '/phoneverify': (BuildContext context) => new phoneVerification(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScopedModel<AppModel>(
        model: _model,
        child: _screenHandler(),
      ));
  }
  

  Widget _screenHandler() {
    bool seen = (prefs.getBool('seen') ?? false);
    if (seen) {
      return AppController(model: this._model);
    } else {
      return WalkthroughScreen(prefs: prefs, model: this._model);
    }
  }
}

class AppController extends StatefulWidget {
  final AppModel model;
  AppController({this.model});
  @override
  _AppControllerState createState() => _AppControllerState();
}

class _AppControllerState extends State<AppController> {

  @override
  void initState() {

    Auth.onAuthStateChanged((User user) {
      AppModel.of(context).setUser(user);
      if (user != null) {
        // _enableMessaging(user);
        print("Auth State change method");
        print(user.email);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Auth State change method 0");
    return ScopedModel<AppModel>(
        model: widget.model,
        child: userObj.handleAuth(widget.model)
    );
  }
}

