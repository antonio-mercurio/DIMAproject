import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/form_personal_profile_adj.dart';
import 'package:prva/models/personalProfile.dart';

MaterialApp emptyApp = MaterialApp(
  title: 'test',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => FormPersonalProfileAdj(),
  },
);
MaterialApp app = MaterialApp(
  title: 'withDate',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => FormPersonalProfileAdj(
          bDay: DateTime(2000, 1, 1),
        ),
  },
);
void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });

  final name = Key('nameField');
  final surname = Key('surnameField');
  final create = Key('createButton');
  final employment = Key('employmentField');
  final gender = Key('genderField');
  final description = Key('descriptionField');

  testWidgets('Form Personal Profile population', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(emptyApp);

    expect(find.byKey(name), findsOneWidget);
    expect(find.byKey(surname), findsOneWidget);
    expect(find.byKey(create), findsOneWidget);
    expect(find.byKey(description), findsOneWidget);
    expect(find.byKey(employment), findsOneWidget);
    expect(find.byKey(gender), findsOneWidget);
  });

  testWidgets('Empty form', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(emptyApp);

    //await tester.enterText(find.byKey(name), 'nameTest');
    final listFinder = find.byKey(Key('scrollable'));
    final createFinder = find.byKey(create);

    // Scroll until the item to be found appears.
    await tester.dragUntilVisible(
        createFinder, listFinder, const Offset(-250, 0));
    await tester.tap(find.byKey(create));
    await tester.pump();

    expect(find.text('Please enter a surname'), findsOneWidget);
    expect(find.text('Please enter a name'), findsOneWidget);
    expect(find.text('Please enter a date'), findsOneWidget);
    expect(find.text('Please enter description'), findsOneWidget);
    //expect(find.text('Insert the photos!'), findsOneWidget);
  });

  testWidgets('Empty photos', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    //await tester.enterText(find.byKey(name), 'nameTest');
    final listFinder = find.byKey(Key('scrollable'));
    final createFinder = find.byKey(create);
    final descriptionFinder = find.byKey(description);

    await tester.enterText(find.byKey(name), 'nameTest');
    await tester.enterText(find.byKey(surname), 'surnameTest');
    await tester.enterText(find.byKey(description), 'descriptionTest');
    // Scroll until the item to be found appears.
    await tester.dragUntilVisible(
        createFinder, listFinder, const Offset(-250, 0));

    await tester.tap(createFinder);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    expect(find.text('Please enter a surname'), findsNothing);
    expect(find.text('Please enter a name'), findsNothing);
    expect(find.text('Please enter a date'), findsNothing);
    expect(find.text('Please enter description'), findsNothing);
    expect(find.text('Insert the photos!'), findsOneWidget);
  });
  testWidgets('insert photos', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    //await tester.enterText(find.byKey(name), 'nameTest');
    final listFinder = find.byKey(Key('scrollable'));
    final createFinder = find.byKey(create);
    expect(find.byKey(Key('deleteImg1')), findsNothing);
    expect(find.byKey(Key('deleteImg2')), findsNothing);
    expect(find.byKey(Key('deleteImg3')), findsNothing);
    expect(find.byKey(Key('deleteImg4')), findsNothing);
    await tester.enterText(find.byKey(name), 'nameTest');
    await tester.enterText(find.byKey(surname), 'surnameTest');
    await tester.enterText(find.byKey(description), 'descriptionTest');
    // Scroll until the item to be found appears.
    await tester.dragUntilVisible(
        createFinder, listFinder, const Offset(-250, 0));
    await tester.tap(find.byKey(Key('img1')));
    await tester.tap(find.byKey(Key('img2')));
    await tester.tap(find.byKey(Key('img3')));
    await tester.tap(find.byKey(Key('img4')));
    await tester.tap(createFinder);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.byKey(Key('deleteImg1')), findsOneWidget);
    expect(find.byKey(Key('deleteImg2')), findsOneWidget);
    expect(find.byKey(Key('deleteImg3')), findsOneWidget);
    expect(find.byKey(Key('deleteImg4')), findsOneWidget);
    expect(find.text('Please enter a surname'), findsNothing);
    expect(find.text('Please enter a name'), findsNothing);
    expect(find.text('Please enter a date'), findsNothing);
    expect(find.text('Please enter description'), findsNothing);
    expect(find.text('Insert the photos!'), findsNothing);
  });
  testWidgets('delete photos', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    //await tester.enterText(find.byKey(name), 'nameTest');
    final listFinder = find.byKey(Key('scrollable'));
    final createFinder = find.byKey(create);
    expect(find.byKey(Key('deleteImg1')), findsNothing);
    expect(find.byKey(Key('deleteImg2')), findsNothing);
    expect(find.byKey(Key('deleteImg3')), findsNothing);
    expect(find.byKey(Key('deleteImg4')), findsNothing);
    await tester.enterText(find.byKey(name), 'nameTest');
    await tester.enterText(find.byKey(surname), 'surnameTest');
    await tester.enterText(find.byKey(description), 'descriptionTest');
    // Scroll until the item to be found appears.
    await tester.dragUntilVisible(
        createFinder, listFinder, const Offset(-250, 0));
    await tester.tap(find.byKey(Key('img1')));
    await tester.tap(find.byKey(Key('img2')));
    await tester.tap(find.byKey(Key('img3')));
    await tester.tap(find.byKey(Key('img4')));
    await tester.tap(createFinder);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    await tester.tap(find.byKey(Key('deleteImg1')));
    await tester.tap(find.byKey(Key('deleteImg2')));
    await tester.tap(find.byKey(Key('deleteImg3')));
    await tester.tap(find.byKey(Key('deleteImg4')));
    await tester.pump();
    expect(find.text('Please enter a surname'), findsNothing);
    expect(find.text('Please enter a name'), findsNothing);
    expect(find.text('Please enter a date'), findsNothing);
    expect(find.text('Please enter description'), findsNothing);
  });
  testWidgets('choice chips', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);
    final dateFinder = find.byKey(Key('selDate'));
    final maleChip = find.text('male');
    expect(maleChip, findsOneWidget);
    final femaleChip = find.text('female');
    expect(femaleChip, findsOneWidget);
    final otherChip = find.text('other');
    expect(otherChip, findsOneWidget);
    final studentChip = find.text('student');
    expect(studentChip, findsOneWidget);
    final workerChip = find.text('worker');
    expect(workerChip, findsOneWidget);
    await tester.tap(dateFinder);
    await tester.tap(maleChip);
    await tester.tap(studentChip);
  });
}
