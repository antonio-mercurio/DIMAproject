import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/form_house_profile_adj.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/birthday.dart';
import 'package:prva/screens/chat_adj.dart';
import 'package:prva/screens/filters_people_adj.dart';
import 'package:prva/screens/form_personal_profile_adj.dart';
import 'package:prva/screens/house_profile/homepage_house_profile.dart';
import 'package:prva/screens/login/login_screen.dart';
import 'package:prva/screens/personal_profile/allHousesList.dart';
import 'package:prva/screens/provaMatch.dart';
import 'package:prva/screens/prova_notifiche_ListTile.dart';
import 'package:prva/screens/login/signin_screen.dart';
import 'package:prva/screens/swipe_between_images.dart';
import 'package:prva/screens/wrapper.dart';
import 'package:prva/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prva/show_detailed_profile.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await FirebaseMessaging.instance.getInitialMessage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Utente?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: FormHouseAdj()//ViewProfile(houseProfile: HouseProfile(type: 'Stanza Singola', city: 'Milano', price: 500, address: 'Via Schipsrelli', owner: '', idHouse: '' )),
      ),
    );
  }
}
