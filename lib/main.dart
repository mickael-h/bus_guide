import 'index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Test',
      home: PlanningScreen(),
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        cardColor: Color.fromRGBO(200, 200, 255, 1.0),
        brightness: Brightness.light,
      ),
    );
  }
}
