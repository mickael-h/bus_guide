import 'package:bus_guide/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../plannings_example.dart';
import 'mock_planning_bindings.dart';

void main() {
  testWidgets('test calendar', (WidgetTester tester) async {
    await initializeDateFormatting();

    final bindings = MockPlanningBindings();
    when(bindings.functionTools
            .callFunction('getPlanning', data: anyNamed('data')))
        .thenAnswer((_) => Future.sync(() => planningsExample));
    final calendar = find.byKey(ValueKey('calendar'));

    await tester.pumpWidget(GetMaterialApp(
      home: PlanningScreen(),
      initialBinding: bindings,
    ));
  });
}
