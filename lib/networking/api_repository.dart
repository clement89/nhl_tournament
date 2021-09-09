import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../models/api_response.dart';
import 'api_client.dart';

class ApiRepository {
  final WebApiClient _apiClient = WebApiClient();

  Future<ApiResponse> getAllMatches() async {
    debugPrint('**** getAllMatches *****');
    ApiResponse response =
        await _apiClient.getRecordsFromServer(url: '/tournament');

    return response;
  }
}
