import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/user.dart';
import 'package:prva/services/databaseFilterPerson.dart';
import 'package:prva/services/databaseForHouseProfile.dart';
import 'package:prva/shared/constants.dart';

class RegisterFormHouse extends StatefulWidget {
  const RegisterFormHouse({super.key});

  @override
  State<RegisterFormHouse> createState() => _RegisterFormHouseState();
}

class _RegisterFormHouseState extends State<RegisterFormHouse> {
  final List<String> typeOfAppartament = [
    "Intero appartamento",
    "Stanza Singola",
    "Stanza Doppia",
    "Monolocale",
    "Bilocale",
    "Trilocale"
  ];

  String? _currentType;
  String? _currentAddress;
  String? _currentCity;
  int? _currentPrice;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Creating a new House Profile'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                SizedBox(height: 20.0),
                Text('Scegli la tipologia:', style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                    value: _currentType ?? "Intero appartamento",
                    items: typeOfAppartament.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text('${type} '),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentType = val)),
                SizedBox(height: 20.0),
                Text('Inserisci la città:', style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "city"),
                    validator: (val) => val!.isEmpty ? 'Enter a city' : null,
                    onChanged: (val) {
                      setState(() => _currentCity = val);
                    }),
                SizedBox(height: 20.0),
                Text('Inserisci la via:', style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 10.0),
                TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: "address"),
                    validator: (val) =>
                        val!.isEmpty ? 'Enter an address' : null,
                    onChanged: (val) {
                      setState(() => _currentAddress = val);
                    }),
                SizedBox(height: 20.0),
                Text('Inserisci il prezzo:', style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      labelText: "price", hintText: "insert price"),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a price' : null,
                  onChanged: (val) =>
                      setState(() => _currentPrice = (int.parse(val))),
                ),
                SizedBox(height: 20.0),
                SizedBox(height: 20.0),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        //print('valid');
                        try {
                          String newHouseID =
                              await DatabaseServiceHouseProfile(user.uid)
                                  .createUserDataHouseProfile(
                            _currentType ?? '',
                            _currentAddress ?? '',
                            _currentCity ?? '',
                            _currentPrice ?? 0,
                          );
                          print(newHouseID);
                          //final CollectionReference filtersPersonCollection = FirebaseFirestore.instance.collection('filtersPerson');
                          //await DatabaseServiceFiltersPerson(uid: newHouseID).updateFiltersPerson(0, 100);
                          Navigator.pop(context);
                        } catch (e) {
                          print(e.toString());
                          return null;
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pink),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    )),
              ]),
            )));
  }
}
