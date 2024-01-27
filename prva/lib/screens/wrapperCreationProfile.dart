import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/form_personal_profile_adj.dart';
import 'package:prva/screens/personal_profile/userHomepage.dart';
import 'package:prva/screens/login/createProfile.dart';
import 'package:prva/services/database.dart';
import 'package:prva/shared/loading.dart';

class WrapperCreationProfile extends StatelessWidget {
  const WrapperCreationProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);

    return Scaffold(
        body: StreamBuilder<PersonalProfileAdj>(
            stream: DatabaseService(user.uid).persProfileDataAdj,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('sono qui');
                return const Loading();
                
              }
              if (!snapshot.hasData) {
                return FormPersonalProfileAdj();
              } else {
                return userHomepage();
              }
            }));
  }
}
