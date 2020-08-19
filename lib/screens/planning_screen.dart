import 'package:bus_guide/index.dart';

class PlanningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Planning'),
      ),
      body: PlanningListView(),
    );
  }
}

class PlanningListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<PlanningController>().fetchPlanning();
    return Obx(
      () => ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: Get.find<PlanningController>()
            .planningList
            .value
            .map(getPlanningViewFromData)
            .toList(growable: false),
      ),
    );
  }

  Widget getPlanningViewFromData(data) {
    return Text(data.toString());
  }
}
