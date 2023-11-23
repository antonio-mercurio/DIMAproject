import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

  final formKey = new GlobalKey<FormState>();
  String? _email;
  String? _password;

 Widget build( BuildContext context){
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
              children : <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value)=> value!.isEmpty ? 'Email can\'t be empty' : null,
                  onSaved: (value) => _email=value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value)=> value!.isEmpty ? 'Password can\'t be empty' : null,
                  onSaved: (value) => _password=value!,
                ),
                ElevatedButton(
                  onPressed: validateAndSave,
                  child: Text('Login')
                ),
              ]
            )
          )
        )
      );
  }

  void validateAndSave() {
    final form = formKey.currentState;
    if(form!.validate()){
      print('Form is valid. Email $_email, password $_password ');
    }else{
       print('Form is not valid');
    }
  }
}