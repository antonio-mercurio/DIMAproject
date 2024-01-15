import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prva/screens/home/houses_list.dart';
import 'package:prva/screens/home/personalProfileForm.dart';
import 'package:prva/screens/home/settings_form.dart';
import 'package:prva/screens/home/showHomeProfile.dart';
import 'package:prva/screens/home/showPersonalProfile.dart';
import 'package:prva/screens/registerForHouse/registerFormHouse.dart';
import 'package:prva/screens/wrapperCreationProfile.dart';
import 'package:prva/services/auth.dart';
import 'package:prva/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
        ),
        body: Column(children: <Widget>[
          SizedBox(height: 20.0),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WrapperCreationProfile()),
                );
              },
              child: Text('Cerchi casa?')),
          SizedBox(height: 20.0),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowHomeProfile()),
                );
              },
              child: Text('Offri casa?')),
        ]));
  }
}
