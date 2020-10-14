import 'package:mockito/mockito.dart';
import 'package:bus_guide/index.dart';

class MockUser extends Mock implements User {}

class MockCloudFunctionTools extends Mock implements CloudFunctionTools {}

class MockPlanningBindings extends Bindings {
  final functionTools = MockCloudFunctionTools();
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController(user: MockUser()));
    Get.lazyPut<PlanningController>(
      () => PlanningController(cloudFunctionTools: functionTools),
    );
  }
}
