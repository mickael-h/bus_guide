import 'package:bus_guide/index.dart';

class MapScreenController extends GetxController {
  Completer<GoogleMapController> completer = Completer();
  Rx<CameraPosition> cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  ).obs;
}
