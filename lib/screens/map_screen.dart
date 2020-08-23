import 'package:bus_guide/index.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Guidage'),
        centerTitle: true,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            Get.find<MapScreenController>().cameraPosition.value,
        onMapCreated: (GoogleMapController controller) {
          Completer<GoogleMapController> completer =
              Get.find<MapScreenController>().completer;
          completer.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.back(),
        label: Text('Voir la ligne'),
        icon: Icon(Icons.location_on),
      ),
    );
  }
}
