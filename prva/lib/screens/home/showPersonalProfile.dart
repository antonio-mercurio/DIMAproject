import 'package:flutter/material.dart';
import 'package:prva/screens/home/filtersForm.dart';

class ShowPersonalProfile extends StatefulWidget {
  const ShowPersonalProfile({super.key});

  @override
  State<ShowPersonalProfile> createState() => _ShowPersonalProfileState();
}

class _ShowPersonalProfileState extends State<ShowPersonalProfile> {
  @override
  Widget build(BuildContext context) {
    void _showFiltersPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: FiltersForm(),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text('Personal page'),
      actions: <Widget>[
        TextButton.icon(
          icon: Icon(Icons.settings),
          label: Text('Filters'),
          onPressed: () async {
            _showFiltersPanel();
          },
        ),
      ],
    ));
  }
}
