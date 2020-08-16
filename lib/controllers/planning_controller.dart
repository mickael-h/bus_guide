import 'package:bus_guide/index.dart';

class PlanningController extends GetxController {
  final currentLine = 0.obs;

  setCurrentLine(int line) {
    currentLine.value = line;
  }
}
