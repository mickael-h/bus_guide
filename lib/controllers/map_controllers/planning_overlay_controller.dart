import 'package:bus_guide/index.dart';

//Maybe redudant with planning controller?
class PlanningOverlayController extends GetxController {
  Planning _planning;

  setPlanning(Planning planning) {
    _planning = planning;
    //TODO: put this in markers controller, make it depend on currentStop
    //create currentStop in planningController
    final Trip currentTrip = _planning?.schedule?.trip;
    Map<String, LatLng> stopPositions = {};
    for (Stop stop in (currentTrip?.stops ?? [])) {
      stopPositions[stop.name] = stop.position;
    }
    Get.find<MarkersController>().setMarkers(stopPositions);
  }
}
