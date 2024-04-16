import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/models/houseProfile.dart';
import 'package:prva/alphaTestLib/screens/house_profile/all_profile.dart';

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

MaterialApp appPhone = MaterialApp(
  title: 'test',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => AllProfilesList(
          tablet: false,
          house: testHouse,
        )
  },
);

void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });

  final likeButton = Key("likeButton");
  final dislikeButton = Key("dislikeButton");
  final infoButton = Key("infoButton");
  final detailedProfile = Key("detailedProfile");
  testWidgets("all profiles to view profile ", (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(appPhone);
    final infoFinder = find.byKey(infoButton);

    await tester.tap(infoFinder);
    await tester.pumpAndSettle();
    expect(find.byKey(Key("viewprofile")), findsOneWidget);
  });
}
