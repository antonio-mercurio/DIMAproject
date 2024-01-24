import 'package:flutter/material.dart';
import 'package:prva/screens/login/register.dart';
import 'package:prva/screens/login/sign_in.dart';
import 'package:prva/screens/login_adj_screen.dart';
import 'package:prva/screens/signin_adj_screen.dart';

class Authenticate extends StatefulWidget {
  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SigniInAdjPage(toggleView: toggleView);
    } else {
      return LoginAdjPage(toggleView: toggleView);
    }
  }
}
