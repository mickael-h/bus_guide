import 'package:bus_guide/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'mock_planning_bindings.dart';

void main() {
  testWidgets('test calendar', (WidgetTester tester) async {
    final calendar = find.byKey(ValueKey('calendar'));

    await tester.pumpWidget(GetMaterialApp(
      home: PlanningScreen(),
      initialBinding: MockPlanningBindings(),
    ));
  });
}
