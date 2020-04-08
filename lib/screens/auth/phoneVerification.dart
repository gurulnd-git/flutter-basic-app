import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/auth/code.dart';
import 'package:flutter_app/services/authService.dart';
import 'package:flutter_app/ui/validators/text_validators.dart';
import 'package:flutter_app/ui/widgets/custom_flat_button.dart';
import 'package:flutter_app/ui/widgets/custom_alert_dialog.dart';
import 'package:flutter_app/ui/widgets/custom_text_%20field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class phoneVerification extends StatefulWidget {
  _PhoneVerificationScreenState createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<phoneVerification> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  CustomTextField _emailField;
  CustomTextField _passwordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;

  double _height, _width, _fixedPadding;

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  String code = "";

  Color cardBackgroundColor = Color(0xFFFCA967);
  //String logo = Assets.firebase;

  @override
  void initState() {
    FirebasePhoneAuth.phoneAuthState.stream
        .listen((PhoneAuthState state) => print(state));
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
                        "Enter verification code",
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
                        child: _getColumnBody(),
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


  /*
   *  Widget hierarchy ->
   *    Scaffold -> SafeArea -> Center -> SingleChildScrollView -> Card()
   *    Card -> FutureBuilder -> Column()
   */
  Widget _getBody() => Card(
    color: cardBackgroundColor,
    elevation: 2.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    child: SizedBox(
      height: _height * 8 / 10,
      width: _width * 8 / 10,
      child: _getColumnBody(),
    ),
  );

  Widget _getColumnBody() => Column(
    children: <Widget>[

      SizedBox(height: 20.0),

      //  Info text
      Row(
        children: <Widget>[
          SizedBox(width: 16.0),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Please enter the ',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: 'One Time Password',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700)),
                  TextSpan(
                    text: ' sent to your mobile',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.0),
        ],
      ),

      SizedBox(height: 16.0),

      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getPinField(key: "1", focusNode: focusNode1),
          SizedBox(width: 5.0),
          getPinField(key: "2", focusNode: focusNode2),
          SizedBox(width: 5.0),
          getPinField(key: "3", focusNode: focusNode3),
          SizedBox(width: 5.0),
          getPinField(key: "4", focusNode: focusNode4),
          SizedBox(width: 5.0),
          getPinField(key: "5", focusNode: focusNode5),
          SizedBox(width: 5.0),
          getPinField(key: "6", focusNode: focusNode6),
          SizedBox(width: 5.0),
        ],
      ),

      SizedBox(height: 32.0),

      RaisedButton(
        elevation: 16.0,
        onPressed: signIn,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'VERIFY',
            style: TextStyle(
                color: Colors.white, fontSize: 18.0),
          ),
        ),
        color: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)),
      )
    ],
  );

  signIn() {
    if (code.length != 6) {
      //  TODO: show error
    }
    FirebasePhoneAuth.signInWithPhoneNumber(smsCode: code);
  }

  // This will return pin field - it accepts only single char
  Widget getPinField({String key, FocusNode focusNode}) => SizedBox(
    height: 40.0,
    width: 35.0,
    child: TextField(
      key: Key(key),
      expands: false,
      autofocus: key.contains("1") ? true : false,
      focusNode: focusNode,
      onChanged: (String value) {
        if (value.length == 1) {
          code += value;
          switch (code.length) {
            case 1:
              FocusScope.of(context).requestFocus(focusNode2);
              break;
            case 2:
              FocusScope.of(context).requestFocus(focusNode3);
              break;
            case 3:
              FocusScope.of(context).requestFocus(focusNode4);
              break;
            case 4:
              FocusScope.of(context).requestFocus(focusNode5);
              break;
            case 5:
              FocusScope.of(context).requestFocus(focusNode6);
              break;
            default:
              FocusScope.of(context).requestFocus(FocusNode());
              break;
          }
        }
      },
      maxLengthEnforced: false,
      textAlign: TextAlign.center,
      cursorColor: Colors.red,
      keyboardType: TextInputType.number,
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.red),
//          decoration: InputDecoration(
//              contentPadding: const EdgeInsets.only(
//                  bottom: 10.0, top: 10.0, left: 4.0, right: 4.0),
//              focusedBorder: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(5.0),
//                  borderSide:
//                      BorderSide(color: Colors.blueAccent, width: 2.25)),
//              border: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(5.0),
//                  borderSide: BorderSide(color: Colors.white))),
    ),
  );
  void _changeBlackVisible() {
    setState(() {
      _blackVisible = !_blackVisible;
    });
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
