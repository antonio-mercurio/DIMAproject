import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/login/createProfile.dart';
import 'package:prva/services/auth.dart';
import 'package:prva/services/database.dart';
import 'package:prva/shared/constants.dart';
import 'package:prva/shared/loading.dart';

class Register extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name = "Giacomo";
  String surname = "Lollipop";
  int age = 34;
  CollectionReference personalProfiles =
      FirebaseFirestore.instance.collection('personalProfiles');
  Future<void> createPersonalProfile() {
    // Call the user's CollectionReference to add a new user
    return personalProfiles
        .add({
          'name': name, // John Doe
          'surname': surname, // Stokes and Sons
          'age': age // 42
        })
        .then((value) => print("Personal Profile Created"))
        .catchError(
            (error) => print("Failed to create personal profile - $error"));
  }

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String userID = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    ;
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.amber[100],
            appBar: AppBar(
                backgroundColor: Colors.amber[400],
                elevation: 0.0,
                title: Text('Sign up'),
                actions: <Widget>[
                  TextButton.icon(
                      onPressed: () {
                        widget.toggleView();
                      },
                      icon: Icon(Icons.person),
                      label: Text('Sign In'))
                ]),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            print(email);
                            print(password);
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'invalid email';
                                loading = false;
                              });
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
/*
class CreatePersonalProfile extends StatefulWidget {
  @override
  State<CreatePersonalProfile> createState() => _CreatePersonalProfileState();
}

class _CreatePersonalProfileState extends State<CreatePersonalProfile> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String surname = '';
  int age = 0;
  @override
  Widget build(BuildContext context) {
    final persProf = Provider.of<PersonalProfile>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Creazione nuovo profilo in corso:'),
        backgroundColor: Colors.red,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Insert your name here'),
                  validator: (val) => val!.isEmpty ? 'Enter your name' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Insert your surname here'),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter your surname' : null,
                  onChanged: (val) {
                    setState(() => surname = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  initialValue: "",
                  decoration: InputDecoration(
                    labelText: "age",
                    hintText: "insert your age here",
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter your age' : null,
                  onChanged: (val) => setState(() => age = (int.parse(val))),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate())
                        await DatabaseService(persProf?.uid)
                            .updatePersonalProfile(
                          persProf?.uid ?? "",
                          name ?? 'Antonio',
                          surname ?? 'Mercurio',
                          age ?? 22,
                        );
                      print(name);
                      print(surname);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatePersonalProfile2()),
                      );
                    },
                    child: Text('Nome e cognome invio')),
              ],
            ),
          )),
    );
  }
}

class CreatePersonalProfile2 extends StatefulWidget {
  @override
  State<CreatePersonalProfile2> createState() => _CreatePersonalProfileState2();
}

class _CreatePersonalProfileState2 extends State<CreatePersonalProfile2> {
  String name = '';
  String surname = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creazione nuovo profilo in corso - schermata 2:'),
        backgroundColor: Colors.red,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Inserimento dati 2'),
                  validator: (val) => val!.isEmpty ? 'Enter your name' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Inserimento dati 3'),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter your surname' : null,
                  onChanged: (val) {
                    setState(() => surname = val);
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                    onPressed: () {
                      print(name);
                      print(surname);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('dati2 invio')),
              ],
            ),
          )),
    );
  }
}
*/