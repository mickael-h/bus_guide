import 'package:bus_guide/index.dart';

class MapScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapScreenController>(() => MapScreenController());
    Get.lazyPut<PlanningController>(() => PlanningController());
  }
}
