import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/jobListWidget.dart';
import 'package:flutter_app/screens/postJobs.dart';
import 'package:flutter_app/screens/profileScreen.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/services/authService.dart';
import 'package:flutter_app/screens/notificationScreen.dart';

class MainScreen extends StatefulWidget {
  final FirebaseUser firebaseUser;
  User user;
  MainScreen({this.firebaseUser});

  final _appBarTitles = [
    Text("Jobs"),
    Text("Post Jobs"),
    Text("Account"),
  ];

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  StreamController<int> _countController = StreamController<int>();
  int _selectedIndex;
  List<Widget> _pages;

  @override
  void initState() {
    _selectedIndex = 0;
    _pages = [
      Dashboard(),
      PostJob(),
      ProfilePage(),
    ];
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    Widget profileIcon = Icon(Icons.account_circle);
    Auth.getCurrentFirebaseUser().then((user) =>{
    //user.isEmailVerified
      Auth.getUser(user.uid).listen((user)=>{
          if(user.role == "" || user.role == null) {
          print("nnew user doesn't update details")

          }
    })
  });
//    if (user != null) {
//      profileIcon =
//          CircleAvatar(backgroundImage: NetworkImage(user.avatar), radius: 12);
//    }


//    return  new StreamBuilder<User>(
//      stream: Auth.getUser( widget.firebaseUser.uid),
//      builder: (context, snapshot) {
//        int _currentIndex = 0;
//        int _tabBarCount = 0;
//        if (snapshot.connectionState == ConnectionState.waiting) {
//          return new Container(
//            color: Colors.white,
//          );
//        } else {
//          if (snapshot.hasData) {
//            widget.user = snapshot.data;
            return  Scaffold(
              key: _scaffoldKey,
              appBar: new AppBar(
                elevation: 0.5,
                leading: new IconButton(
                    icon: new Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState.openDrawer()),
                title: widget._appBarTitles[_selectedIndex],
                automaticallyImplyLeading: false,
                actions: <Widget>[
              Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/profile");
                      })
              ),
//                  Padding(
//                      padding: EdgeInsets.only(right: 10.0),
//                      child: IconButton(
//                          icon: Icon(Icons.help),
//                          onPressed: () {
//                            Navigator.of(context).pushNamed("/about");
//                          })),

//                  FlatButton.icon( icon: StreamBuilder(
//                    initialData: _tabBarCount,
//                    stream: _countController.stream,
//                    builder: (_, snapshot) => BadgeIcon(
//                      icon: Icon(Icons.turned_in, size: 25, color: Colors.white),
//                      badgeCount: 2, // set the notification item value
//                    ),
//                  ), label: Text(""),
////                  onPressed: {
////                    Navigator.of(context).pushNamed("/phonesignin");
////                  },
//                   )
                ],
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 100.0,
                          width: 100.0,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                          'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'))),

                      Text(
                        'Tom Cruise',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),],
                )
                      ),
                    Column(
                      children: <Widget>[

                        Text(
                          'Available for freelance',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat'),
                        ),
                        SizedBox(height: 25.0),
                      ],
                    ),
                    ListTile(
                      title: Text('Log Out'),
                      onTap: () {
                        _scaffoldKey.currentState.openEndDrawer();
                        Auth.signOut();
                      },
                    ),
                  ],
                ),
              ),
//              body: StreamBuilder(
//                stream: Auth.getUser(widget.user.userID),
//                builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
//                  print("snapshot " + snapshot.toString() + "---------------");
//                  if (!snapshot.hasData) {
//                      return Center(
//                        child: CircularProgressIndicator(
//                          valueColor: new AlwaysStoppedAnimation<Color>(
//                            Color.fromRGBO(212, 20, 15, 1.0),
//                          ),
//                        ),
//                      );
//                  } else {
//                    return DefaultTabController(
//                      length: 4,
//                      child: new Scaffold(
//                        body: TabBarView(
//                          children: [
//                            HomeScreen(),
//                            new Container(color: Colors.orange,),
//                            BadgeIcon(icon: Icon(
//                                Icons.chat, size: 25),// for inside page
//                              badgeCount: 4),
//                            SettingsScreen(),
//                          ],
//                        ),
//                        bottomNavigationBar: new TabBar(
//                          tabs: [
//                            Tab(
//                              icon: new Icon(Icons.dashboard),
//                            ),
//                            Tab(
//                              icon: new Icon(Icons.mail),
//                            ),
//                            Tab(
//                              icon: StreamBuilder(
//                                initialData: _tabBarCount,
//                                builder: (_, snapshot) => BadgeIcon(
//                                  icon: Icon(Icons.forum, size: 25),
//                                  badgeCount: 4, // set the notification item value
//                                ),
//                              ),
//                            ),
//                            Tab(
//                              icon: new Icon(Icons.settings),
//                            ),
//
//                          ],
//                          labelColor: Colors.blue,
//                          unselectedLabelColor: Colors.blueGrey,
//
//                        ),
//                        backgroundColor: Colors.white,
//                      ),
//                    );
//                  }
//                },
//              ),
            body:  IndexedStack(
              children: _pages,
              index: _selectedIndex,
            ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text("Home")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.today, size: 25),
                      title: Text("Post Jobs")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), title: Text("Account")),
                ],
              ),


            );

        }
      }
