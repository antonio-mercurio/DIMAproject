import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  String? _email;
  String? _password;
  FormType _formType = FormType.login;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter login demo'),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: buildInputs() + buildSubmitButtons(),
                ))));
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      print('Form is valid. Email $_email, password $_password ');
      return true;
    } else {
      print('Form is not valid');
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          await Firebase.initializeApp();
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email!, password: _password!);
          print('signed in: $_email');
        } else {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email!, password: _password!);
          print('signed in: ${user.credential}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    setState(() {
      _formType = FormType.register;
    });
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) => value!.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value!,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) =>
            value!.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value!,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        ElevatedButton(onPressed: validateAndSubmit, child: Text('Login')),
        ElevatedButton(
          onPressed: moveToRegister,
          child: Text('Create an account'),
        )
      ];
    } else {
      return [
        ElevatedButton(
            onPressed: validateAndSubmit, child: Text('Create an account')),
        ElevatedButton(
          onPressed: moveToLogin,
          child: Text('Have an account? Login'),
        )
      ];
    }
  }

  void moveToLogin() {
    setState(() {
      _formType = FormType.login;
    });
  }
}
