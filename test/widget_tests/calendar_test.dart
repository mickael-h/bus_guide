import 'package:bus_guide/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../plannings_example.dart';
import 'mock_planning_bindings.dart';

void main() {
  testWidgets('test calendar', (WidgetTester tester) async {
    await initializeDateFormatting();

    final bindings = MockPlanningBindings();
    when(bindings.functionTools.callFunction(
      'getPlanning',
      data: {'date': '2020-08-20'},
    )).thenAnswer((_) => Future.sync(() => planningsExample));

    await tester.pumpWidget(GetMaterialApp(
      home: PlanningScreen(),
      initialBinding: bindings,
    ));

    final calendarLeftFinder = find.byKey(ValueKey('calendarButtonLeft'));
    expect(calendarLeftFinder, findsOneWidget);

    final calendarRightFinder = find.byKey(ValueKey('calendarButtonRight'));
    expect(calendarRightFinder, findsOneWidget);

    while (find.text('août 2020').evaluate().isEmpty &&
        find.text('20').evaluate().isEmpty) {
      await tester.tap(calendarLeftFinder);
      await tester.pump();
    }

    final calendarDay1Finder = find.byKey(ValueKey('calendarButtonDay1'));
    expect(calendarDay1Finder, findsOneWidget);
    await tester.tap(calendarDay1Finder);
    await tester.pump();
    expect(find.byType(PlanningListEntry), findsNothing);

    final calendarDay4Finder = find.byKey(ValueKey('calendarButtonDay4'));
    expect(calendarDay4Finder, findsOneWidget);
    await tester.tap(calendarDay4Finder);
    await tester.pump();
    expect(find.byType(PlanningListEntry), findsOneWidget);
    expect(
      find.text('119, Express Bourg-en-Bresse -> Villefranche-sur-Saône 6:45'),
      findsOneWidget,
    );

    print('passed!');
  });
}
