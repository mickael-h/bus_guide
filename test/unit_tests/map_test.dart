import 'package:bus_guide/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../plannings_example.dart';

class MockGoogleMapController extends Mock implements GoogleMapController {}

class MockCloudFunctionTools extends Mock implements CloudFunctionTools {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final functionTools = MockCloudFunctionTools();
  final planningController =
      PlanningController(cloudFunctionTools: functionTools);
  Get.put<PlanningController>(planningController);

  when(functionTools.callFunction('getPlanning', data: anyNamed('data')))
      .thenAnswer((_) => Future.sync(() => planningsExample));
  await planningController.fetchPlanningfor(DateTime.now());
  planningController.pickPlanning(planningController.planningList[0]);

  final positioningController = PositioningController();
  Get.put<PositioningController>(positioningController);

  final markersController = MarkersController();
  Get.put<MarkersController>(markersController);

  final routingController = RoutingController();
  Get.put<RoutingController>(routingController);

  test('init map', () {
    final mockGoogleController = MockGoogleMapController();
    final mapController = MapMainController();
    mapController.onMapCreated(mockGoogleController);

    print('passed!');
  });
}
