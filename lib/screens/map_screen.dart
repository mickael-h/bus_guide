import 'package:bus_guide/index.dart';

class MapScreen extends GetView<MapMainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guidage'),
        centerTitle: true,
      ),
      body: Obx(
        () => GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: controller.getCameraPosition(),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          polylines: Set<Polyline>.of(controller.getPolylines().values),
          onMapCreated: controller.onMapCreated,
          markers: controller.getMarkers(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.bottomSheet(
          PlanningPanel(),
          backgroundColor: Colors.white,
        ),
        label: Text('Voir la ligne'),
        icon: Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
