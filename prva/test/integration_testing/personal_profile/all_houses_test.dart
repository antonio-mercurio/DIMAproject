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
    imageURL1: "t",
    imageURL2: "e",
    imageURL3: "s",
    imageURL4: "t",
    numberNotifies: 1);

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
              imageURL1: "t",
              imageURL2: "e",
              imageURL3: "s",
              imageURL4: "t"),
        ),
    /*'/viewprofile': (context) => ViewProfile(
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
            imageURL1: "t",
            imageURL2: "e",
            imageURL3: "s",
            imageURL4: "t",
            numberNotifies: 1)),
  */
  },
);
void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });

  final likeButton = Key('likeButton');
  final dislikeButton = Key('dislikeButton');
  final infoButton = Key('infoButton');
  final detailedProfile = Key('detailedProfile');

  testWidgets("all houses to view profile ", (tester) async {
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
    expect(find.byKey(Key("viewprofile")), findsOneWidget);
  });
}
