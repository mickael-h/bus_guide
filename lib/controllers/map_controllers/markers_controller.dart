import 'package:bus_guide/index.dart';

class MarkersController extends GetxController {
  final Rx<Set<Marker>> markers = Set<Marker>().obs;

  setMarkersForTrip(Trip trip) {
    Set<Marker> newMarkers = Set<Marker>();
    for (Stop stop in (trip?.stops ?? [])) {
      newMarkers.add(new Marker(
        markerId: MarkerId(stop.name),
        position: stop.position,
      ));
    }
    markers.value = newMarkers;
  }
}
