import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }
final GoogleSignIn googleSignIn = GoogleSignIn();

class Auth {

  static void onAuthStateChanged(Function callback) {
    print("code 01 ");
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) {

      if (firebaseUser == null) {
        callback(null);
      } else {
        callback(Auth.userFromFirebaseUser(firebaseUser));
      }
    });
  }

  static User userFromFirebaseUser(FirebaseUser firebaseUser) {
    //var isAnon = firebaseUser.isAnonymous;
    var provider = firebaseUser.providerId;
   // var name = isAnon ? "Anonim" : firebaseUser.displayName;
    //var avatar = isAnon ? "https://firebasestorage.googleapis.com/v0/b/gatrabali.appspot.com/o/app%2Favatar.png?alt=media" : firebaseUser.photoUrl;

    if (firebaseUser.providerData.isNotEmpty) {
      print(firebaseUser.providerData);
//      var info = firebaseUser.providerData.firstWhere((i) {
//        return i.displayName != null && i.displayName.trim().length > 0;
//      });
//      provider = info.providerId;
//      name = info.displayName;
//      avatar = info.photoUrl != null ? info.photoUrl : "https://firebasestorage.googleapis.com/v0/b/gatrabali.appspot.com/o/app%2Favatar.png?alt=media";
    }
    User user = new User();
    //user.fullName=name;
    user.userID=firebaseUser.uid;
    user.provider=provider;
    user.email=firebaseUser.email;
    //user.profilePictureURL=avatar;
    return user;
  }

  static Future<String> signIn(String email, String password) async {
    AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return result.user.uid;
  }

  static Future<String> signInWithGoogle() async {

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    final IdTokenResult idToken = await currentUser.getIdToken(refresh: true);
    // idToken.claims.addEntries(newEntries);`

    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';

  }
//
//  static Future<String> signInWithFacebok(String accessToken) async {
//    final facebookLogin = new FacebookLogin();
//
//    final FacebookLoginResult result = await facebookLogin.logIn(['email']);
//
//    switch (result.status) {
//      case FacebookLoginStatus.loggedIn:
//        final FacebookAccessToken accessToken = result.accessToken;
//        print('''
//         Logged in!
//
//         Token: ${accessToken.token}
//         User id: ${accessToken.userId}
//         Expires: ${accessToken.expires}
//         Permissions: ${accessToken.permissions}
//         Declined permissions: ${accessToken.declinedPermissions}
//         ''');
//        break;
//      case FacebookLoginStatus.cancelledByUser:
//        print('Login cancelled by the user.');
//        break;
//      case FacebookLoginStatus.error:
//        print('Something went wrong with the login process.\n'
//            'Here\'s the error Facebook gave us: ${result.errorMessage}');
//        break;
//    }
//
//    return result.accessToken.userId;
//  }

  static Future<String> signUp(String email, String password) async {
    AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return result.user.uid;
  }


  static Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }

  static Future<FirebaseUser> getCurrentFirebaseUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  static void addUser(User user) async {
    print("inadduser");
    checkUserExist(user.userID).then((value) {
      print("checkUserExist");
      if (!value) {
        print("user ${user.firstName} ${user.email} added");
        Firestore.instance
            .document("users/${user.userID}")
            .setData(user.toJson());
      } else {
        print("user ${user.firstName} ${user.email} exists");
      }
    });
  }

  static Future<bool> checkUserExist(String userID) async {
    bool exists = false;
    try {
      await Firestore.instance.document("users/$userID").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

 static Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  static Stream<User> getUser(String userID) {
    return Firestore.instance
        .collection("users")
        .where("userID", isEqualTo: userID)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.documents.map((doc) {
        return User.fromDocument(doc);
      }).first;
    });
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this e-mail not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'Email address is already taken.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }

}
