import 'package:bus_guide/index.dart';

class PlanningBindings extends Bindings {
  final User user;
  PlanningBindings({this.user}) : super();

  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController(user: user));
    Get.lazyPut<PlanningController>(
      () => PlanningController(cloudFunctionTools: CloudFunctionTools()),
    );
  }
}
