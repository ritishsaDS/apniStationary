import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../utils/constantString.dart';

class ApiCall {
  static String baseURL = 'https://buysell.powerdope.com/api/';
  static Map<String, String> header = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static Future<http.Response> apiCall(String endPoint, Object apiBody) async {
    print('Request body: $apiBody');
    var url = Uri.parse(baseURL + endPoint);
    print('Request Url: $url');
    var response = await http.post(url, body: apiBody);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  static Future<http.Response> getApiCall(String endPoint) async {
    var url = Uri.parse(baseURL + endPoint);
    print('Request Url: $url');
    var response = await http.get(url, headers: header);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  static Future<dynamic> post(String url, Object param) async {
    url = baseURL + url;

    print("URL: $url");
    print("Body: $param");

    http.Response response = await http.post(Uri.parse(url), body: param);
    log("API Response: ${response.body}");

    return json.decode(response.body);
  }
}
