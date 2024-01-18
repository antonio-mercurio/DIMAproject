import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/user.dart';
import 'package:prva/services/databaseForFilters.dart';


class FiltersForm extends StatefulWidget {
  const FiltersForm({super.key});

  @override
  State<FiltersForm> createState() => _FiltersFormState();
}

class _FiltersFormState extends State<FiltersForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> typeOfAppartament = [
    "any",
    "Intero appartamento",
    "Stanza Singola",
    "Stanza Doppia",
    "Monolocale",
    "Bilocale",
    "Trilocale"
  ];
  final List<String> cities = [
    "any",
    "Milano",
    "Roma",
    "Bologna",
    "Padova",
    "Corigliano Calabro"
  ];
  String? _currentCity;
  String? _currentType;
  double? _currentBudget;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);

    return StreamBuilder<Filters>(
      stream: DatabaseServiceFilters(user.uid).getFilters,
      builder: (context, snapshot) {
        Filters? filters = snapshot.data;
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
                SizedBox(height: 20.0),
                Slider(
                  value: _currentBudget ?? 0.0,
                  min: 0,
                  max: 100,
                  label: _currentBudget?.round().toString(),
                  divisions: 20,
                  onChanged: (double value) {
                    setState(() {
                      _currentBudget = value;
                    });
                  },
                ),
                ElevatedButton(
                    child: Text('Set filters',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseServiceFilters(user?.uid).updateFilters(
                          _currentCity ?? filters!.city!,
                          _currentType ?? filters!.type!,
                          _currentBudget ?? filters!.budget!,
                        );
                      }
                      ;
                      Navigator.pop(context);
                    })
              ],
            ));
      },
    );
  }
}
