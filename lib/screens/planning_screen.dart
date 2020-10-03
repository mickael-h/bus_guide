import 'package:bus_guide/index.dart';

class PlanningScreen extends GetView<PlanningController> {
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
          Expanded(flex: 1, child: _getPlanningListView()),
        ],
      ),
    );
  }

  Widget _getPlanningListView() {
    return Obx(
      () => ListView(
        children: controller.planningList.value
                ?.map(_getPlanningEntryFromData)
                ?.toList(growable: false) ??
            [],
      ),
    );
  }

  Widget _getPlanningEntryFromData(Planning data) {
    return PlanningListEntry(
      text: '${data.lineName}, ${data.schedule.name}',
      onTap: () => controller.pickPlanning(data),
    );
  }
}
