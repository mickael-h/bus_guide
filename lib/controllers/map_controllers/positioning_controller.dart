import 'package:bus_guide/index.dart';

// France: LatLng(46.659917501970945, 2.2704486921429634)
const LatLng DEFAULT_POSITION = LatLng(46.202773227803945, 5.220320206135511);

class PositioningController extends GetxController {
  final Rx<LocationData> currentLocation = Rx<LocationData>();
  final Rx<CameraPosition> cameraPosition = CameraPosition(
    target: DEFAULT_POSITION,
    zoom: 14.8373, // Whole country: 6.3343,
  ).obs;
  final Location _locationService = Location();
  StreamSubscription _locationStreamSub;
  LocationData previousLocation;
  // GoogleMapController _controller;

  void init(GoogleMapController mapController) {
    // _controller = mapController;
    _startLocationService();
  }

  // YAGNI?
  // setMapCenter(double latitude, double longitude,
  //     {double zoom, double tilt, double bearing}) async {
  //   cameraPosition.value = CameraPosition(
  //     target: LatLng(latitude, longitude),
  //     zoom: zoom,
  //     tilt: tilt,
  //     bearing: bearing,
  //   );
  //   _controller
  //       ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition.value));
  // }

  // YAGNI?
  // Future<LatLng> getMapCenter() async {
  //   LatLngBounds bounds = await _controller?.getVisibleRegion();
  //   return LatLng(
  //     (bounds.northeast.latitude + bounds.southwest.latitude) * 0.5,
  //     (bounds.northeast.longitude + bounds.southwest.longitude) * 0.5,
  //   );
  // }

  Future<bool> _checkPermissions() async {
    PermissionStatus permission;
    permission = await _locationService.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _locationService.requestPermission();
      if (permission == PermissionStatus.deniedForever) {
        await _showRationalePopup();
        permission = await _locationService.requestPermission();
      }
    }
    print('permission: $permission');
    return permission == PermissionStatus.granted;
  }

  Future<void> _showRationalePopup() async {
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

  Future<void> _startLocationService() async {
    if (!await _checkPermissions()) {
      return;
    }
    _locationStreamSub =
        _locationService.onLocationChanged.listen((LocationData location) {
      previousLocation = currentLocation.value;
      currentLocation.value = location;
    });
  }

  @override
  void onClose() {
    _locationStreamSub.cancel();
    super.onClose();
  }
}
