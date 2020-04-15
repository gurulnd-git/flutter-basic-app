import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// For changing the language
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/cupertino.dart';

class PostJob extends StatefulWidget {
  @override
  _PostJobState createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          padding: EdgeInsets.all(24),
          children: <Widget>[
            DateTimeForm(),
          ],
        ));
  }
}

class DateTimeForm extends StatefulWidget {
  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}

class _DateTimeFormState extends State<DateTimeForm> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(children: <Widget>[
            FormBuilder(
              key: _fbKey,
              initialValue: {
                'date': DateTime.now(),
                'accept_terms': false,
              },
              autovalidate: true,
              child: Column(
                children: <Widget>[

                  FormBuilderDateTimePicker(
                    attribute: "date",
                    inputType: InputType.both,
                    format: DateFormat("yyyy-MM-dd HH:mm"),
                    decoration:
                    InputDecoration(labelText: "Appointment Time"),
                  ),
                  SizedBox(height: 24),
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: "Duration"),
                    attribute: "stepper",
                    initialValue: 1,
                    step: 1,
                  ),
                  SizedBox(height: 24),
                  FormBuilderCheckbox(
                    attribute: 'accept_terms',
                    label: Text(
                        "I have read and agree to the terms and conditions"),
                    validators: [
                      FormBuilderValidators.requiredTrue(
                        errorText:
                        "You must accept terms and conditions to continue",
                      ),
                    ],
                  ),

                  FormBuilderSignaturePad(
                    decoration: InputDecoration(labelText: "Signature"),
                    attribute: "signature",
                    height: 100,
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value);
                    }
                  },
                ),
              ],
            )
          ],
          )
        ],
      ),
    );
  }
}
