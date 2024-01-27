import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/services/database.dart';
import 'package:prva/shared/constants.dart';
import 'package:prva/shared/loading.dart';
/*
class PersonalProfileForm extends StatefulWidget {
  const PersonalProfileForm({super.key});

  @override
  State<PersonalProfileForm> createState() => _PersonalProfileFormState();
}

class _PersonalProfileFormState extends State<PersonalProfileForm> {
  final _formKey = GlobalKey<FormState>();

  String? _currentName;
  String? _currentSurname;
  int? _currentAge;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    return StreamBuilder<PersonalProfile>(
      stream: DatabaseService(user.uid).persProfileData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          PersonalProfile? persProfileData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Text('Update your personal profile.',
                  style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: persProfileData?.name,
                decoration:
                    textInputDecoration.copyWith(hintText: 'Change your name'),
                validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: persProfileData?.surname,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Change your surname'),
                validator: (val) =>
                    val!.isEmpty ? 'Please enter a surname' : null,
                onChanged: (val) => setState(() => _currentSurname = val),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                initialValue: persProfileData?.age.toString(),
                decoration: InputDecoration(
                    labelText: "Age",
                    hintText: "Insert your age",
                    icon: Icon(Icons.calendar_today)),
                validator: (val) =>
                    val!.isEmpty ? 'Please enter your age' : null,
                onChanged: (val) =>
                    setState(() => _currentAge = (int.parse(val))),
              ),
              ElevatedButton(
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(user?.uid).updatePersonalProfile(
                        _currentName ?? persProfileData!.name,
                        _currentSurname ?? persProfileData!.surname,
                        _currentAge ?? persProfileData!.age,
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
    );
  }
}
*/
