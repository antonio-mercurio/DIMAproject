import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prva/alphaTestLib/screens/home/home.dart';
import 'package:prva/alphaTestLib/screens/login/register_screen.dart';

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
    '/': (context) => RegisterPage(toggleView: toggleView),
    //'/homepage': (context) => Homepage(),
  },
);

void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });

  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.
  final emailField = Key('emailField');
  final signInButton = Key('signInButton');
  final getStartedButton = Key('getStartedButton');
  final pwdField = Key('pwdField');
  final confirmPwdField = Key('confirmPwdField');
  final createAccountButton = Key('createAccountText');

  testWidgets('RegisterPage correct population', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(app);

    // Create the Finders.
    final emailFieldFinder = find.byKey(emailField);
    final signInButtonFinder = find.byKey(signInButton);
    final getStartedButtonFinder = find.byKey(getStartedButton);
    final pwdFieldFinder = find.byKey(pwdField);
    final confirmPwdFieldFinder = find.byKey(confirmPwdField);
    final createAccountTextFinder = find.byKey(createAccountButton);
    final hidePwdFinder = find.byKey(Key('hidePwd'));
    final hideConfirmPwdFinder = find.byKey(Key('hideConfirmPwd'));

    expect(emailFieldFinder, findsOneWidget);
    expect(signInButtonFinder, findsOneWidget);
    expect(getStartedButtonFinder, findsOneWidget);
    expect(pwdFieldFinder, findsOneWidget);
    expect(confirmPwdFieldFinder, findsOneWidget);
    expect(createAccountTextFinder, findsOneWidget);
    await tester.tap(hidePwdFinder);

    await tester.tap(hideConfirmPwdFinder);
    await tester.tap(signInButtonFinder);
  });

  testWidgets("Register Empty Input", (tester) async {
    //build the widget
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);
    //find the widget
    final emailFieldFinder = find.byKey(emailField);
    expect(emailFieldFinder, findsOneWidget);

    final passwordFieldFinder = find.byKey(pwdField);
    expect(passwordFieldFinder, findsOneWidget);

    final signInButtonFinder = find.byKey(signInButton);
    expect(signInButtonFinder, findsOneWidget);

    final getStartedButtonFinder = find.byKey(getStartedButton);
    expect(getStartedButtonFinder, findsOneWidget);

    await tester.tap(getStartedButtonFinder);
    await tester.pump();
    expect(find.text("Enter an email"), findsOneWidget);
    expect(find.text("Enter a password 6+ chars long"), findsNWidgets(2));
  });
  testWidgets('Wrong password', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.binding.setSurfaceSize(Size(1024, 768));

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

    await tester.enterText(emailFieldFinder, "testmail@mail.it");
    await tester.enterText(pwdFieldFinder, "password");
    await tester.enterText(confirmPwdFieldFinder, "wrongPassword");
    await tester.tap(getStartedButtonFinder);

    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(
        find.text(
          'Passwords don\'t match!',
        ),
        findsOneWidget);
  });

  testWidgets("Correct Registration", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

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

    await tester.enterText(emailFieldFinder, "testmail@mail.it");
    await tester.enterText(pwdFieldFinder, "password");
    await tester.enterText(confirmPwdFieldFinder, "password");
    await tester.tap(getStartedButtonFinder);

    await tester.pumpAndSettle();
  });
}
