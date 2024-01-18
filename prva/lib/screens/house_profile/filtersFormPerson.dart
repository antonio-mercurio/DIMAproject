import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/services/databaseFilterPerson.dart';

//Class used by House Profile to use the filter to filter per people interested in
class FiltersFormPerson extends StatefulWidget {
  final String uidHouse;
  const FiltersFormPerson({required this.uidHouse});

  @override
  State<FiltersFormPerson> createState() =>
      _FiltersFormPersonState(uidHouse: uidHouse);
}

class _FiltersFormPersonState extends State<FiltersFormPerson> {
  final String uidHouse;
  _FiltersFormPersonState({required this.uidHouse});

  int? _currentMaxAge;
  int? _currentMinAge;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FiltersPerson>(
      stream: DatabaseServiceFiltersPerson(uid: uidHouse).getFiltersPerson,
      builder: (context, snapshot) {
        FiltersPerson? filters = snapshot.data;
        print('filters has data');
        return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Set your filters.'),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  initialValue: filters?.minAge.toString(),
                  decoration: InputDecoration(
                    labelText: "min Age",
                    hintText: "insert min Age",
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a valid Age' : null,
                  onChanged: (val) =>
                      setState(() => _currentMinAge = (int.parse(val))),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  initialValue: filters?.maxAge.toString(),
                  decoration: InputDecoration(
                    labelText: "max Age",
                    hintText: "insert max Age",
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a valid Age' : null,
                  onChanged: (val) =>
                      setState(() => _currentMaxAge = (int.parse(val))),
                ),
                ElevatedButton(
                    child: Text('Set filters',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseServiceFiltersPerson(uid: uidHouse)
                            .updateFiltersPerson(
                          _currentMinAge ?? filters!.minAge,
                          _currentMaxAge ?? filters!.maxAge,
                        );
                      }
                      Navigator.pop(context);
                    })
              ],
            ));
      },
    );
  }
}
