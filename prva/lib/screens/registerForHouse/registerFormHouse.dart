import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Creating a new House Profile'),
          ),
        body:
          Column(
              children:<Widget>[
                Row( children: <Widget>[
                  SizedBox(width: 5.0),
                   Expanded(
                     child:Text('Scegli la tipologia:',
                     style: TextStyle(fontSize: 18.0))
                     ),
                     SizedBox(width: 10.0),
                    Expanded(
                      child: DropdownButtonFormField(
                          value: _currentType ?? "Intero appartamento" ,
                            items: typeOfAppartament.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text('${type} '),
                     );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentType = val)
                    )
                    ),
                    SizedBox(width: 5.0),
                ]
                ),
                SizedBox(height: 20.0),
                Row( children: <Widget>[
                  SizedBox(width: 5.0),
                   Expanded(
                     child:Text('Inserisci la città:',
                     style: TextStyle(fontSize: 18.0))
                     ),
                     SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "city"),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter a city' : null,
                        onChanged: (val) {
                          setState(() => _currentCity = val);
                        }),
                    ),
                    SizedBox(width: 5.0),
                    ]),
                  Row( children: <Widget>[
                  SizedBox(width: 5.0),
                   Expanded(
                     child:Text('Inserisci la via:',
                     style: TextStyle(fontSize: 18.0))
                     ),
                     SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "address"),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an address' : null,
                        onChanged: (val) {
                          setState(() => _currentAddress = val);
                        }),
                    ),
                    SizedBox(width: 5.0),

                ]
                ),
                 Row( children: <Widget>[
                  SizedBox(width: 5.0),
                   Expanded(
                     child:Text('Inserisci il prezzo:',
                     style: TextStyle(fontSize: 18.0))
                     ),
                     SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                       keyboardType: TextInputType.number,
                       inputFormatters: <TextInputFormatter>[
                       FilteringTextInputFormatter.digitsOnly
                       ],
                     decoration: InputDecoration(
                     labelText: "price",
                     hintText: "insert price"),
                    validator: (val) =>
                    val!.isEmpty ? 'Please enter a price' : null,
                    onChanged: (val) =>
                    setState(() => _currentPrice = (int.parse(val))),
               )),
                    SizedBox(width: 5.0),
                ]
                ),
                
              ]
          ),
          );
}
}