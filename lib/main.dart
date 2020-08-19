import 'index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return _getApp(context);
        }
        return Text('Loading');
      },
    );
  }

  Widget _getApp(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Test',
      home: LoginScreen(),
      initialBinding: LoginBinding(),
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        cardColor: Color.fromRGBO(200, 200, 255, 1.0),
        brightness: Brightness.light,
      ),
    );
  }
}
