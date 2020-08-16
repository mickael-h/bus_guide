import '../index.dart';

class PlanningController extends GetxController {
  int currentLine = 0;

  void setCurrentLine(int line) {
    currentLine = line;
    update();
  }
}
