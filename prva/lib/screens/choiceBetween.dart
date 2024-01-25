import 'package:flutter/material.dart';
import 'package:prva/screens/house_profile/show_all_my_house_profile.dart';
import 'package:prva/screens/wrapperCreationProfile.dart';
import 'package:prva/services/auth.dart';

class ChoiceBetween extends StatelessWidget {
  final AuthService _auth = AuthService();

  ChoiceBetween({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Affinder',
          style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.black,
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person, color: Colors.white,),
              label: Text('logout', style: TextStyle(color: Colors.white) ),
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