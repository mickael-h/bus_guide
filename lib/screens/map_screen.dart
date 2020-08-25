import 'package:bus_guide/index.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Guidage'),
        centerTitle: true,
      ),
      body: Obx(() {
        MapMainController mapController = Get.find<MapMainController>();
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: mapController.getCameraPosition(),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            mapController.initController(controller);
            mapController.startPlanning(
                Get.find<PlanningController>().currentPlanning.value);
          },
          markers: mapController.getMarkers(),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.bottomSheet(PlanningPanel(
            Get.find<PlanningController>().currentPlanning.value)),
        label: Text('Voir la ligne'),
        icon: Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
