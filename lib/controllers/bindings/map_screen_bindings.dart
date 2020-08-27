import 'package:bus_guide/index.dart';

class MapScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PositioningController>(() => PositioningController());
    Get.lazyPut<PlanningController>(() => PlanningController());
    Get.lazyPut<MapMainController>(() => MapMainController());
    Get.lazyPut<MarkersController>(() => MarkersController());
  }
}
