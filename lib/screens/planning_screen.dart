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

  Widget getPlanningViewFromData(Planning data) {
    print('data received: $data');
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        title: Text('Ligne ${data.lineName} à ${data.schedule.times[0]}'),
        onTap: () => print('$data tapped!'),
      ),
    );
  }
}
