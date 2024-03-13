import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prva/alphaTestLib/screens/login/login_screen.dart';
import 'package:prva/services/auth.dart';
import 'package:prva/shared/loading.dart';

bool showSignIn = true;
void toggleView() {
  showSignIn = !showSignIn;
}

MaterialApp app = MaterialApp(
  title: 'loginTest',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => LoginPage(toggleView: toggleView),
  },
);

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.
  final emailField = Key('emailField');
  final signInButton = Key('signInButton');
  final getStartedButton = Key('getStartedButton');
  final pwdField = Key('pwdField');
  final confirmPwdField = Key('confirmPwdField');
  final createAccountButton = Key('createAccountText');

  testWidgets('LoginPage correct population', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(app);

    // Create the Finders.
    final emailFieldFinder = find.byKey(emailField);
    final signInButtonFinder = find.byKey(signInButton);
    final getStartedButtonFinder = find.byKey(getStartedButton);
    final pwdFieldFinder = find.byKey(pwdField);
    final confirmPwdFieldFinder = find.byKey(confirmPwdField);
    final createAccountTextFinder = find.byKey(createAccountButton);

    expect(emailFieldFinder, findsOneWidget);
    expect(signInButtonFinder, findsOneWidget);
    expect(getStartedButtonFinder, findsOneWidget);
    expect(pwdFieldFinder, findsOneWidget);
    expect(confirmPwdFieldFinder, findsOneWidget);
    expect(createAccountTextFinder, findsOneWidget);
  });

  testWidgets("Login Empty Input", (tester) async {
    //build the widget

    await tester.pumpWidget(app);

    //find the widget
    final emailFieldFinder = find.byKey(emailField);
    expect(emailFieldFinder, findsOneWidget);

    final passwordFieldFinder = find.byKey(pwdField);
    expect(passwordFieldFinder, findsOneWidget);

    final signInButtonFinder = find.byKey(signInButton);
    expect(signInButtonFinder, findsOneWidget);

    await tester.tap(signInButtonFinder);
    await tester.pump();

    expect(find.text("Please enter your email"), findsOneWidget);
    expect(find.text("Please enter your Password"), findsOneWidget);
  });
  testWidgets('Wrong password', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(app);

    // Create the Finders.
    final emailFieldFinder = find.byKey(emailField);
    final signInButtonFinder = find.byKey(signInButton);
    final getStartedButtonFinder = find.byKey(getStartedButton);
    final pwdFieldFinder = find.byKey(pwdField);
    final confirmPwdFieldFinder = find.byKey(confirmPwdField);
    final createAccountTextFinder = find.byKey(createAccountButton);

    expect(emailFieldFinder, findsOneWidget);
    expect(signInButtonFinder, findsOneWidget);
    expect(getStartedButtonFinder, findsOneWidget);
    expect(pwdFieldFinder, findsOneWidget);
    expect(confirmPwdFieldFinder, findsOneWidget);
    expect(createAccountTextFinder, findsOneWidget);
  });
}
