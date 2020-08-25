import 'package:bus_guide/index.dart';

class PlanningOverlayController extends GetxController {
  setPlanning(Planning planning) {
    final Trip currentTrip = planning?.schedule?.trip;
    Map<String, LatLng> stopPositions = {};
    for (Stop stop in (currentTrip?.stops ?? [])) {
      stopPositions[stop.name] = stop.position;
    }
    Get.find<MarkersController>().setMarkers(stopPositions);
  }
}
