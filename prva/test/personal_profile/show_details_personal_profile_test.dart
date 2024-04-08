import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/show_details_personal_profile.dart';

MaterialApp app = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => DetailedPersonalProfile()
    });
void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets('show details personal profile', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);
    expect(find.byKey(Key('name&surname')), findsOneWidget);
    expect(find.byKey(Key('images')), findsOneWidget);
    expect(find.byKey(Key('age')), findsOneWidget);
    expect(find.byKey(Key('description')), findsOneWidget);
    expect(find.byKey(Key('gender')), findsOneWidget);
    expect(find.byKey(Key('employment')), findsOneWidget);
  });
}
