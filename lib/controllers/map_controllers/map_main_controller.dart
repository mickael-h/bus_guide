import 'package:bus_guide/index.dart';

class MapMainController extends GetxController {
  final Completer<GoogleMapController> _completer = Completer();

  void onMapCreated(GoogleMapController mapsController) {
    _initController(mapsController);
    _startPlanning(Get.find<PlanningController>().currentPlanning.value);
  }

  void _initController(GoogleMapController controller) async {
    _completer.complete(controller);
    final mapController = await _completer.future;
    Get.find<PositioningController>().init(mapController);
  }

  void _startPlanning(Planning planning) {
    Get.find<MarkersController>().setMarkersForTrip(planning?.schedule?.trip);
    final stops = planning?.schedule?.trip?.stops;
    if (stops != null) {
      setDestination(stops[0]?.position);
    }
  }

  CameraPosition getCameraPosition() {
    return Get.find<PositioningController>().cameraPosition.value;
  }

  RxSet<Marker> getMarkers() {
    return Get.find<MarkersController>().markers;
  }

  void setDestination(LatLng to) {
    Get.find<RoutingController>().setDestination(to);
  }

  RxMap<PolylineId, Polyline> getPolylines() {
    return Get.find<RoutingController>().polylines;
  }

  @override
  void onClose() {
    _completer.future.then(
      (GoogleMapController controller) => controller.dispose(),
    );
    super.onClose();
  }
}
