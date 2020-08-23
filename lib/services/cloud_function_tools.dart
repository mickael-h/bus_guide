import 'package:http/http.dart' as http;
import 'package:bus_guide/index.dart';

class CloudFunctionTools {
  static Future<Map<String, dynamic>> callFunction(String functionName,
      {Map<String, dynamic> data}) async {
    final String url =
        'https://europe-west1-gestion-trajets.cloudfunctions.net/$functionName';
    try {
      String dataStr;
      if (data != null) {
        dataStr = jsonEncode(data);
      } else {
        dataStr = '{}';
      }
      Map<String, String> headers = <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await FirebaseAuth.instance?.currentUser?.getIdToken()}',
      };
      http.Response response = await http.post(
        url,
        headers: headers,
        body: '{"data":$dataStr}',
      );
      return jsonDecode(response?.body)['result'];
    } catch (e) {
      print('error receving data: $e');
      return <String, dynamic>{};
    }
  }
}
