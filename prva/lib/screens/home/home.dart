import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prva/models/house.dart';
import 'package:prva/screens/home/houses_list.dart';
import 'package:prva/screens/home/personalProfileForm.dart';
import 'package:prva/screens/home/settings_form.dart';
import 'package:prva/screens/registerForHouse/registerFormHouse.dart';
import 'package:prva/services/auth.dart';
import 'package:prva/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: PersonalProfileForm(),
            );
          });
    }

    return StreamProvider<List<House>>.value(
      value: DatabaseService(null).getHouses,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Affinder'),
          backgroundColor: Colors.orange[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.add_circle),
              label: Text('aggiungi profilo'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterFormHouse()),
                );
                print("premuto");
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.settings),
              label: Text('FILTRI'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: HousesList(),
      ),
    );
  }
}
