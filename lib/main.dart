import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/model_providers/theme_provider.dart';
import 'package:flutter_app/model_providers/users_provider.dart';
import 'package:flutter_app/model_providers/userx_provider.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/scopedModel/app.dart';
import 'package:flutter_app/screens/spash_screen.dart';
import 'package:flutter_app/utils/get_it.dart';
import 'package:provider/provider.dart';
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
import 'package:flutter_app/utils/navigator.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

UserManagement userObj = new UserManagement();

void main() {
   // Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(AppStart());
}

class AppStart extends StatelessWidget {
  const AppStart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider(isLightTheme: false)),
      ChangeNotifierProvider(create: (context) => UserxProvider()),
      ChangeNotifierProvider(create: (context) => UsersProvider()),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AppModel _model = AppModel();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: locator<NavigationService>().navigatorKey,
      routes: {
        '/walkthrough': (context) => new WalkthroughScreen(),
        '/root': (context) => userObj.handleAuth(this._model),
        '/signin': (context) => new SignIn(),
        '/signup': (context) => new SignUp(),
        '/main': (context) => new MainScreen(),
        '/phonesignin': (context) => new phoneLogin(),
        '/phoneverify': (context) => new phoneVerification(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenPage()
    );
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

