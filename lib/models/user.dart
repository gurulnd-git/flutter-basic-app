import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userID;
  String firstName;
  String email;
  String lastName;
  String fullName;
  String profilePictureURL;
  String token;
  String provider;
  String phoneNumber;
  String profileStatus;
  String age;

  String role;
  String businessName;
  String businessCategory;
  String landLineNumber;

  String drivingLicenceURL;
  String drivingLicenceEndDate;
  String dob;
  String gender;
  String experience;

  String postcode;
  String county;
  String country;
  String currentLocation;
  String addressLineOne;
  String addressLineTwo;

  String documentID;
  String name;
  String password;
  bool isAdmin;

  User({
    this.documentID,
    this.isAdmin,
    this.name,
    this.password,
    this.userID,
    this.fullName,
    this.email,
    this.profilePictureURL,
  });

  Map<String, Object> toJson() {
    return {
      'userID': userID,
      'firstName': firstName,
      'email': email == null ? '' : email,
      'profilePictureURL': profilePictureURL,
      'appIdentifier': 'flutter-onboarding'
    };
  }

  factory User.fromJson(Map<String, Object> doc) {
    User user = new User(
      userID: doc['userID'],
      fullName: doc['firstName'],
      email: doc['email'],
      profilePictureURL: doc['profilePictureURL'],
    );
    return user;
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }

  factory User.fromFirestore(DocumentSnapshot document) {
    Map data = document.data;

    return User(
      documentID: document.documentID,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      isAdmin: data['isAdmin'] ?? false,
    );
  }
}
