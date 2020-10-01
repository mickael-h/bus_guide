import 'package:bus_guide/index.dart';

class PlanningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Planning'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 0, child: Calendar()),
          Expanded(flex: 1, child: PlanningListView()),
        ],
      ),
    );
  }
}

class PlanningListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        children: Get.find<PlanningController>()
                .planningList
                .value
                ?.map(getPlanningViewFromData)
                ?.toList(growable: false) ??
            [],
      ),
    );
  }

  Widget getPlanningViewFromData(Planning data) {
    return PlanningListEntry(
      text: '${data.lineName}, ${data.schedule.name}',
      onTap: () => Get.find<PlanningController>().pickPlanning(data),
    );
  }
}
