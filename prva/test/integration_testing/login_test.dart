import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prva/alphaTestLib/screens/home/home.dart';
import 'package:prva/alphaTestLib/screens/login/login_screen.dart';

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

  testWidgets("login to home", (tester) async {
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

    expect(find.byKey(Key('home')), findsOneWidget);
  });
}
