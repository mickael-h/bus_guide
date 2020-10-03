import 'dart:math';

import 'package:bus_guide/index.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;

class RoutingController extends GetxController {
  RxMap<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;
  final PositioningController _positioningController =
      Get.find<PositioningController>();
  final Rx<LatLng> currentDestination = Rx<LatLng>();
  StreamSubscription _destinationStreamSub;

  void setDestination(LatLng to) {
    removeDestination();
    currentDestination.value = to;
    if (_positioningController.currentLocation.value != null) {
      _updateRoutePolyline(_positioningController.currentLocation.value);
    }
    _destinationStreamSub =
        _positioningController.currentLocation.listen(_onLocationChange);
  }

  void removeDestination() {
    if (_destinationStreamSub != null) {
      _destinationStreamSub.cancel();
      _destinationStreamSub = null;
      currentDestination.value = null;
    }
  }

  void _onLocationChange(LocationData newLocation) {
    if (!_isLocationCloseToGuidanceLine(newLocation)) {
      _updateRoutePolyline(newLocation);
    }
  }

  bool _isLocationCloseToGuidanceLine(LocationData location) {
    const TOLERANCE = 30; //meters
    final position = mp.LatLng(
      location.latitude,
      location.longitude,
    );
    final guidePolyline = getListOfPointsFromPolyline('guidance');

    if (guidePolyline == null) {
      return false;
    }

    var dist = double.maxFinite;
    for (var i = 1; i < guidePolyline.length; i++) {
      final start = guidePolyline[i - 1];
      final end = guidePolyline[i];
      dist = min(dist, mp.PolygonUtil.distanceToLine(position, start, end))
          as double;
    }

    return dist < TOLERANCE;
  }

  List<mp.LatLng> getListOfPointsFromPolyline(String id) {
    return polylines[PolylineId(id)]
        ?.points
        ?.map((LatLng pt) => mp.LatLng(
              pt.latitude,
              pt.longitude,
            ))
        ?.toList();
  }

  void _updateRoutePolyline(LocationData newLocation) {
    final pos = LatLng(newLocation.latitude, newLocation.longitude);
    setPolyline(pos, currentDestination.value, 'guidance');
  }

  void setPolyline(LatLng start, LatLng destination, String id) async {
    final result = await _getRoutePolyline(start, destination);
    final polyline = _createPolylineFromResult(result, id);
    polylines[polyline.polylineId] = polyline;
  }

  Future<PolylineResult> _getRoutePolyline(LatLng start, LatLng destination) {
    return PolylinePoints().getRouteBetweenCoordinates(
      AppConfig.instance.googleAPIKey,
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );
  }

  Polyline _createPolylineFromResult(PolylineResult result, String id) {
    final polylineCoordinates = <LatLng>[];
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    return Polyline(
      polylineId: PolylineId(id),
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
