import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/home/home.dart';

MaterialApp app = MaterialApp(
  title: 'loginTest',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => Homepage(),
  },
);

void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets('homepage test', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);
    expect(find.byKey(Key('logout')), findsOneWidget);
    expect(find.byKey(Key('personalButton')), findsOneWidget);
    expect(find.byKey(Key('houseButton')), findsOneWidget);
    await tester.tap(find.byKey(Key('personalButton')));
    await tester.tap(find.byKey(Key('houseButton')));
    await tester.tap(find.byKey(Key('logout')));
  });
}
