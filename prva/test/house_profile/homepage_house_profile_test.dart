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
MaterialApp appTablet = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => HouseProfSel(house: testHouse, tablet: true)
    });
MaterialApp appPhone = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => HouseProfSel(tablet: false, house: testHouse)
    });

MaterialApp emptyChatsTablet = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => ChatLayout(
            tablet: true,
            startedChats: [],
            matched: [],
            house: testHouse,
          )
    });
MaterialApp emptyMatchesTablet = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => ChatLayout(
            tablet: true,
            startedChats: [],
            matched: [],
            house: testHouse,
          )
    });

MaterialApp chatsTablet = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => ChatLayout(
            tablet: true,
            startedChats: testListChats,
            matched: testMatches,
            house: testHouse,
          )
    });
MaterialApp matchesTablet = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => ChatLayout(
            tablet: true,
            startedChats: testListChats,
            matched: testMatches,
            house: testHouse,
          )
    });
MaterialApp emptyChatsMobile = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => ChatLayout(
            tablet: false,
            startedChats: [],
            matched: [],
            house: testHouse,
          )
    });

MaterialApp chatsMobile = MaterialApp(
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
MaterialApp emptyMatchesMobile = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => ChatLayout(
            tablet: false,
            startedChats: [],
            matched: [],
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

  testWidgets('House Homepage population - tablet - search layout',
      (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appTablet);

    expect(find.byKey(search), findsOneWidget);
    expect(find.byKey(profile), findsOneWidget);
    expect(find.byKey(chat), findsOneWidget);
    expect(find.byKey(settings), findsOneWidget);
    expect(find.byKey(notifiesBadge), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.byKey(notifiesIcon), findsOneWidget);
    expect(find.byKey(body), findsOneWidget);
    await tester.tap(find.byKey(notifiesBadge));
    await tester.tap(find.byKey(notifiesIcon));
    await tester.tap(find.byKey(search));
    await tester.tap(find.byKey(settings));

    /*await tester.pumpAndSettle();
    expect(find.byKey(Key('formDrawer')), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byKey(Key('drawerBuilder')), findsOneWidget);
*/
    await tester.tap(find.byKey(profile));
    await tester.pumpAndSettle();
    expect(find.byKey(body), findsNothing);
  });
  testWidgets('House Homepage population - mobile phone - search layout',
      (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appPhone);

    expect(find.byKey(search), findsOneWidget);
    expect(find.byKey(profile), findsOneWidget);
    expect(find.byKey(chat), findsOneWidget);
    expect(find.byKey(settings), findsOneWidget);
    expect(find.byKey(notifiesBadge), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.byKey(notifiesIcon), findsOneWidget);
    expect(find.byKey(body), findsOneWidget);
    await tester.tap(find.byKey(search));

    await tester.tap(find.byKey(notifiesBadge));

    await tester.pumpAndSettle();
    expect(find.byKey(Key('formDrawer')), findsNothing);

    await tester.pumpAndSettle();
    expect(find.byKey(Key('drawerBuilder')), findsNothing);
  });
  testWidgets('House Homepage population - mobile phone - search layout',
      (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appPhone);

    expect(find.byKey(search), findsOneWidget);
    expect(find.byKey(profile), findsOneWidget);
    expect(find.byKey(chat), findsOneWidget);
    expect(find.byKey(settings), findsOneWidget);
    expect(find.byKey(notifiesBadge), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.byKey(notifiesIcon), findsOneWidget);
    expect(find.byKey(body), findsOneWidget);
    await tester.tap(find.byKey(search));

    await tester.tap(find.byKey(notifiesIcon));

    await tester.pumpAndSettle();
    expect(find.byKey(Key('formDrawer')), findsNothing);

    await tester.pumpAndSettle();
    expect(find.byKey(Key('drawerBuilder')), findsNothing);
  });
  testWidgets('House Homepage population - mobile phone - search layout',
      (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appPhone);

    expect(find.byKey(search), findsOneWidget);
    expect(find.byKey(profile), findsOneWidget);
    expect(find.byKey(chat), findsOneWidget);
    expect(find.byKey(settings), findsOneWidget);
    expect(find.byKey(notifiesBadge), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.byKey(notifiesIcon), findsOneWidget);
    expect(find.byKey(body), findsOneWidget);
    await tester.tap(find.byKey(search));

    await tester.tap(find.byKey(settings));

    await tester.pumpAndSettle();
    expect(find.byKey(Key('formDrawer')), findsNothing);

    await tester.pumpAndSettle();
    expect(find.byKey(Key('drawerBuilder')), findsNothing);
  });
  testWidgets(
      'House Homepage population - mobile phone - from search layout to profile',
      (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appPhone);

    expect(find.byKey(search), findsOneWidget);
    expect(find.byKey(profile), findsOneWidget);
    expect(find.byKey(chat), findsOneWidget);
    expect(find.byKey(settings), findsOneWidget);
    expect(find.byKey(notifiesBadge), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.byKey(notifiesIcon), findsOneWidget);
    expect(find.byKey(body), findsOneWidget);

    expect(find.byKey(Key('formDrawer')), findsNothing);

    expect(find.byKey(Key('drawerBuilder')), findsNothing);

    await tester.tap(find.byKey(profile));
    await tester.pumpAndSettle();
    expect(find.byKey(body), findsNothing);
    expect(find.byKey(Key('modifyButton')), findsOneWidget);
    await tester.tap(find.byKey(Key('modifyButton')));
    await tester.pumpAndSettle();
  });

  testWidgets('House Homepage - tablet - chat layout', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appTablet);

    expect(find.byKey(search), findsOneWidget);
    expect(find.byKey(profile), findsOneWidget);
    expect(find.byKey(chat), findsOneWidget);
    expect(find.byKey(settings), findsOneWidget);
    expect(find.byKey(notifiesBadge), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.byKey(notifiesIcon), findsOneWidget);
    expect(find.byKey(body), findsOneWidget);

    await tester.tap(find.byKey(chat));
    await tester.pumpAndSettle();
    expect(find.byKey(body), findsNothing);
    expect(find.byKey(Key('chatLayout')), findsOneWidget);
    expect(find.byKey(Key('profileLayout')), findsNothing);
    expect(find.byKey(Key('detailedProfile')), findsNothing);
    expect(find.byKey(Key('modifyButton')), findsNothing);
    expect(find.byKey(Key('phoneChatView')), findsNothing);
    expect(find.byKey(Key('tabletChatView')), findsOneWidget);
    expect(find.byKey(Key('tabletScrollable')), findsOneWidget);
  });
  testWidgets('empty chats - tablet', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(emptyChatsTablet);
    expect(find.byKey(Key('chatLayout')), findsOneWidget);
    expect(find.byKey(Key('profileLayout')), findsNothing);
    expect(find.byKey(Key('detailedProfile')), findsNothing);
    expect(find.byKey(Key('tabletChatView')), findsOneWidget);
    expect(find.byKey(Key('tabletScrollable')), findsOneWidget);
    expect(find.text('Open a chat!'), findsOneWidget);
  });
  testWidgets('non empty chats - tablet', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(chatsTablet);
    expect(find.byKey(Key('chatLayout')), findsOneWidget);
    expect(find.byKey(Key('profileLayout')), findsNothing);
    expect(find.byKey(Key('detailedProfile')), findsNothing);
    expect(find.byKey(Key('tabletChatView')), findsOneWidget);
    expect(find.byKey(Key('tabletScrollable')), findsOneWidget);
    expect(find.text('Open a chat!'), findsOneWidget);
    expect(find.byKey(Key('chatsInkWell')), findsNWidgets(2));
    await tester.tap(find.byKey(Key('chatsInkWell')).first);
    await tester.pumpAndSettle();
  });
  testWidgets('non empty chats - mobile phone', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(chatsMobile);
    expect(find.byKey(Key('chatLayout')), findsOneWidget);
    expect(find.byKey(Key('profileLayout')), findsNothing);
    expect(find.byKey(Key('detailedProfile')), findsNothing);
    expect(find.byKey(Key('tabletChatView')), findsNothing);
    expect(find.byKey(Key('tabletScrollable')), findsNothing);
    expect(find.text('Open a chat!'), findsNothing);
    expect(find.byKey(Key('chatsInkWell')), findsNWidgets(2));
    await tester.tap(find.byKey(Key('chatsInkWell')).first);
    await tester.pumpAndSettle();
  });

  testWidgets('House Homepage - mobile phone - chat layout', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appPhone);

    expect(find.byKey(search), findsOneWidget);
    expect(find.byKey(profile), findsOneWidget);
    expect(find.byKey(chat), findsOneWidget);
    expect(find.byKey(settings), findsOneWidget);
    expect(find.byKey(notifiesBadge), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.byKey(notifiesIcon), findsOneWidget);
    expect(find.byKey(body), findsOneWidget);

    await tester.tap(find.byKey(chat));
    await tester.pumpAndSettle();
    expect(find.byKey(body), findsNothing);
    expect(find.byKey(Key('chatLayout')), findsOneWidget);
    expect(find.byKey(Key('profileLayout')), findsNothing);
    expect(find.byKey(Key('detailedProfile')), findsNothing);
    expect(find.byKey(Key('modifyButton')), findsNothing);
    expect(find.byKey(Key('phoneChatView')), findsOneWidget);
    expect(find.byKey(Key('tabletChatView')), findsNothing);
    expect(find.byKey(Key('tabletScrollable')), findsNothing);
  });

  testWidgets('non empty matches - mobile', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(matchesMobile);
    expect(find.byKey(Key('chatLayout')), findsOneWidget);
    expect(find.byKey(Key('profileLayout')), findsNothing);
    expect(find.byKey(Key('detailedProfile')), findsNothing);
    expect(find.byKey(Key('phoneChatView')), findsOneWidget);
    expect(find.byKey(Key('tabletChatView')), findsNothing);
    expect(find.byKey(Key('tabletScrollable')), findsNothing);
    expect(find.text('Open a chat!'), findsNothing);
    expect(find.byKey(Key('chatsInkWell')), findsNWidgets(2));
    expect(find.byKey(Key('matchesInkWell')), findsNWidgets(2));

    expect(find.byKey(Key('horScrollable')), findsOneWidget);
    expect(find.byKey(Key('matchBuilder')), findsOneWidget);
    await tester.tap(find.byKey(Key('matchesInkWell')).first);
    await tester.pumpAndSettle();
  });
  testWidgets('non empty matches - tablet', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(matchesTablet);
    expect(find.byKey(Key('chatLayout')), findsOneWidget);
    expect(find.byKey(Key('profileLayout')), findsNothing);
    expect(find.byKey(Key('detailedProfile')), findsNothing);
    expect(find.byKey(Key('phoneChatView')), findsNothing);
    expect(find.byKey(Key('tabletChatView')), findsOneWidget);
    expect(find.byKey(Key('tabletScrollable')), findsOneWidget);
    expect(find.text('Open a chat!'), findsOneWidget);
    expect(find.byKey(Key('chatsInkWell')), findsNWidgets(2));
    expect(find.byKey(Key('matchesInkWell')), findsNWidgets(2));

    expect(find.byKey(Key('horScrollable')), findsOneWidget);
    expect(find.byKey(Key('matchBuilder')), findsOneWidget);
    await tester.tap(find.byKey(Key('matchesInkWell')).first);
    await tester.pumpAndSettle();
  });
  testWidgets(' empty matches - tablet', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(emptyMatchesTablet);
    expect(find.byKey(Key('emptyMatchBanner')), findsOneWidget);
  });
  testWidgets(' empty matches - phone', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(emptyMatchesMobile);
    expect(find.byKey(Key('emptyMatchBanner')), findsOneWidget);
  });
}
