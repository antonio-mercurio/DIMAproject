import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/allHousesList.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/form_filter_people_adj.dart';
import 'package:prva/models/personalProfile.dart';

MaterialApp app = MaterialApp(
  title: 'gneg',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => FormFilterPeopleAdj(),
  },
);

void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });

  final setPreferencesTextField = Key('setPreferencesText');
  final googleMapsField = Key('googleMapsInput');

  testWidgets('prova', (tester) async {
    await tester.pumpWidget(app);
    final setPreferencesTextFinder = find.byKey(setPreferencesTextField);
    expect(setPreferencesTextFinder, findsOneWidget);
    final googleMapsFinder = find.byKey(googleMapsField);
    expect(googleMapsFinder, findsOneWidget);
  });
}
