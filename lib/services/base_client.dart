import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shopx/services/app_exception.dart';

class BaseClient {
  //GET
  Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);

    try {
      var response = await http.get(uri).timeout(Duration(seconds: 20));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNoRespondingException('API not respond in time', uri.toString());
    }
  }

  //POST

  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.decode(payloadObj);

    try {
      var response = await http.post(payload).timeout(Duration(seconds: 20000));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNoRespondingException('API not respond in time', uri.toString());
    }
  }


  //DELETE
  //OTHER


  dynamic _processResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 500:
      default:
        throw FetchDataException("An error occurred with code : ${response.statusCode}", response.request?.url.toString());
    }
  }
}
