import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/user.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseForFilters.dart';
import 'package:prva/shared/loading.dart';

class FiltersForm extends StatefulWidget {
  const FiltersForm({super.key});

  @override
  State<FiltersForm> createState() => _FiltersFormState();
}

class _FiltersFormState extends State<FiltersForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> typeOfAppartament = [
    "Intero appartamento",
    "Stanza Singola",
    "Stanza Doppia",
    "Monolocale",
    "Bilocale",
    "Trilocale"
  ];
  final List<String> cities = [
    "Milano",
    "Roma",
    "Bologna",
    "Padova",
    "Corigliano Calabro"
  ];
  String? _currentCity;
  String? _currentType;
  int? _currentBudget;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);

    return StreamBuilder<Filters>(
      stream: DatabaseServiceFilters(user.uid).getFilters,
      builder: (context, snapshot) {
        Filters? filters = snapshot.data;
        if (snapshot.hasData) {
          print('filters has data');
          return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Set your filters.'),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                      value: _currentCity ?? filters?.city,
                      items: cities.map((city) {
                        return DropdownMenuItem(
                          value: city,
                          child: Text('${city} - città'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentCity = val)),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                      value: _currentType ?? filters?.type,
                      items: typeOfAppartament.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text('${type} '),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentType = val)),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    initialValue: _currentBudget?.toString() ??
                        filters?.budget.toString(),
                    decoration: InputDecoration(
                        labelText: "Insert your budget",
                        hintText: "insert your budget",
                        icon: Icon(Icons.money)),
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a budget' : null,
                    onChanged: (val) =>
                        setState(() => _currentBudget = (int.parse(val))),
                  ),
                  ElevatedButton(
                      child: Text('Set filters',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseServiceFilters(user?.uid).updateFilters(
                            _currentCity ?? filters!.city,
                            _currentType ?? filters!.type,
                            _currentBudget ?? filters!.budget,
                          );
                        }
                        ;
                        Navigator.pop(context);
                      })
                ],
              ));
        } else {
          return Loading();
        }
      },
    );
  }
}
