import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/form_personal_profile_adj.dart';
import 'package:prva/screens/home/home.dart';
import 'package:prva/screens/login/authenticate.dart';
import 'package:prva/screens/provaMatch.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final utente = Provider.of<Utente?>(context);
    //return either home or login widget
    if (utente == null) {
      return Authenticate();
    } else {
      return FormPersonalProfileAdj();
    }
  }
}
