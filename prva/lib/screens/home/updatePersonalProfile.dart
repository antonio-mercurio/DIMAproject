import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseForFilters.dart';
import 'package:prva/shared/constants.dart';
import 'package:prva/shared/loading.dart';

class UpdatePersonalProfile extends StatefulWidget {
  final PersonalProfile personalProfile;
  const UpdatePersonalProfile({required this.personalProfile});

  @override
  State<UpdatePersonalProfile> createState() =>
      _UpdatePersonalProfileState(personalProfile: personalProfile);
}

class _UpdatePersonalProfileState extends State<UpdatePersonalProfile> {
  final _formKey = GlobalKey<FormState>();
  final PersonalProfile personalProfile;
  _UpdatePersonalProfileState({required this.personalProfile});
  String? _name;
  String? _surname;
  int? _age;
  @override
  Widget build(BuildContext context) {
    if (personalProfile == null) {
      return Loading();
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('Update Personal Profile'),
          ),
          body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Text('Update your personal profile.',
                      style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: personalProfile.name,
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Insert your name'),
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _name = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: personalProfile.surname,
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Insert your surname'),
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a surname' : null,
                    onChanged: (val) => setState(() => _surname = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: personalProfile.age.toString(),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        labelText: "age",
                        hintText: "Insert your age.",
                        icon: Icon(Icons.phone_iphone)),
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter your age' : null,
                    onChanged: (val) => setState(() => _age = (int.parse(val))),
                  ),
                  ElevatedButton(
                    child: Text('Update profile'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(personalProfile?.uid)
                            .updatePersonalProfile(
                                _name ?? personalProfile.name,
                                _surname ?? personalProfile.surname,
                                _age ?? personalProfile.age);
                        Navigator.pop(context);
                      }
                    },
                  )
                ]),
              )));
    }
  }
}
