import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/form_filter_people_adj.dart';
import 'package:prva/alphaTestLib/models/personalProfile.dart';

MaterialApp app = MaterialApp(
  title: 'test',
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
  final type0 = Key('type0');
  final type1 = Key('type1');
  final type2 = Key('type2');
  final type3 = Key('type3');
  final type4 = Key('type4');
  final budgetSlider = Key('budgetSlider');
  final finalButton = Key('setFiltersButton');

  testWidgets('Form filter people population', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);
    final setPreferencesTextFinder = find.byKey(setPreferencesTextField);
    expect(setPreferencesTextFinder, findsOneWidget);
    final googleMapsFinder = find.byKey(googleMapsField);
    expect(googleMapsFinder, findsOneWidget);
    final type0Finder = find.byKey(type0);
    final type1Finder = find.byKey(type1);
    final type2Finder = find.byKey(type2);
    final type3Finder = find.byKey(type3);
    final type4Finder = find.byKey(type4);
    expect(type0Finder, findsOneWidget);
    expect(type1Finder, findsOneWidget);
    expect(type2Finder, findsOneWidget);
    expect(type3Finder, findsOneWidget);
    expect(type4Finder, findsOneWidget);
    final budgetSliderFinder = find.byKey(budgetSlider);
    expect(budgetSliderFinder, findsOneWidget);
    final buttonFinder = find.byKey(finalButton);
    expect(buttonFinder, findsOneWidget);
  });
  testWidgets("Checkboxes work properly", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    final type0Finder = find.byKey(type0);
    final type1Finder = find.byKey(type1);
    final type2Finder = find.byKey(type2);
    final type3Finder = find.byKey(type3);
    final type4Finder = find.byKey(type4);

    var checkbox0 = tester.firstWidget<CheckboxListTile>(type0Finder);
    var checkbox1 = tester.firstWidget<CheckboxListTile>(type1Finder);
    var checkbox2 = tester.firstWidget<CheckboxListTile>(type2Finder);
    var checkbox3 = tester.firstWidget<CheckboxListTile>(type3Finder);
    var checkbox4 = tester.firstWidget<CheckboxListTile>(type4Finder);
    expect(checkbox0.value, true);
    expect(checkbox1.value, true);
    expect(checkbox2.value, true);
    expect(checkbox3.value, true);
    expect(checkbox4.value, true);

    await tester.tap(type0Finder);
    await tester.tap(type1Finder);
    await tester.tap(type2Finder);
    await tester.tap(type3Finder);
    await tester.tap(type4Finder);
    await tester.pumpAndSettle();

    checkbox0 = tester.firstWidget<CheckboxListTile>(type0Finder);
    checkbox1 = tester.firstWidget<CheckboxListTile>(type1Finder);
    checkbox2 = tester.firstWidget<CheckboxListTile>(type2Finder);
    checkbox3 = tester.firstWidget<CheckboxListTile>(type3Finder);
    checkbox4 = tester.firstWidget<CheckboxListTile>(type4Finder);
    expect(checkbox0.value, false);
    expect(checkbox1.value, false);
    expect(checkbox2.value, false);
    expect(checkbox3.value, false);
    expect(checkbox4.value, false);

    final buttonFinder = find.byKey(finalButton);
    await tester.tap(buttonFinder);
    await tester.pump();

    expect(find.text('Please, enter at least one type!'), findsOneWidget);
  });

  testWidgets("Update filters", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    final type0Finder = find.byKey(type0);
    final type1Finder = find.byKey(type1);
    final type2Finder = find.byKey(type2);
    final type3Finder = find.byKey(type3);
    final type4Finder = find.byKey(type4);

    var checkbox0 = tester.firstWidget<CheckboxListTile>(type0Finder);
    var checkbox1 = tester.firstWidget<CheckboxListTile>(type1Finder);
    var checkbox2 = tester.firstWidget<CheckboxListTile>(type2Finder);
    var checkbox3 = tester.firstWidget<CheckboxListTile>(type3Finder);
    var checkbox4 = tester.firstWidget<CheckboxListTile>(type4Finder);
    expect(checkbox0.value, true);
    expect(checkbox1.value, true);
    expect(checkbox2.value, true);
    expect(checkbox3.value, true);
    expect(checkbox4.value, true);

    await tester.tap(type3Finder);
    await tester.tap(type4Finder);
    await tester.pumpAndSettle();

    checkbox0 = tester.firstWidget<CheckboxListTile>(type0Finder);
    checkbox1 = tester.firstWidget<CheckboxListTile>(type1Finder);
    checkbox2 = tester.firstWidget<CheckboxListTile>(type2Finder);
    checkbox3 = tester.firstWidget<CheckboxListTile>(type3Finder);
    checkbox4 = tester.firstWidget<CheckboxListTile>(type4Finder);
    expect(checkbox0.value, true);
    expect(checkbox1.value, true);
    expect(checkbox2.value, true);
    expect(checkbox3.value, false);
    expect(checkbox4.value, false);
  });
}
