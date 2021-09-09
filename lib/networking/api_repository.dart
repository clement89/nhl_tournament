import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:nhl_tournament/models/match.dart';
import 'package:nhl_tournament/models/matches_response.dart';

class ApiRepository {
  var apiClient;

  ApiRepository(this.apiClient);

  // WebApiClient _apiClient = WebApiClient();

  Future<List<Game>> getAllMatches() async {
    debugPrint('**** getAllMatches *****');
    final response = await apiClient.getRecordsFromServer(url: '/tournament');
    return MatchesResponse.fromMap(response).matches;
  }
}
