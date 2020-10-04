import 'package:bus_guide/index.dart';

class PlanningBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<PlanningController>(
      () => PlanningController(cloudFunctionTools: CloudFunctionTools()),
    );
  }
}
