import 'index.dart';

void main() async {
  await DotEnv().load('.env');
  final env = DotEnv().env;
  await AppConfig.init(env['CONFIG'], env['GOOGLE_API_KEY']);
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bus Guide',
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
