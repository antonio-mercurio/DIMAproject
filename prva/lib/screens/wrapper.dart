import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/home/home.dart';
import 'package:prva/screens/login/authenticate.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final utente = Provider.of<Utente?>(context);
    //return either home or login widget
    if (utente == null) {
      return Authenticate();
    } else {
      return Homepage();
    }
  }
}
