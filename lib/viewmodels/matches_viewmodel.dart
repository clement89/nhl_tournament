import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nhl_tournament/constants.dart';
import 'package:nhl_tournament/models/api_response.dart';
import 'package:nhl_tournament/models/match.dart';
import 'package:nhl_tournament/networking/api_repository.dart';

class MatchesViewModel extends ChangeNotifier {
  ApiRepository _apiRepository = ApiRepository();

  List<Game> allMatches = [];
  List<Game> easternMatches = [];
  List<Game> westernMatches = [];
  String errorMessage = '';

  void fetchAllMatches() async {
    print('fetchAllMatches');
    ApiResponse response = await _apiRepository.getAllMatches();
    if (response.isError) {
      errorMessage = response.errorMessage;
    } else {
      errorMessage = '';
      easternMatches = [];
      westernMatches = [];
      allMatches = [];

      var responseData = jsonDecode(response.data);
      for (Map<String, dynamic> json in responseData['matches']) {
        Game _match = Game.fromMap(json);
        allMatches.add(_match);
      }

      easternMatches = allMatches
          .where((i) => i.team == kTeamEastern && i.round == 1)
          .toList();
      westernMatches = allMatches
          .where((i) => i.team == kTeamWestern && i.round == 1)
          .toList();
    }

    notifyListeners();
  }

  Game getNextMatch(Game match) {
    Game nextMatch =
        allMatches.firstWhere((element) => element.id == match.nextMatch);
    return nextMatch;
  }

  String getRound(Game match) {
    int round = match.round;
    print(match.round);

    switch (round) {
      case 1:
        return 'Second Round';
      case 2:
        return 'Conference Finals';
      case 3:
        return 'Stanley Cup Finals';
      case 4:
        return 'Winner';
      default:
        return '';
    }
  }

  String getMatchInfo(Game game) {
    if (isFinal(game)) {
      return '${game.winner} has won the final match '.toUpperCase();
    }
    return 'Team ${game.winner} has won the match.!';
  }

  bool isFinal(Game game) {
    return game.round == 4 ? true : false;
  }
}
