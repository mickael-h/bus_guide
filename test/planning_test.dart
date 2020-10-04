import 'package:bus_guide/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCloudFunctionTools extends Mock implements CloudFunctionTools {}

void main() {
  final functionTools = MockCloudFunctionTools();
  PlanningController controller;

  setUp(() {
    controller = PlanningController(cloudFunctionTools: functionTools);
    const testPlanning = <String, dynamic>{
      'plannings': [
        {
          'date': {'_seconds': 1597874400, '_nanoseconds': 0},
          'general_comment': 'Commentaire trajet',
          'line_name': '119',
          'located_comments': [
            {
              'position': {'_latitude': 46.123456, '_longitude': 5.123456},
              'text': 'Commentaire localisé',
            },
          ],
          'schedule': {
            'times': [
              {'_seconds': 20700, '_nanoseconds': 0},
              {'_seconds': 21180, '_nanoseconds': 0},
            ],
            'name': 'Express Bourg-en-Bresse -> Villefranche-sur-Saône 6:45',
            'is_reversed': false,
            'trip': {
              'stops': [
                {
                  'position': {'_latitude': 46.208185, '_longitude': 5.2263725},
                  'name': 'Carré Amiot',
                },
                {
                  'name': 'Bourg-en-Bresse Gare SNCF',
                  'position': {'_latitude': 46.1990888, '_longitude': 5.2143643}
                },
              ],
              'name': 'Express',
            },
          },
        },
      ],
    };

    when(functionTools.callFunction('getPlanning', data: anyNamed('data')))
        .thenAnswer((_) => Future.sync(() => testPlanning));
  });

  test('planning data', () async {
    await controller.fetchPlanningfor(DateTime.now());
    expect(controller.planningList.length, 1);

    // check planning
    final planning = controller.planningList[0];
    expect(planning.date, Timestamp(1597874400, 0));
    expect(planning.generalComment, 'Commentaire trajet');
    expect(planning.lineName, '119');
    expect(planning.locatedComments.length, 1);
    expect(
      planning.locatedComments[0]['position'],
      LatLng(46.123456, 5.123456),
    );
    expect(planning.locatedComments[0]['text'], 'Commentaire localisé');

    // check schedule
    final schedule = planning.schedule;
    expect(schedule.hasError, false);
    expect(schedule.isReversed, false);
    expect(
      schedule.name,
      'Express Bourg-en-Bresse -> Villefranche-sur-Saône 6:45',
    );
    expect(schedule.times.length, 2);
    expect(schedule.times[0], Timestamp(20700, 0));
    expect(schedule.times[1], Timestamp(21180, 0));

    // check trip
    final trip = schedule.trip;
    expect(trip.hasError, false);
    expect(trip.name, 'Express');

    // check stops
    final stops = trip.stops;
    expect(stops.length, 2);
    expect(stops[0].hasError, false);
    expect(stops[0].done, false);
    expect(stops[0].name, 'Carré Amiot');
    expect(stops[0].position, LatLng(46.208185, 5.2263725));
    expect(stops[1].hasError, false);
    expect(stops[1].done, false);
    expect(stops[1].name, 'Bourg-en-Bresse Gare SNCF');
    expect(stops[1].position, LatLng(46.1990888, 5.2143643));
    print('passed!');
  });

  test('picking planning', () async {
    await controller.fetchPlanningfor(DateTime.now());
    expect(controller.planningList.length, 1);

    final planning = controller.planningList[0];
    controller.pickPlanning(planning);
    final schedule = planning.schedule;
    final stops = schedule.trip.stops;
    final timedStops = controller.getTimedStops();
    expect(
      timedStops,
      stops.map((Stop stop) => {
            'time': DateTime.fromMillisecondsSinceEpoch(
                schedule.times[stops.indexOf(stop)].millisecondsSinceEpoch),
            'stop': stop,
          }),
    );
    print('passed!');
  });
}
