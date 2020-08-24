import 'package:bus_guide/index.dart';

class MapScreenController extends GetxController {
  final Completer<GoogleMapController> completer = Completer();
  final Rx<CameraPosition> cameraPosition = CameraPosition(
    target: LatLng(46.202773227803945,
        5.220320206135511), // France: LatLng(46.659917501970945, 2.2704486921429634),
    zoom: 14.8373, // Whole country: 6.3343,
  ).obs;
  final Rx<Set<Marker>> markers = Set<Marker>().obs;
  final Location location = new Location();
  StreamSubscription _locationStreamSub;

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

  onMapCreated() async {
    bool hasPerm = await _checkPermissions();
    _displayCurrentPlanning();
    if (hasPerm) {
      _startLocationService();
    }
  }

  _checkPermissions() async {
    PermissionStatus permission;
    permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission == PermissionStatus.deniedForever) {
        await _showRationalePopup();
        permission = await location.requestPermission();
      }
    }
    return permission == PermissionStatus.granted;
  }

  _showRationalePopup() async {
    await Get.defaultDialog(
      content: Text(
        'La localisation GPS est désactivée pour cette application. Le guidage ne peut pas fonctionner sans cette permission. Souhaitez-vous l\'activer ?',
        textAlign: TextAlign.center,
      ),
      title: 'Autorisation Nécessaire',
      textCancel: 'Non merci',
      onCancel: navigator.pop,
      textConfirm: 'D\'accord',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await AppSettings.openAppSettings();
        navigator.pop();
      },
    );
  }

  _displayCurrentPlanning() {
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

  _startLocationService() {
    _locationStreamSub =
        location.onLocationChanged.listen((LocationData currentLocation) {
      print('$currentLocation à ${currentLocation.time}');
    });
  }

  @override
  void onClose() {
    _locationStreamSub.cancel();
    completer.future.then(
      (GoogleMapController controller) => controller.dispose(),
    );
    super.onClose();
  }
}
