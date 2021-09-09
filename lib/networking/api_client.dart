import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../utils/app_exception.dart';

class WebApiClient {
  final String baseUrl =
      'https://418317bb-59cf-4c42-9b3c-7d8828060bf6.mock.pstmn.io/v1';

  Future<dynamic> getRecordsFromServer({required String url}) async {
    debugPrint('GET --------- ${baseUrl + url}');
    try {
      http.Response response = await http.get(Uri.parse(baseUrl + url));
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      } else {
        throw FetchDataException('Error getting response from server');
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
