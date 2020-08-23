import 'package:bus_guide/index.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    Get.find<PlanningController>().fetchPlanningfor(DateTime.now());
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected $day');
    Get.find<PlanningController>().fetchPlanningfor(day);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'fr_FR',
      calendarController: _calendarController,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: context.theme.primaryColor,
        todayColor: context.theme.cardColor,
        outsideDaysVisible: true,
      ),
      onDaySelected: _onDaySelected,
      initialCalendarFormat: CalendarFormat.week,
      availableCalendarFormats: const {
        CalendarFormat.week: '',
      },
    );
  }
}
