import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/personal_profile/userHomepage.dart';
import 'package:prva/screens/login/createProfile.dart';
import 'package:prva/services/database.dart';
import 'package:prva/shared/loading.dart';

class WrapperCreationProfile extends StatelessWidget {
  const WrapperCreationProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    print(user);

    return Scaffold(
        body: StreamBuilder<PersonalProfile>(
            stream: DatabaseService(user!.uid).persProfileData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              }
              if (!snapshot.hasData) {
                return CreatePersonalProfile();
              } else {
                return userHomepage();
              }
            }));
  }
}
