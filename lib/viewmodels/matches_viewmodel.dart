import 'package:flutter/cupertino.dart';
import 'package:nhl_tournament/constants.dart';
import 'package:nhl_tournament/models/match.dart';
import 'package:nhl_tournament/networking/api_client.dart';
import 'package:nhl_tournament/networking/api_repository.dart';

class MatchesViewModel extends ChangeNotifier {
  ApiRepository _apiRepository = ApiRepository(WebApiClient());

  List<Game> allMatches = [];
  List<Game> easternMatches = [];
  List<Game> westernMatches = [];
  String errorMessage = '';

  void fetchAllMatches() async {
    try {
      errorMessage = '';
      allMatches = await _apiRepository.getAllMatches();
      easternMatches = allMatches
          .where((i) => i.team == kTeamEastern && i.round == 1)
          .toList();
      westernMatches = allMatches
          .where((i) => i.team == kTeamWestern && i.round == 1)
          .toList();
    } catch (e) {
      print(e);
      errorMessage = e.toString();
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
