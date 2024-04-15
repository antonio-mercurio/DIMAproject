import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/house_profile/form_house_filter.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/form_personal_profile_adj.dart';
import 'package:prva/alphaTestLib/models/personalProfile.dart';

MaterialApp app = MaterialApp(
  title: 'test',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => FormHouseFilter(uidHouse: "test"),
  },
);
void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });
  final scroll = Key('scrollable');
  final slider = Key('slider');
  final chips = Key('gender/employmentFields');
  final updButton = Key('updateButton');

  testWidgets('Form House Filter population', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    expect(find.byKey(scroll), findsOneWidget);
    expect(find.byKey(slider), findsOneWidget);
    expect(find.byKey(chips), findsOneWidget);
    expect(find.byKey(updButton), findsOneWidget);
  });

  testWidgets('choice chips', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);
    final maleChip = find.text('male');
    expect(maleChip, findsOneWidget);
    final femaleChip = find.text('female');
    expect(femaleChip, findsOneWidget);
    final otherChip = find.text('not relevant');
    expect(otherChip, findsNWidgets(2));
    final studentChip = find.text('student');
    expect(studentChip, findsOneWidget);
    final workerChip = find.text('worker');
    expect(workerChip, findsOneWidget);
    await tester.tap(maleChip);
    await tester.tap(studentChip);

    await tester.tap(find.byKey(updButton));
  });
}
