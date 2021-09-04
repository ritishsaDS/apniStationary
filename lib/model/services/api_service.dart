import 'dart:convert';
import 'dart:developer';

import 'package:book_buy_and_sell/model/apis/api_exception.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'base_service.dart';

enum APIType { aPost, aGet }

class ApiService extends BaseService {
  var response;

  Future<dynamic> getResponse(
      {@required APIType apiType,
      @required String url,
      Map<String, dynamic> body,
      bool fileUpload = false}) async {
    try {
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8'
      };

      String mainUrl = baseURL + url;
      log("URL ---> ${baseURL + url}");
      if (apiType == APIType.aGet) {
        var result = await http.get(Uri.parse(baseURL + url), headers: header);
        response = returnResponse(
          result.statusCode,
          result.body,
        );
        log("response......${response}");
      } else if (fileUpload) {
        dio.FormData formData = new dio.FormData.fromMap(body);

        dio.Response result = await dio.Dio().post(baseURL + url,
            data: formData,
            options: dio.Options(contentType: "form-data", headers: header));
        print('responseType+>${result.data.runtimeType}');
        response = returnResponse(result.statusCode, result.data);
      } else {
        var encodeBody = jsonEncode(body);

        log("HEADER $header");
        log("REQUEST ENCODE BODY $body");
        var result = await http.post(
          Uri.parse(mainUrl),
          // headers: header,
          body: body,
        );
        response = returnResponse(result.statusCode, result.body);
      }
      return response;
    } catch (e) {
      log('Error=>.. $e');
    }
  }

  Future<http.Response> apiCall(
      {@required APIType apiType,
      @required String url,
      Map<String, dynamic> body,
      bool fileUpload = false}) async {
    try {
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8'
      };

      String mainUrl = baseURL + url;
      log("URL ---> ${baseURL + url}");
      if (apiType == APIType.aGet) {
        var result = await http.get(Uri.parse(baseURL + url), headers: header);
        log("response......${result.body}");
        return result;
      } else {
        var encodeBody = jsonEncode(body);

        log("HEADER $header");
        log("REQUEST ENCODE BODY $body");
        var result = await http.post(
          Uri.parse(mainUrl),
          // headers: header,
          body: body,
        );
        return result;
      }
    } catch (e) {
      log('Error=>.. $e');
    }
  }

  returnResponse(int status, String result) {
    print("status$status");
    switch (status) {
      case 200:
        return jsonDecode(result);
      // case 256:
      //   return result;
      case 400:
        throw BadRequestException('Bad Request');
      case 401:
        throw UnauthorisedException('Unauthorised user');
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}
