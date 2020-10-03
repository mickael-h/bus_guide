import 'package:bus_guide/index.dart';

class MarkersController extends GetxController {
  final RxSet<Marker> markers = <Marker>{}.obs;

  void setMarkersForTrip(Trip trip) {
    final newMarkers = <Marker>{};
    for (final stop in (trip?.stops ?? <Stop>[])) {
      newMarkers.add(Marker(
        markerId: MarkerId(stop.name),
        position: stop.position,
      ));
    }
    markers.value = newMarkers;
  }
}
