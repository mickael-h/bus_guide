import 'dart:math';

import 'package:bus_guide/index.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;

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
      _updateRoutePolyline(_positioningController.currentLocation.value);
    }
    _destinationStreamSub =
        _positioningController.currentLocation.listen(_onLocationChange);
  }

  removeDestination() {
    if (_destinationStreamSub != null) {
      _destinationStreamSub.cancel();
      _destinationStreamSub = null;
      currentDestination.value = null;
    }
  }

  _onLocationChange(LocationData newLocation) {
    if (!_isLocationCloseToGuidanceLine(newLocation)) {
      _updateRoutePolyline(newLocation);
    }
  }

  _isLocationCloseToGuidanceLine(LocationData location) {
    const TOLERANCE = 15; //meters
    final mp.LatLng position = mp.LatLng(
      location.latitude,
      location.longitude,
    );
    final List<mp.LatLng> guidePolyline =
        getListOfPointsFromPolyline('guidance');

    double dist = double.maxFinite;
    for (int i = 1; i < guidePolyline.length; i++) {
      mp.LatLng start = guidePolyline[i - 1];
      mp.LatLng end = guidePolyline[i];
      dist = min(dist, mp.PolygonUtil.distanceToLine(position, start, end));
    }

    return dist < TOLERANCE;
  }

  List<mp.LatLng> getListOfPointsFromPolyline(String id) {
    return polylines[PolylineId(id)]
        ?.points
        ?.map((LatLng pt) => new mp.LatLng(
              pt.latitude,
              pt.longitude,
            ))
        ?.toList();
  }

  _updateRoutePolyline(LocationData newLocation) {
    LatLng pos = new LatLng(newLocation.latitude, newLocation.longitude);
    setPolyline(pos, currentDestination.value, 'guidance');
  }

  setPolyline(LatLng start, LatLng destination, String id) async {
    PolylineResult result = await _getRoutePolyline(start, destination);
    Polyline polyline = _createPolylineFromResult(result, id);
    polylines[polyline.polylineId] = polyline;
  }

  Future<PolylineResult> _getRoutePolyline(LatLng start, LatLng destination) {
    PolylinePoints polylinePoints = PolylinePoints();
    return polylinePoints.getRouteBetweenCoordinates(
      AppConfig.instance.googleAPIKey,
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
