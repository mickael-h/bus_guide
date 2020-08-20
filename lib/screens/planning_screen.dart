import 'package:bus_guide/index.dart';

class PlanningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Planning'),
      ),
      body: Calendar(
        title: 'calendrier',
      ),
    );
  }
}

class PlanningListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<PlanningController>().fetchPlanningfor(DateTime.now());
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

  Widget getPlanningViewFromData(Map<String, dynamic> data) {
    print('data received $data');
    return Text(data.toString());
  }
}
