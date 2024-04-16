import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/house_profile/show_detailed_profile.dart';

MaterialApp app = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => DetailedHouseProfile()
    });
void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets('show details personal profile', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);
    expect(find.byKey(Key('type')), findsOneWidget);
    expect(find.byKey(Key('images')), findsOneWidget);
    expect(find.byKey(Key('city')), findsOneWidget);
    expect(find.byKey(Key('description')), findsOneWidget);
    expect(find.byKey(Key('address')), findsOneWidget);
    expect(find.byKey(Key('goMap')), findsOneWidget);
    await tester.tap(find.byKey(Key('goMap')));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('floor')), findsOneWidget);
    expect(find.byKey(Key('numBaths')), findsOneWidget);
    expect(find.byKey(Key('numPeople')), findsOneWidget);
    expect(find.byKey(Key('startedDate')), findsOneWidget);
    expect(find.byKey(Key('endDate')), findsOneWidget);
    expect(find.byKey(Key('price')), findsOneWidget);
  });
}
