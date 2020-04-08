import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_app/services/authService.dart';
import 'package:flutter_app/ui/validators/text_validators.dart';
import 'package:flutter_app/ui/widgets/custom_flat_button.dart';
import 'package:flutter_app/ui/widgets/custom_alert_dialog.dart';
import 'package:flutter_app/ui/widgets/custom_text_%20field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class phoneLogin extends StatefulWidget {
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<phoneLogin> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  CustomTextField _emailField;
  CustomTextField _passwordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;

  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };

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
                        "Enter phone number",
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
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 10.0, left: 15.0, right: 15.0),
                      child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber number) {
                                  print(number.phoneNumber);
                                },
                                isEnabled: true,
                                autoValidate: true,
                                formatInput: true,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 40.0),
                      child: CustomFlatButton(
                        title: "next",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushNamed("/phoneverify");
                        },
                        splashColor: Colors.black12,
                        borderColor: Color.fromRGBO(212, 20, 15, 1.0),
                        borderWidth: 0,
                        color: Color.fromRGBO(212, 20, 15, 1.0),
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

  void _emailLogin(
      {String email, String password, BuildContext context}) async {
    if (TextValidator.validateEmail(email) &&
        TextValidator.validatePassword(password)) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _changeBlackVisible();
        await Auth.signIn(email, password)
            .then((uid) => Navigator.of(context).pop());
      } catch (e) {
        print("Error in email sign in: $e");
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: "Login failed",
          content: exception,
          onPressed: _changeBlackVisible,
        );
      }
    }
  }

  void _googleLogin(
      {String email, String password, BuildContext context}) async {
    if (TextValidator.validateEmail(email) &&
        TextValidator.validatePassword(password)) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _changeBlackVisible();
        await Auth.signInWithGoogle().then((uid) => Navigator.of(context).pop());
      } catch (e) {
        print("Error in google sign in: $e");
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: "Login failed",
          content: exception,
          onPressed: _changeBlackVisible,
        );
      }
    }
  }

  void _phoneLogin({String email, String password, BuildContext context}) async {

  }

//  void _facebookLogin({BuildContext context}) async {
//    try {
//      SystemChannels.textInput.invokeMethod('TextInput.hide');
//      _changeBlackVisible();
//      FacebookLogin facebookLogin = new FacebookLogin();
//      FacebookLoginResult result = await facebookLogin
//          .logInWithReadPermissions(['email', 'public_profile']);
//      switch (result.status) {
//        case FacebookLoginStatus.loggedIn:
//          Auth.signInWithFacebok(result.accessToken.token).then((uid) {
//            Auth.getCurrentFirebaseUser().then((firebaseUser) {
//              User user = new User(
//                firstName: firebaseUser.displayName,
//                userID: firebaseUser.uid,
//                email: firebaseUser.email ?? '',
//                profilePictureURL: firebaseUser.photoUrl ?? '',
//              );
//              Auth.addUser(user);
//              Navigator.of(context).pop();
//            });
//          });
//          break;
////        case FacebookLoginStatus.cancelledByUser:
////        case FacebookLoginStatus.error:
//          _changeBlackVisible();
//      }
//    } catch (e) {
//      print("Error in facebook sign in: $e");
//      String exception = Auth.getExceptionText(e);
//      _showErrorAlert(
//        title: "Login failed",
//        content: exception,
//        onPressed: _changeBlackVisible,
//      );
//    }
//  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber);
    String parsableNumber = number.parseNumber();

    print(parsableNumber);
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
