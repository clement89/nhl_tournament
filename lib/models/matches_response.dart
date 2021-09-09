import 'package:nhl_tournament/models/match.dart';

class MatchesResponse {
  late List<Game> matches;

  MatchesResponse(
    this.matches,
  );

  MatchesResponse.fromMap(Map<String, dynamic> json) {
    if (json['matches'] != null) {
      matches = [];
      json['matches'].forEach((v) {
        matches.add(Game.fromMap(v));
      });
    }
  }
}
