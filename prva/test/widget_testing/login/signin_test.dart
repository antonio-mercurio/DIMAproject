import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/home/home.dart';
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

  testWidgets('SignIn correct population', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(signInPage);

    // Create the Finders.
    final emailFieldFinder = find.byKey(emailField);
    final registerButtonFinder = find.byKey(registerButton);
    final loginButtonFinder = find.byKey(loginButton);
    final pwdFieldFinder = find.byKey(pwdField);
    final signInTextFinder = find.byKey(signInText);

    expect(emailFieldFinder, findsOneWidget);
    expect(pwdFieldFinder, findsOneWidget);
    expect(registerButtonFinder, findsOneWidget);
    expect(loginButtonFinder, findsOneWidget);
    expect(signInTextFinder, findsOneWidget);

    await tester.tap(find.byKey(Key('hidePwd')));
    await tester.tap(registerButtonFinder);
  });

  testWidgets("Login Empty Input", (tester) async {
    //build the widget
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(signInPage);
    //find the widget
    final emailFieldFinder = find.byKey(emailField);
    expect(emailFieldFinder, findsOneWidget);

    final passwordFieldFinder = find.byKey(pwdField);
    expect(passwordFieldFinder, findsOneWidget);

    final loginButtonFinder = find.byKey(loginButton);
    expect(loginButtonFinder, findsOneWidget);

    final registerButtonFinder = find.byKey(registerButton);
    expect(registerButtonFinder, findsOneWidget);

    await tester.tap(loginButtonFinder);
    await tester.pump();
    expect(find.text("Enter an email"), findsOneWidget);
    expect(find.text("Enter a password 6+ chars long"), findsOneWidget);
  });

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

    expect(find.byKey(Key('personalButton')), findsOneWidget);
    expect(find.byKey(Key('houseButton')), findsOneWidget);
  });
}
