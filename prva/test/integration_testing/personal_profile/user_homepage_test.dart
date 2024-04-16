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
MaterialApp appPhone = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => UserHomepage(tablet: false)
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
  testWidgets('User Homepage to filters', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appPhone);

    await tester.tap(find.byKey(settings));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('formfilterpeople')), findsOneWidget);
  });
  testWidgets('User Homepage to notifies', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appPhone);

    await tester.tap(find.byKey(notifiesIcon));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('notificationPage')), findsOneWidget);
  });

  testWidgets('User Homepage to profile layout to modify profile form',
      (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(appPhone);

    await tester.tap(find.byKey(profile));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('modifyButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('modifyProfile')), findsOneWidget);
  });

  testWidgets('User Homepage to chat layout to (old) chat page',
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
