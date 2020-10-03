import 'package:bus_guide/index.dart';

import 'planning_list_entry.dart';

class PlanningPanel extends GetView<PlanningController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        children: controller
            .getTimedStops()
            ?.map(_getStopViewFromData)
            ?.toList(growable: false),
      ),
    );
  }

  Widget _getStopViewFromData(Map<String, dynamic> timedStop) {
    final formattedDate =
        formatDate(timedStop['time'] as DateTime, ['HH', ':', 'nn']);
    final stop = timedStop['stop'] as Stop;
    return PlanningListEntry(
      text: '$formattedDate: ${stop.name}',
      onTap: () => Get.find<RoutingController>().setDestination(stop.position),
    );
  }
}
