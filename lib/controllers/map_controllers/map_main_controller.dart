import 'package:bus_guide/index.dart';

class MapMainController extends GetxController {
  final Completer<GoogleMapController> _completer = Completer();
  final PositioningController _posController =
      Get.find<PositioningController>();
  final MarkersController _markersController = Get.find<MarkersController>();

  initController(GoogleMapController controller) async {
    _completer.complete(controller);
    final GoogleMapController mapController = await _completer.future;
    _posController.init(mapController);
  }

  startPlanning(Planning planning) {
    _markersController.setMarkersForTrip(planning?.schedule?.trip);
  }

  CameraPosition getCameraPosition() {
    return _posController.cameraPosition.value;
  }

  Set<Marker> getMarkers() {
    return _markersController.markers.value;
  }

  @override
  void onClose() {
    _completer.future.then(
      (GoogleMapController controller) => controller.dispose(),
    );
    super.onClose();
  }
}
