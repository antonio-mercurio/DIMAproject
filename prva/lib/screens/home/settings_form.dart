import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prva/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> cities = [
    "Milano",
    "Roma",
    "Bologna",
    "Padova",
    "Corigliano Calabro"
  ];

  String? _currentOwner;
  String? _currentCity;
  int? _currentCap;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Text('Update your house settings.', style: TextStyle(fontSize: 18.0)),
        SizedBox(height: 20.0),
        TextFormField(
          decoration: textInputDecoration.copyWith(hintText: 'Insert an owner'),
          validator: (val) => val!.isEmpty ? 'Please enter an owner' : null,
          onChanged: (val) => setState(() => _currentOwner = val),
        ),
        SizedBox(height: 20.0),
        // dropdown for cities
        DropdownButtonFormField(
            items: cities.map((city) {
              return DropdownMenuItem(
                value: city,
                child: Text('${city} - città'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentCity = val)),
        // slider
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
              labelText: "zip codet",
              hintText: "insert zip code",
              icon: Icon(Icons.phone_iphone)),
          validator: (val) => val!.isEmpty ? 'Please enter a ZIP code' : null,
          onChanged: (val) => setState(() => _currentCap = (int.parse(val))),
        ),
        ElevatedButton(
            child: Text('Update', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              print(_currentOwner);
              print(_currentCity);
              print(_currentCap);
            })
      ]),
    );
  }
}
