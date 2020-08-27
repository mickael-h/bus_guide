import 'package:bus_guide/index.dart';

class PlanningPanel extends StatelessWidget {
  final PlanningController planningController = Get.find<PlanningController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        children: planningController
            .getTimedStops()
            ?.map((Map<String, dynamic> stop) => _getStopViewFromData(stop))
            ?.toList(growable: false),
      ),
    );
  }

  Widget _getStopViewFromData(Map<String, dynamic> timedStop) {
    String formattedDate = formatDate(timedStop["time"], ['HH', ':', 'nn']);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        title: Text('$formattedDate: ${(timedStop["stop"] as Stop).name}'),
        onTap: () => {/*TODO: GPS guidance*/},
      ),
    );
  }
}
