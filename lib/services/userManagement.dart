import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app/scopedModel/app.dart';
import 'package:flutter_app/screens/auth/welcomePage.dart';
import 'package:flutter_app/screens/main_screen.dart';

import 'package:rxdart/rxdart.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';


class UserManagement {
  BehaviorSubject currentUser = BehaviorSubject<String>.seeded("nouser");

  Widget handleAuth(AppModel model) {
    return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new Container(
            color: Colors.white,
          );
        } else {
          if (snapshot.hasData) {
            print(snapshot.data.uid);
            currentUser.add(snapshot.data.uid);
            authorize(context);
           // if(authorize(context) == true) {
              //Navigator.of(context).pop();
              return  ScopedModel<AppModel>(
                  model: model,
                  child: MainScreen(
                firebaseUser: snapshot.data, model: model,
              ));
           // }
//            else {
//            return new Scaffold(
//              body: AppBar(
//                title: Text("Drivers"),
//              ),
//            );
//          }
          } else {
            return WelcomePage();
          }
        }
      },
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  authorize(BuildContext context) {
     FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('users')
          .where('userID', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        print("fffffff");
        docs.documents.forEach((f){
          if (f.data['role'] == 'bo') {
            print("its Business Owner");
                //return true;
              } else {
                print('Not Authorized');
                //return false;
              }
            });

        return false;
      });
    });
  }
}