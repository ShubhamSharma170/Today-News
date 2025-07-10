import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:today_news/helper/storage_helper/storage_helper.dart';
import 'package:today_news/main.dart';
import 'package:today_news/routes/routes_name.dart';
import 'package:today_news/utils/print_value.dart';
import 'package:today_news/utils/toast_message.dart';

class HttpHelper {
  Map<String, String> apiHeaders(bool isRequireAuthorization) {
    if (isRequireAuthorization) {
      return {
        "Content-type": "application/json",
        "x-api-key": "reqres-free-v1",
      };
    } else {
      return {"Content-Type": "application/json"};
    }
  }

  // GET API METHOD
  Future<dynamic> getAPI({
    required String url,
    bool isRequireAuthorization = false,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: apiHeaders(isRequireAuthorization),
      );
      printValue(url, tag: "API GET URL:");
      printValue(apiHeaders, tag: "API HEADERS:");
      printValue(response.body, tag: "API GET RESPONSE:");
      return _returnResponse(response: response);
    } on SocketException {
      return null;
    }
  }

  // POST API METHOD
  Future<dynamic> postAPI({
    required String url,
    Object? body,
    bool isRequiredAuthorization = false,
  }) async {
    try {
      http.Response response;
      if (body == null) {
        response = await http.post(
          Uri.parse(url),
          headers: apiHeaders(isRequiredAuthorization),
        );
      } else {
        response = await http.post(
          Uri.parse(url),
          body: jsonEncode(body),
          headers: apiHeaders(isRequiredAuthorization),
        );
      }
      printValue(url, tag: "API POST URL:");
      printValue(body, tag: "API POST BODY:");
      printValue(apiHeaders(isRequiredAuthorization), tag: "API HEADERS:");
      printValue(response.body, tag: "API POST RESPONSE:");
      return _returnResponse(response: response);
    } on SocketException {
      return null;
    }
  }

  // PUT API METHOD
  Future<dynamic> putAPI({
    required String url,
    Object? body,
    bool isRequiredAuthorization = false,
  }) async {
    try {
      http.Response response;
      if (body == null) {
        response = await http.put(
          Uri.parse(url),
          headers: apiHeaders(isRequiredAuthorization),
        );
      } else {
        response = await http.put(
          Uri.parse(url),
          body: jsonEncode(body),
          headers: apiHeaders(isRequiredAuthorization),
        );
      }
      printValue(url, tag: "API PUT URL:");
      printValue(body, tag: "API PUT BODY:");
      printValue(apiHeaders(isRequiredAuthorization), tag: "API HEADERS:");
      printValue(response.body, tag: "API PUT RESPONSE:");
      return _returnResponse(response: response);
    } on SocketException {
      return null;
    }
  }

  // DELETE API METHOD
  Future<dynamic> deleteAPI({
    required String url,
    Object? body,
    bool isRequiredAuthorization = false,
  }) async {
    try {
      http.Response response;
      if (body == null) {
        response = await http.delete(
          Uri.parse(url),
          headers: apiHeaders(isRequiredAuthorization),
        );
      } else {
        response = await http.delete(
          Uri.parse(url),
          body: jsonEncode(body),
          headers: apiHeaders(isRequiredAuthorization),
        );
      }
      printValue(url, tag: "API DELETE URL:");
      printValue(body, tag: "API DELETE BODY:");
      printValue(apiHeaders(isRequiredAuthorization), tag: "API HEADERS:");
      printValue(response.body, tag: "API DELETE RESPONSE:");
      return _returnResponse(response: response);
    } on SocketException {
      return null;
    }
  }

  dynamic _returnResponse({required http.Response response}) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body);
        if (responseJson.containsKey("error")) {
          toastMessage(responseJson["error"].toString());
        }
        throw Exception("Error with Status code 400");
      case 401:
        StorageHelper().clean();
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
          RoutesName.login,
          (route) => false,
        );
        throw Exception("Unauthorized");
      case 500:
        throw Exception("Error with Status code 500");
      default:
        throw Exception("Error with Status code ${response.statusCode}");
    }
  }
}
