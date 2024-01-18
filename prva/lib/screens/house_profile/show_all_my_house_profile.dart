import 'package:flutter/material.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/house_profile/houses_list.dart';
import 'package:prva/screens/house_profile/creation_house_profile.dart';
import 'package:provider/provider.dart';
import 'package:prva/services/databaseForHouseProfile.dart';


//When clicking  on "offer an house", it will show all your house profile
//or you can create a new house profile
class ShowHomeProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);

    return StreamProvider<List<HouseProfile>>.value(
      value: DatabaseServiceHouseProfile(user.uid).getHouses,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Affinder'),
          backgroundColor: Colors.orange[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.add_circle),
              label: Text('aggiungi profilo'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterFormHouse()),
                );
              },
            ),
          ],
        ),
        body: HousesList(),
      ),
    );
  }
}
