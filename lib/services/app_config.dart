import 'package:bus_guide/index.dart';

class AppConfig {
  static AppConfig instance;
  final Map<String, dynamic> autoLogin;
  final String googleAPIKey;

  AppConfig({this.autoLogin, this.googleAPIKey});

  static init(String env, String googleAPIKey) async {
    env = env ?? 'prod';
    final String contents =
        await rootBundle.loadString('assets/config/$env.json');
    final dynamic json = jsonDecode(contents);
    Map<String, dynamic> autoLogin = json['autoLogin'];
    if (autoLogin != null) {
      autoLogin['password'] = jsonDecode(await rootBundle
          .loadString('assets/config/account_pass.json'))['password'];
    }
    instance = AppConfig(
      autoLogin: json['autoLogin'],
      googleAPIKey: googleAPIKey,
    );
  }
}
