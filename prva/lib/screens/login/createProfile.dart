import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/services/database.dart';
import 'package:prva/shared/constants.dart';
import 'package:prva/shared/loading.dart';

class CreatePersonalProfile extends StatefulWidget {
  const CreatePersonalProfile({super.key});

  @override
  State<CreatePersonalProfile> createState() => _CreatePersonalProfileState();
}

class _CreatePersonalProfileState extends State<CreatePersonalProfile> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _surname;
  int? _age;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente?>(context);
    if (user == null) {
      return Loading();
    } else {
      return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.amber[400],
              elevation: 0.0,
              title: Text('Sign up')),
          body: StreamBuilder<PersonalProfile>(
            stream: DatabaseService(user!.uid).persProfileData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                PersonalProfile? persProfileData = snapshot.data;
                return Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Text('Create your personal profile.',
                        style: TextStyle(fontSize: 18.0)),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: persProfileData?.name,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Insert your name'),
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _name = val),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: persProfileData?.surname,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Insert your surname'),
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter a surname' : null,
                      onChanged: (val) => setState(() => _surname = val),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      initialValue: persProfileData?.age.toString(),
                      decoration: InputDecoration(
                          labelText: "age",
                          hintText: "Insert your age.",
                          icon: Icon(Icons.phone_iphone)),
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter your age' : null,
                      onChanged: (val) =>
                          setState(() => _age = (int.parse(val))),
                    ),
                    ElevatedButton(
                        child: Text('Create',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService(user?.uid)
                                .updatePersonalProfile(
                              _name ?? persProfileData!.name,
                              _surname ?? persProfileData!.surname,
                              _age ?? persProfileData!.age,
                            );
                            Navigator.pop(context);
                          }
                          ;
                        })
                  ]),
                );
              } else {
                return Loading();
              }
            },
          ));
    }
  }
}
