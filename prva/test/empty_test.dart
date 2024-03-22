import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/shared/empty.dart';
import 'package:prva/alphaTestLib/screens/shared/loading.dart';

MaterialApp emptyWidget = MaterialApp(
  title: 'emptyTest',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => const EmptyProfile(
          shapeOfIcon: Icons.sentiment_dissatisfied_rounded,
          textToShow: 'You don\'t have any notifications!',
        ),
  },
);
MaterialApp loadingWidget = MaterialApp(
  title: 'loadingTest',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => Loading(),
  },
);
void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('EmptyProfile correct population', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(emptyWidget);
    expect(find.byKey(Key('iconCheck')), findsOneWidget);
    expect(find.byKey(Key('displayText')), findsOneWidget);
  });

  testWidgets('Loading widget', (tester) async {
    await tester.pumpWidget(loadingWidget);
    expect(find.byKey(Key('loading')), findsOneWidget);
  });
}
