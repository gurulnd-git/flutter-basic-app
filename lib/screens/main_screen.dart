import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/profileScreen.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/services/authService.dart';

class MainScreen extends StatefulWidget {
  final FirebaseUser firebaseUser;
  User user;
  MainScreen({this.firebaseUser});

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  new StreamBuilder<User>(
      stream: Auth.getUser( widget.firebaseUser.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new Container(
            color: Colors.white,
          );
        } else {
          if (snapshot.hasData) {
            widget.user = snapshot.data;
            return  Scaffold(
              key: _scaffoldKey,
              appBar: new AppBar(
                elevation: 0.5,
                title: Text("Flutter App"),
                automaticallyImplyLeading: false,
                centerTitle: true,
              ),
              body: StreamBuilder(
                stream: Auth.getUser(widget.user.userID),
                builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                  print("snapshot " + snapshot.toString() + "---------------");
                  if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                            Color.fromRGBO(212, 20, 15, 1.0),
                          ),
                        ),
                      );
                  } else {
                    return DefaultTabController(
                      length: 3,
                      child: new Scaffold(
                        body: TabBarView(
                          children: [
                            HomeScreen(),
                            new Container(color: Colors.orange,),
                           ProfileScreen(),
                          ],
                        ),
                        bottomNavigationBar: new TabBar(
                          tabs: [
                            Tab(
                              icon: new Icon(Icons.list),
                            ),
                            Tab(
                              icon: new Icon(Icons.mail),
                            ),
                            Tab(
                              icon: new Icon(Icons.person),
                            ),

                          ],
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.blueGrey,

                        ),
                        backgroundColor: Colors.white,
                      ),
                    );
                  }
                },
              ),

            );
          } else {
            return Scaffold();
          }
        }
      },
    );






  }

}
