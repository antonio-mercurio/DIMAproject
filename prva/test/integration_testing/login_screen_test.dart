import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/home/home.dart';
import 'package:prva/alphaTestLib/screens/login/login_screen.dart';

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
    '/': (context) => LoginPage(
          toggleView: toggleView,
        ),
    // '/homepage': (context) => Homepage(),
  },
);
void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });
  final emailField = Key('emailField');
  final registerButton = Key('registerButton');
  final loginButton = Key('loginButton');
  final pwdField = Key('pwdField');
  final signInText = Key('signInText');

  testWidgets("Correct Login", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(signInPage);

    // Create the Finders.
    final emailFieldFinder = find.byKey(emailField);
    final loginButtonFinder = find.byKey(loginButton);
    final registerButtonFinder = find.byKey(registerButton);
    final pwdFieldFinder = find.byKey(pwdField);
    final signInTextFinder = find.byKey(signInText);

    expect(emailFieldFinder, findsOneWidget);
    expect(loginButtonFinder, findsOneWidget);
    expect(registerButtonFinder, findsOneWidget);
    expect(pwdFieldFinder, findsOneWidget);
    expect(signInTextFinder, findsOneWidget);

    await tester.enterText(emailFieldFinder, "antonio@antonio.it");
    await tester.enterText(pwdFieldFinder, "password");
    await tester.tap(loginButtonFinder);

    await tester.pumpAndSettle();

    expect(find.byKey(Key('home')), findsOneWidget);
  });
}
