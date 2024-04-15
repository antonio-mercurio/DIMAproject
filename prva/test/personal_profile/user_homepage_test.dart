import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/models/message.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/user_homepage.dart';

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
      '/': (context) => UserHomepage(tablet: true)
    });
MaterialApp appPhone = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => UserHomepage(tablet: false)
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

  testWidgets('User Homepage population - tablet - search layout',
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

    await tester.pumpAndSettle();
    expect(find.byKey(Key('formDrawer')), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byKey(Key('drawerBuilder')), findsOneWidget);

    await tester.tap(find.byKey(profile));
    await tester.pumpAndSettle();
    expect(find.byKey(body), findsNothing);
  });
  testWidgets('User Homepage population - mobile phone - search layout',
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
  testWidgets('User Homepage population - mobile phone - search layout',
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
  testWidgets('User Homepage population - mobile phone - search layout',
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
      'User Homepage population - mobile phone - from search layout to profile',
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

    //expect(find.text('1'), findsNothing);
  });

  testWidgets('User Homepage - tablet - profile layout', (tester) async {
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

    await tester.tap(find.byKey(profile));
    await tester.pumpAndSettle();
    expect(find.byKey(body), findsNothing);
    expect(find.byKey(Key('chatLayout')), findsNothing);
    expect(find.byKey(Key('profileLayout')), findsOneWidget);
    expect(find.byKey(Key('detailedProfile')), findsOneWidget);
    expect(find.byKey(Key('modifyButton')), findsOneWidget);
    expect(find.byKey(Key('phoneChatView')), findsNothing);
    await tester.tap(find.byKey(Key('modifyButton')));
    await tester.pumpAndSettle();
  });
  testWidgets('User Homepage - mobile phone - profile layout', (tester) async {
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

    await tester.tap(find.byKey(profile));
    await tester.pumpAndSettle();

    expect(find.byKey(body), findsNothing);
    expect(find.byKey(Key('chatLayout')), findsNothing);
    expect(find.byKey(Key('profileLayout')), findsOneWidget);
    expect(find.byKey(Key('detailedProfile')), findsOneWidget);
    expect(find.byKey(Key('modifyButton')), findsOneWidget);
    expect(find.byKey(Key('phoneChatView')), findsNothing);
    await tester.tap(find.byKey(Key('modifyButton')));
    await tester.pumpAndSettle();
  });

  testWidgets('User Homepage - tablet - chat layout', (tester) async {
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
    expect(find.text('Open a chat!'), findsNothing);

    await tester.tap(find.byKey(Key('chatsInkWell')).first);
    await tester.pumpAndSettle();

    expect(find.byKey(Key('messageList')), findsOneWidget);
    expect(find.byKey(Key('msgField')), findsOneWidget);
    await tester.enterText(find.byKey(Key('msgField')), "testMsg");
    await tester.tap(find.byKey(Key('sendMessage')));
    await tester.pumpAndSettle();
  });
  testWidgets('User Homepage - mobile phone - chat layout', (tester) async {
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
  testWidgets('non empty chats - mobile', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(chatsMobile);
    expect(find.byKey(Key('chatLayout')), findsOneWidget);
    expect(find.byKey(Key('profileLayout')), findsNothing);
    expect(find.byKey(Key('detailedProfile')), findsNothing);
    expect(find.byKey(Key('phoneChatView')), findsOneWidget);
    expect(find.byKey(Key('tabletChatView')), findsNothing);
    expect(find.byKey(Key('tabletScrollable')), findsNothing);
    expect(find.text('Open a chat!'), findsNothing);
    expect(find.byKey(Key('chatsInkWell')), findsNWidgets(2));

    await tester.tap(find.byKey(Key('chatsInkWell')).first);
    await tester.pumpAndSettle();

    expect(find.byKey(Key('messageList')), findsOneWidget);
    expect(find.byKey(Key('msgField')), findsOneWidget);
    await tester.enterText(find.byKey(Key('msgField')), "testMsg");
    await tester.tap(find.byKey(Key('sendMessage')));
    await tester.pumpAndSettle();
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
    expect(find.text('Open a chat!'), findsNothing);
    expect(find.byKey(Key('chatsInkWell')), findsNWidgets(2));
    expect(find.byKey(Key('matchesInkWell')), findsNWidgets(2));

    expect(find.byKey(Key('horScrollable')), findsOneWidget);
    expect(find.byKey(Key('matchBuilder')), findsOneWidget);
    await tester.tap(find.byKey(Key('matchesInkWell')).first);
    await tester.pumpAndSettle();
  });

  ;
}
