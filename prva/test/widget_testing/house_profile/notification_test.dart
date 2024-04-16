import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/models/houseProfile.dart';
import 'package:prva/alphaTestLib/models/preference.dart';
import 'package:prva/alphaTestLib/screens/house_profile/notification.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/notificationPerson.dart';

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
List<MatchPeople> idmatches = [
  MatchPeople(
      userID: 'test1', otheUserID: 'test2', timestamp: Timestamp(10, 8)),
  MatchPeople(userID: 'test3', otheUserID: 'test4', timestamp: Timestamp(14, 5))
];
List<MatchPeople> emptyMatch = [];

MaterialApp emptyApp = MaterialApp(
  title: 'test',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => NotificationLayout(house: testHouse),
  },
);
MaterialApp app = MaterialApp(
  title: 'test',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) =>
        NotificationLayout(house: testHouse, idmatches: idmatches),
  },
);

void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });

  final notificationsAppbarKey = Key('notificationsText');

  testWidgets('notification house empty', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(emptyApp);

    expect(find.byKey(notificationsAppbarKey), findsOneWidget);
    expect(find.byKey(Key('emptyCheck')), findsOneWidget);
  });
  testWidgets('notification house not empty', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    expect(find.byKey(notificationsAppbarKey), findsOneWidget);
    expect(find.byKey(Key('emptyCheck')), findsNothing);
    expect(find.byKey(Key('scrollableList')), findsOneWidget);
  });
}
