import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/form_filter_people_adj.dart';
import 'package:prva/form_house_profile_adj.dart';
import 'package:prva/models/user.dart';
import 'package:prva/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
        home: FormFilterPeopleAdj()//ViewProfile(houseProfile: HouseProfile(type: 'Stanza Singola', city: 'Milano', price: 500, address: 'Via Schipsrelli', owner: '', idHouse: '' )),
      ),
    );
  }
}
