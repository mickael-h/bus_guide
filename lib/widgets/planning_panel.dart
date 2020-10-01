import 'package:bus_guide/index.dart';

import 'planning_list_entry.dart';

class PlanningPanel extends StatelessWidget {
  final PlanningController planningController = Get.find<PlanningController>();
  final RoutingController routingController = Get.find<RoutingController>();

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
    Stop stop = timedStop["stop"];
    return PlanningListEntry(
      text: '$formattedDate: ${stop.name}',
      onTap: () => routingController.setDestination(stop.position),
    );
  }
}
