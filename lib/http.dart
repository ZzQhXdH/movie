import 'dart:io';
import 'dart:convert';

class HttpRequest {
  static Future<Map<String, dynamic>> get(String url) async {
    final http = new HttpClient();
    final request = await http.getUrl(Uri.parse(url));
    final response = await request.close();
    final body = await response.transform(Utf8Decoder()).join();
    return JsonDecoder().convert(body);
  }
}

