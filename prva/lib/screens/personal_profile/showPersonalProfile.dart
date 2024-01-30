import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/personal_profile/allHousesList.dart';
import 'package:prva/screens/personal_profile/filtersForm.dart';
import 'package:prva/services/auth.dart';
import 'package:prva/services/databaseForHouseProfile.dart';

class ShowPersonalProfile extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
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

    return StreamProvider<List<HouseProfileAdj>>.value(
      value: DatabaseServiceHouseProfile(null).getAllHousesAdj,
      initialData: [],
      child: Scaffold(
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
        ),
        body: AllHousesList(),
      ),
    );
  }
}
