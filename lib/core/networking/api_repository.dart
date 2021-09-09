import 'dart:async';

import 'package:nhl_tournament/core/models/match.dart';
import 'package:nhl_tournament/core/models/matches_response.dart';

import 'api_client.dart';

class ApiRepository {
  WebApiClient _apiClient = WebApiClient();

  Future<List<Game>> getAllMatches() async {
    final response = await _apiClient.getRecordsFromServer(url: '/tournament');
    return MatchesResponse.fromMap(response).matches;
  }
}
