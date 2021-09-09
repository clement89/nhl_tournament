import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/api_response.dart';

class WebApiClient {
  final String baseUrl =
      'https://418317bb-59cf-4c42-9b3c-7d8828060bf6.mock.pstmn.io/v1';

  Future<ApiResponse> getRecordsFromServer({required String url}) async {
    print('GET --------- ${baseUrl + url}');
    try {
      http.Response response = await http.get(Uri.parse(baseUrl + url));
      if (response.statusCode == 200) {
        return ApiResponse(false, '', response.body);
      } else {
        print(response.statusCode);
        return ApiResponse(true, 'Error getting response from server', '');
      }
    } on SocketException {
      return ApiResponse(true, 'No internet connection', '');
    }
  }
}
