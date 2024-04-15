import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:prva/alphaTestLib/models/houseProfile.dart';
import 'package:prva/alphaTestLib/screens/house_profile/form_modify_house.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/all_houses.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/modify_personal_profile.dart';

import 'package:prva/alphaTestLib/models/personalProfile.dart';

HouseProfileAdj testHouse = HouseProfileAdj(
    owner: "owner1",
    idHouse: "idHouse1",
    type: "Apartment",
    address: "via test",
    city: "Milan",
    description: "description",
    price: 500.0,
    floorNumber: 3,
    numBath: 2,
    numPlp: 2,
    startYear: 2023,
    endYear: 2025,
    startMonth: 01,
    endMonth: 01,
    startDay: 01,
    endDay: 1,
    latitude: 43.0,
    longitude: 22.0,
    imageURL1: "t",
    imageURL2: "e",
    imageURL3: "s",
    imageURL4: "t",
    numberNotifies: 1);
MaterialApp app = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => ModifyHouseProfile(
            house: testHouse,
          )
    });
void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });

  final scroll = Key('scrollable');
  final type = Key('type');
  final description = Key('description');
  final numPeople = Key('numPeople');
  final floorField = Key('floorField');
  final numBaths = Key('numBaths');
  final startdate = Key('startdate');
  final enddate = Key('enddate');
  final price = Key('price');
  final img1 = Key('img1');
  final deleteImg1 = Key('deleteImg1');
  final img2 = Key('img2');
  final img3 = Key('img2');
  final img4 = Key('img4');
  final deleteImg2 = Key('deleteImg2');
  final deleteImg3 = Key('deleteImg3');
  final deleteImg4 = Key('deleteImg4');
  final updateButton = Key('updateButton');
  final deleteButton = Key('deleteButton');

  testWidgets('Modify House Profile population', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    expect(find.byKey(scroll), findsOneWidget);
    expect(find.byKey(type), findsOneWidget);
    expect(find.byKey(description), findsOneWidget);
    expect(find.byKey(numPeople), findsOneWidget);
    expect(find.byKey(numBaths), findsOneWidget);
    expect(find.byKey(floorField), findsOneWidget);
    expect(find.byKey(startdate), findsOneWidget);
    expect(find.byKey(enddate), findsOneWidget);
    expect(find.byKey(price), findsOneWidget);
    expect(find.byKey(deleteButton), findsOneWidget);
    expect(find.byKey(updateButton), findsOneWidget);
    expect(find.byKey(img1), findsOneWidget);
    expect(find.byKey(img2), findsOneWidget);
    expect(find.byKey(img3), findsOneWidget);
    expect(find.byKey(img4), findsOneWidget);
    expect(find.byKey(deleteImg1), findsOneWidget);
    expect(find.byKey(deleteImg2), findsOneWidget);
    expect(find.byKey(deleteImg3), findsOneWidget);
    expect(find.byKey(deleteImg4), findsOneWidget);
  });
  testWidgets('Delete House Profile', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    await tester.dragUntilVisible(
        find.byKey(deleteButton), find.byKey(scroll), Offset(-250, 0));

    await tester.tap(find.byKey(deleteButton));
  });

  testWidgets('Delete photos from House Profile ', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(app);
    await tester.dragUntilVisible(
        find.byKey(deleteImg1), find.byKey(scroll), Offset(-250, 0));
    await tester.tap(find.byKey(Key('deleteImg1')));
    await tester.tap(find.byKey(Key('deleteImg2')));
    await tester.tap(find.byKey(Key('deleteImg3')));
    await tester.tap(find.byKey(Key('deleteImg4')));
    await tester.dragUntilVisible(
        find.byKey(updateButton), find.byKey(scroll), Offset(-250, 0));
    await tester.tap(find.byKey(updateButton));

    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.text('Insert the photos!'), findsOneWidget);
  });

  testWidgets('Update House Profile', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(app);
    await tester.tap(find.byKey(type));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    await tester.tap(find.byKey(Key('item-Double room')), warnIfMissed: false);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    await tester.enterText(find.byKey(description), 'descriptionTest');
    await tester.enterText(find.byKey(numPeople), '5');
    await tester.enterText(find.byKey(numBaths), '4');
    await tester.enterText(find.byKey(floorField), '3');
    await tester.enterText(find.byKey(price), '750.0');
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
        find.byKey(startdate), find.byKey(scroll), const Offset(-250, 0));
    await tester.tap(find.byKey(startdate));
    await tester.dragUntilVisible(
        find.byKey(enddate), find.byKey(scroll), const Offset(-250, 0));

    await tester.tap(find.byKey(enddate));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
        find.byKey(deleteImg1), find.byKey(scroll), const Offset(-250, 0));
    await tester.tap(find.byKey(Key('deleteImg1')));
    await tester.tap(find.byKey(Key('deleteImg2')));
    await tester.tap(find.byKey(Key('deleteImg3')));
    await tester.tap(find.byKey(Key('deleteImg4')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('img1')));
    await tester.tap(find.byKey(Key('img2')));
    await tester.tap(find.byKey(Key('img3')));
    await tester.tap(find.byKey(Key('img4')));
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
        find.byKey(updateButton), find.byKey(scroll), const Offset(-250, 0));
    await tester.tap(find.byKey(updateButton));
    await tester.pumpAndSettle();
  });
}
