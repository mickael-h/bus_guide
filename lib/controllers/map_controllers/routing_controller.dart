import 'package:bus_guide/index.dart';

class RoutingController extends GetxController {
  RxMap<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;
  final PositioningController _positioningController =
      Get.find<PositioningController>();
  final Rx<LatLng> currentDestination = new Rx<LatLng>();
  StreamSubscription _destinationStreamSub;

  setDestination(LatLng to) {
    print('set destination $to');
    removeDestination();
    currentDestination.value = to;
    if (_positioningController.currentLocation.value != null) {
      _updateDestinationPolyline(_positioningController.currentLocation.value);
    }
    _destinationStreamSub = _positioningController.currentLocation
        .listen(_updateDestinationPolyline);
  }

  removeDestination() {
    if (_destinationStreamSub != null) {
      _destinationStreamSub.cancel();
      _destinationStreamSub = null;
      currentDestination.value = null;
    }
  }

  _updateDestinationPolyline(LocationData newLocation) {
    print('got new location $newLocation');
    LatLng pos = new LatLng(newLocation.latitude, newLocation.longitude);
    setPolyline(pos, currentDestination.value, 'guidance');
  }

  setPolyline(LatLng start, LatLng destination, String id) async {
    PolylineResult result = await _getRoutePolyline(start, destination);
    print('polyline result: ${result.status}');
    Polyline polyline = _createPolylineFromResult(result, id);
    polylines[polyline.polylineId] = polyline;
  }

  Future<PolylineResult> _getRoutePolyline(LatLng start, LatLng destination) {
    PolylinePoints polylinePoints = PolylinePoints();
    return polylinePoints.getRouteBetweenCoordinates(
      AppConfig.instance.googleAPIKey, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );
  }

  Polyline _createPolylineFromResult(PolylineResult result, String id) {
    List<LatLng> polylineCoordinates = [];
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId pId = PolylineId(id);
    return Polyline(
      polylineId: pId,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
  }

  @override
  void onClose() {
    removeDestination();
    super.onClose();
  }
}
