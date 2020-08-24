import 'index.dart';

void main() async {
  await DotEnv().load('.env');
  await AppConfig.init(DotEnv().env['CONFIG']);
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Test',
      home: LoginScreen(),
      initialBinding: LoginBinding(),
      theme: ThemeData(
        primaryColor: Colors.blue,
        cardColor: Colors.blue[200],
        brightness: Brightness.light,
      ),
    );
  }
}
