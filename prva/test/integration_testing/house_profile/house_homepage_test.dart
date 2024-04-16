import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/models/houseProfile.dart';
import 'package:prva/alphaTestLib/models/message.dart';
import 'package:prva/alphaTestLib/screens/house_profile/homepage_house_profile.dart';

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
    imageURL1: "",
    imageURL2: "'",
    imageURL3: "",
    imageURL4: "",
    numberNotifies: 1);
List<String> testMatches = ['test1', 'test2'];
List<Chat> testListChats = [
  Chat(id: 'id', lastMsg: 'lastMsg', timestamp: Timestamp(10, 5), unreadMsg: 1),
  Chat(
      id: 'id2', lastMsg: 'lastTest', timestamp: Timestamp(16, 7), unreadMsg: 3)
];
MaterialApp appPhone = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => HouseProfSel(tablet: false, house: testHouse)
    });

MaterialApp matchesMobile = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => ChatLayout(
            tablet: false,
            startedChats: testListChats,
            matched: testMatches,
            house: testHouse,
          )
    });
void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });
  final search = Key('search');
  final profile = Key('profile');
  final chat = Key('chat');
  final settings = Key('settings');
  final notifiesBadge = Key('notifiesBadge');
  final notifiesIcon = Key('notifiesIcon');
  final body = Key('body');

  testWidgets('House Homepage to notification layout', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appPhone);
    await tester.tap(find.byKey(notifiesIcon));

    await tester.pumpAndSettle();
    expect(find.byKey(Key('notifsPage')), findsOneWidget);
  });

  testWidgets('House Homepage to filters layout', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appPhone);
    await tester.tap(find.byKey(settings));

    await tester.pumpAndSettle();
    expect(find.byKey(Key('formHouseFilters')), findsOneWidget);
  });

  testWidgets('House Homepage to profile layout to modify profile page',
      (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appPhone);
    await tester.tap(find.byKey(profile));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(find.byKey(Key('modifyButton')),
        find.byKey(Key('scrollable')), Offset(-250, 0));

    await tester.tap(find.byKey(Key('modifyButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('modifyHouseProfile')), findsOneWidget);
  });

  testWidgets('House Homepage to chat layout to (old) chat page',
      (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appPhone);
    await tester.tap(find.byKey(chat));

    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('chatsInkWell')).first);
    await tester.pumpAndSettle();

    expect(find.byKey(Key('chatPage')), findsOneWidget);
  });

  testWidgets('chat layout to (new) chat page', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(matchesMobile);

    await tester.tap(find.byKey(Key('matchesInkWell')).first);
    await tester.pumpAndSettle();

    expect(find.byKey(Key('matchChatPage')), findsOneWidget);
  });
}
