import 'dart:core';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/authService.dart';
import 'package:flutter_app/ui/validators/text_validators.dart';
import 'package:flutter_app/ui/widgets/custom_alert_dialog.dart';
import 'package:flutter_app/ui/widgets/custom_flat_button.dart';
import 'package:flutter_app/ui/widgets/custom_text_%20field.dart';

class SignUp extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUp> {
  final TextEditingController _fullname = new TextEditingController();
  final TextEditingController _number = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _confirmPassword = new TextEditingController();
  CustomTextField _nameField;
  CustomTextField _phoneField;
  CustomTextField _emailField;
  CustomTextField _passwordField;
  CustomTextField _confirmPasswordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;

  @override
  void initState() {
    super.initState();

    onBackPress = () {
      print("pop");
      Navigator.of(context).pop();
    };

    _nameField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _fullname,
      hint: "Full Name",
      validator: TextValidator.validateName,
    );
    _phoneField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _number,
      hint: "Phone Number",
      validator: TextValidator.validateNumber,
      inputType: TextInputType.number,
    );
    _emailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _email,
      hint: "E-mail Adress",
      inputType: TextInputType.emailAddress,
      validator: TextValidator.validateEmail,
    );
    _passwordField = CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _password,
      obscureText: true,
      hint: "Password",
      validator: TextValidator.validatePassword,
    );
    _confirmPasswordField = CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _confirmPassword,
      obscureText: true,
      hint: "Confirm Password",
      validator: TextValidator.validatePassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 70.0, bottom: 10.0, left: 10.0, right: 10.0),
                      child: Text(
                        "Create new account",
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(212, 20, 15, 1.0),
                          decoration: TextDecoration.none,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "OpenSans",
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                      child: _nameField,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _emailField,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _passwordField,
                    ),

                    Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _confirmPasswordField,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 40.0),
                      child: CustomFlatButton(
                        title: "Sign Up",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          print("hellow");
                          User newUser =  new User();
                          newUser.fullName = _fullname.text;
                          newUser.email = _email.text;
                          newUser.phoneNumber = _number.text;

//                          newUser.role = "BO";
//                          newUser.dob = "";
//                          newUser.firstName = "";
//                          newUser.lastName = "";
//                          newUser.addressLineOne = "";
//                          newUser.addressLineTwo = "";
//                          newUser.profileStatus = "";
//                          newUser.currentLocation = "";
//                          newUser.country = "";
//                          newUser.gender = "";
//                          newUser.postcode = "";
//
//                          newUser.businessName = "";
//                          newUser.businessCategory = "";
//
//                          newUser.drivingLicenceEndDate = "";
//                          newUser.drivingLicenceURL = "";



                          newUser.phoneNumber = "7912838740";


                          _signUp(newUser,_password.text);
                        },
                        splashColor: Colors.black12,
                        borderColor: Color.fromRGBO(59, 89, 152, 1.0),
                        borderWidth: 0,
                        color: Color.fromRGBO(59, 89, 152, 1.0),
                      ),
                    ),
                  ],
                ),
                SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: onBackPress,
                  ),
                ),
              ],
            ),
            Offstage(
              offstage: !_blackVisible,
              child: GestureDetector(
                onTap: () {},
                child: AnimatedOpacity(
                  opacity: _blackVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeBlackVisible() {
    setState(() {
      _blackVisible = !_blackVisible;
    });
  }

  void _signUp(User newUser,
        String password) async {
    print("neforesignupo");
//    if (TextValidator.validateName(fullname) &&
//        TextValidator.validateEmail(email) &&
//        TextValidator.validateNumber(number) &&
//        TextValidator.validatePassword(password)) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _changeBlackVisible();
        await Auth.signUp(newUser.email, password).then((uID) {
          print("insignup");
          newUser.userID = uID;
          Auth.addUser(newUser);
        });
        onBackPress();
      } catch (e) {
        print("Error in sign up: $e");
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: "Signup failed",
          content: exception,
          onPressed: _changeBlackVisible,
        );
     // }
    }
  }

  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }
}
