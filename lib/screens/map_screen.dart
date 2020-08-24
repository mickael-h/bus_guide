import 'package:bus_guide/index.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MapScreenController mapController = Get.find<MapScreenController>();
    return new Scaffold(
      appBar: AppBar(
        title: Text('Guidage'),
        centerTitle: true,
      ),
      body: Obx(
        () => GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: mapController.cameraPosition.value,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            Completer<GoogleMapController> completer = mapController.completer;
            completer.complete(controller);
            mapController.onMapCreated();
          },
          markers: mapController.markers.value,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => mapController.showLinePanel(),
        label: Text('Voir la ligne'),
        icon: Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
