import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/home/showPersonalProfile.dart';
import 'package:prva/screens/login/createProfile.dart';
import 'package:prva/services/database.dart';

class WrapperCreationProfile extends StatelessWidget {
  const WrapperCreationProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    print(user);

    return Scaffold(
        appBar: AppBar(title: Text('Homepage')),
        body: StreamBuilder<PersonalProfile>(
            stream: DatabaseService(user!.uid).persProfileData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CreatePersonalProfile();
              } else {
                return ShowPersonalProfile();
              }
            }));
  }
}
