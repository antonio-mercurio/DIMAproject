import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/all_houses.dart';
import 'package:prva/alphaTestLib/models/houseProfile.dart';
import 'package:prva/alphaTestLib/models/personalProfile.dart';

HouseProfileAdj testHouse = HouseProfileAdj(
    owner: "owner1",
    idHouse: "idHouse1",
    type: "Single Room",
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
    imageURL1: "",
    imageURL2: "'",
    imageURL3: "",
    imageURL4: "",
    numberNotifies: 1);

MaterialApp appTablet = MaterialApp(
  title: 'test',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => AllHousesList(
          tablet: true,
          myProfile: PersonalProfileAdj(
              day: 01,
              month: 01,
              year: 1970,
              uidA: "userTest",
              nameA: "Testname",
              surnameA: "Testsurname",
              description: "descTest",
              gender: "male",
              employment: "student",
              imageURL1: "",
              imageURL2: "",
              imageURL3: "",
              imageURL4: ""),
        ),
  },
);
MaterialApp appMobilePhone = MaterialApp(
  title: 'test',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => AllHousesList(
          tablet: false,
          myProfile: PersonalProfileAdj(
              day: 01,
              month: 01,
              year: 1970,
              uidA: "userTest",
              nameA: "Testname",
              surnameA: "Testsurname",
              description: "descTest",
              gender: "male",
              employment: "student",
              imageURL1: "",
              imageURL2: "",
              imageURL3: "",
              imageURL4: ""),
        ),
    '/viewprofile': (context) => ViewProfile(
        houseProfile: HouseProfileAdj(
            owner: "owner1",
            idHouse: "idHouse1",
            type: "Single Room",
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
            imageURL1: "",
            imageURL2: "'",
            imageURL3: "",
            imageURL4: "",
            numberNotifies: 1)),
  },
);
MaterialApp allHousesTilesTest = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => AllHousesTiles(house: testHouse)
    });
void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });

  final likeButton = Key('likeButton');
  final dislikeButton = Key('dislikeButton');
  final infoButton = Key('infoButton');
  final detailedProfile = Key('detailedProfile');
  testWidgets("All Houses Tiles test", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(allHousesTilesTest);
    expect(find.byKey(Key('listTile')), findsOneWidget);
  });
  testWidgets("Tablet - correct population", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(appTablet);
    final likeFinder = find.byKey(likeButton);
    final dislikeFinder = find.byKey(dislikeButton);
    final infoFinder = find.byKey(infoButton);
    final detailedProfileFinder = find.byKey(detailedProfile);
    expect(detailedProfileFinder, findsOneWidget);
    expect(dislikeFinder, findsOneWidget);
    expect(likeFinder, findsOneWidget);
    expect(infoFinder, findsNothing);

    expect(find.text("Milan"), findsOneWidget);
    expect(find.text("Rome"), findsNothing);
  });
  testWidgets("Tablet - put like preference", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(appTablet);
    final likeFinder = find.byKey(likeButton);
    final dislikeFinder = find.byKey(dislikeButton);
    final infoFinder = find.byKey(infoButton);
    final detailedProfileFinder = find.byKey(detailedProfile);

    await tester.tap(likeFinder);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('okButton')));
  });
  testWidgets("Tablet - put dislike preference", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(appTablet);
    final likeFinder = find.byKey(likeButton);
    final dislikeFinder = find.byKey(dislikeButton);
    final infoFinder = find.byKey(infoButton);
    final detailedProfileFinder = find.byKey(detailedProfile);

    await tester.tap(dislikeFinder);
    await tester.pump();
  });

  testWidgets("Mobile phone - correct populationn ", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(appMobilePhone);
    final likeFinder = find.byKey(likeButton);
    final dislikeFinder = find.byKey(dislikeButton);
    final infoFinder = find.byKey(infoButton);

    expect(likeFinder, findsOneWidget);
    expect(dislikeFinder, findsOneWidget);
    final detailedProfileFinder = find.byKey(detailedProfile);
    expect(detailedProfileFinder, findsNothing);
    expect(infoFinder, findsOneWidget);
  });
  testWidgets("Mobile phone - put like ", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(appMobilePhone);
    final likeFinder = find.byKey(likeButton);
    final dislikeFinder = find.byKey(dislikeButton);
    final infoFinder = find.byKey(infoButton);

    expect(likeFinder, findsOneWidget);
    expect(dislikeFinder, findsOneWidget);
    final detailedProfileFinder = find.byKey(detailedProfile);
    expect(detailedProfileFinder, findsNothing);
    expect(infoFinder, findsOneWidget);

    await tester.tap(likeFinder);
    await tester.pump();
  });
  testWidgets("Mobile phone - put dislike ", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(appMobilePhone);
    final likeFinder = find.byKey(likeButton);
    final dislikeFinder = find.byKey(dislikeButton);
    final infoFinder = find.byKey(infoButton);

    expect(likeFinder, findsOneWidget);
    expect(dislikeFinder, findsOneWidget);
    final detailedProfileFinder = find.byKey(detailedProfile);
    expect(detailedProfileFinder, findsNothing);
    expect(infoFinder, findsOneWidget);

    await tester.tap(dislikeFinder);
    await tester.pump();
  });
  testWidgets("Mobile phone - view profile ", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(appMobilePhone);
    final likeFinder = find.byKey(likeButton);
    final dislikeFinder = find.byKey(dislikeButton);
    final infoFinder = find.byKey(infoButton);

    expect(likeFinder, findsOneWidget);
    expect(dislikeFinder, findsOneWidget);
    final detailedProfileFinder = find.byKey(detailedProfile);
    expect(detailedProfileFinder, findsNothing);
    expect(infoFinder, findsOneWidget);

    await tester.tap(infoFinder);
    await tester.pumpAndSettle();
    expect(find.byKey(Key("viewProfile")), findsOneWidget);
  });
}
