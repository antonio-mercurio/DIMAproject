import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/login/signin_screen.dart';

bool showSignIn = true;
void toggleView() {
  showSignIn = !showSignIn;
}

class ModelSigniIn {
  late bool confirmPasswordVisibility;
  late bool passwordVisibility;
  void initialSet() {
    confirmPasswordVisibility = false;
    passwordVisibility = false;
  }
}

MaterialApp signInPage = MaterialApp(
  title: 'signInPageTest',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => SigniInPage(
          toggleView: toggleView,
        ),
  },
);

void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });
}
