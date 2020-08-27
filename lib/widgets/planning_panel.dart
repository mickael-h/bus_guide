import 'package:bus_guide/index.dart';

class PlanningPanel extends StatelessWidget {
  final PlanningController planningController = Get.find<PlanningController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        children: _getTimedStops()
            ?.map((Map<String, dynamic> stop) => _getStopViewFromData(stop))
            ?.toList(growable: false),
      ),
    );
  }

  List<Map<String, dynamic>> _getTimedStops() {
    Planning planning = planningController.currentPlanning.value;
    Schedule schedule = planning?.schedule;
    List<Stop> stops = schedule?.trip?.stops;
    if (schedule?.isReversed ?? false) {
      stops = stops?.reversed;
    }
    List<Map<String, dynamic>> timedStops = [];
    for (var i = 0; i < schedule?.times?.length; i++) {
      DateTime date = schedule?.times[i].toDate();
      Stop stop = schedule?.trip?.stops[i];
      timedStops.add({"time": date, "stop": stop});
    }
    return timedStops;
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
