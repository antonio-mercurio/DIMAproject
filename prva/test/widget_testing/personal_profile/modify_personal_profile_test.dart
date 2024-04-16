import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/all_houses.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/modify_personal_profile.dart';

import 'package:prva/alphaTestLib/models/personalProfile.dart';

PersonalProfileAdj testProfile = PersonalProfileAdj(
    day: 01,
    month: 01,
    year: 1970,
    uidA: "userTest",
    nameA: "Testname",
    surnameA: "Testsurname",
    description: "descTest",
    gender: "male",
    employment: "student",
    imageURL1: "t",
    imageURL2: "e",
    imageURL3: "s",
    imageURL4: "t");
MaterialApp app = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => ModificaPersonalProfile(personalProfile: testProfile)
    });
void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });

  final name = Key('nameField');
  final surname = Key('surnameField');
  final update = Key('updateButton');
  final delete = Key('deleteProfileButton');
  final employment = Key('employmentField');
  final gender = Key('genderField');
  final description = Key('descriptionField');
  testWidgets('Modify Personal Profile population', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    expect(find.byKey(name), findsOneWidget);
    expect(find.byKey(surname), findsOneWidget);
    expect(find.byKey(update), findsOneWidget);
    expect(find.byKey(delete), findsOneWidget);
    expect(find.byKey(description), findsOneWidget);
    expect(find.byKey(employment), findsOneWidget);
    expect(find.byKey(gender), findsOneWidget);
  });

  testWidgets('delete photos', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    //await tester.enterText(find.byKey(name), 'nameTest');
    final listFinder = find.byKey(Key('scrollable'));
    final updateFinder = find.byKey(update);
    expect(find.byKey(Key('deleteImg1')), findsOneWidget);
    expect(find.byKey(Key('deleteImg2')), findsOneWidget);
    expect(find.byKey(Key('deleteImg3')), findsOneWidget);
    expect(find.byKey(Key('deleteImg4')), findsOneWidget);
    // Scroll until the item to be found appears.

    await tester.dragUntilVisible(
        updateFinder, listFinder, const Offset(-250, 0));
    await tester.tap(find.byKey(Key('deleteImg1')));
    await tester.tap(find.byKey(Key('deleteImg2')));
    await tester.tap(find.byKey(Key('deleteImg3')));
    await tester.tap(find.byKey(Key('deleteImg4')));

    await tester.tap(updateFinder);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.text('Insert the photos!'), findsOneWidget);
  });
  testWidgets('update profile', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);
    await tester.enterText(find.byKey(name), 'nameTest');
    await tester.enterText(find.byKey(surname), 'surnameTest');
    await tester.enterText(find.byKey(description), 'descriptionTest');
    final selDateFinder = find.byKey(Key('selDate'));
    //await tester.enterText(find.byKey(name), 'nameTest');
    final listFinder = find.byKey(Key('scrollable'));
    await tester.dragUntilVisible(
        selDateFinder, listFinder, const Offset(-250, 0));
    await tester.tap(selDateFinder);

    final updateFinder = find.byKey(update);
    expect(find.byKey(Key('deleteImg1')), findsOneWidget);
    expect(find.byKey(Key('deleteImg2')), findsOneWidget);
    expect(find.byKey(Key('deleteImg3')), findsOneWidget);
    expect(find.byKey(Key('deleteImg4')), findsOneWidget);
    // Scroll until the item to be found appears.

    await tester.dragUntilVisible(
        updateFinder, listFinder, const Offset(-250, 0));
    await tester.tap(find.byKey(Key('deleteImg1')));
    await tester.tap(find.byKey(Key('deleteImg2')));
    await tester.tap(find.byKey(Key('deleteImg3')));
    await tester.tap(find.byKey(Key('deleteImg4')));

    await tester.tap(find.byKey(Key('img1')));
    await tester.tap(find.byKey(Key('img2')));
    await tester.tap(find.byKey(Key('img3')));
    await tester.tap(find.byKey(Key('img4')));

    await tester.tap(updateFinder);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.text('Insert the photos!'), findsNothing);
  });

  testWidgets('delete profile', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);
    final listFinder = find.byKey(Key('scrollable'));

    final deleteProfile = find.byKey(Key('deleteProfileButton'));
    await tester.dragUntilVisible(
        deleteProfile, listFinder, const Offset(-250, 0));
    await tester.tap(find.byKey(Key('deleteProfileButton')));
    await tester.pump();
  });
}
