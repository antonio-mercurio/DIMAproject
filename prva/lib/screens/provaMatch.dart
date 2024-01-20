import 'package:flutter/material.dart';
import 'package:prva/screens/house_profile/show_all_my_house_profile.dart';
import 'package:prva/screens/wrapperCreationProfile.dart';
import 'package:prva/services/auth.dart';
import 'package:prva/services/match/match_service.dart';


class ProvaMatch extends StatelessWidget {
  
  ProvaMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Affinder'),
          backgroundColor: Colors.orange[400],
          elevation: 0.0,
        ),
        body: Center(
          child:
          ElevatedButton(
           onPressed: () async{
            await MatchService().putPrefence("1SX0xs8KazS9KREicBWW8MB1JcB2", "0Fh2jr92ZuORogD12mh8", "like");
           },
           child: Text("Prova"), 
          )
        ));
  }
}