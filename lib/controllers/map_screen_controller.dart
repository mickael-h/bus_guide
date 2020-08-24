import 'package:bus_guide/index.dart';

class MapScreenController extends GetxController {
  final Completer<GoogleMapController> completer = Completer();
  final Rx<CameraPosition> cameraPosition = CameraPosition(
    target: LatLng(46.202773227803945,
        5.220320206135511), // France: LatLng(46.659917501970945, 2.2704486921429634),
    zoom: 14.8373, // Whole country: 6.3343,
  ).obs;
  final Rx<Set<Marker>> markers = Set<Marker>().obs;

  setMapCenter(double latitude, double longitude,
      {double zoom, double tilt, double bearing}) async {
    cameraPosition.value = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: zoom,
      tilt: tilt,
      bearing: bearing,
    );
    final GoogleMapController controller = await completer.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition.value));
  }

  Future<LatLng> getMapCenter() async {
    final GoogleMapController controller = await completer.future;
    LatLngBounds bounds = await controller.getVisibleRegion();
    return LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) * 0.5,
      (bounds.northeast.longitude + bounds.southwest.longitude) * 0.5,
    );
  }

  showLinePanel() async {
    print('show line panel');
    print('center is ${await getMapCenter()}');
    final GoogleMapController controller = await completer.future;
    print('zoom is ${await controller.getZoomLevel()}');
  }

  displayCurrentPlanning() {
    final Planning currentPlanning =
        Get.find<PlanningController>().currentPlanning.value;
    final Trip currentTrip = currentPlanning?.schedule?.trip;
    Set<Marker> newMarkers = Set<Marker>();
    for (Stop stop in currentTrip?.stops ?? []) {
      newMarkers.add(new Marker(
        markerId: MarkerId(stop.name),
        position: stop.position,
      ));
    }
    markers.value = newMarkers;
  }
}
