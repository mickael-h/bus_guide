import 'package:bus_guide/index.dart';

class PlanningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<PlanningController>(() => PlanningController());
  }
}
