import 'package:bus_guide/index.dart';

class MarkersController extends GetxController {
  final Rx<Set<Marker>> markers = Set<Marker>().obs;

  setMarkers(Map<String, LatLng> markerPositions) {
    Set<Marker> newMarkers = Set<Marker>();
    markerPositions?.forEach((id, pos) {
      newMarkers.add(new Marker(
        markerId: MarkerId(id),
        position: pos,
      ));
    });
    markers.value = newMarkers;
  }
}
