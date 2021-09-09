class Game {
  final String id;
  final String title;
  final String team;
  final int round;
  final String winner;
  final String summery;
  final String nextMatch;

  Game(
    this.id,
    this.title,
    this.team,
    this.round,
    this.winner,
    this.summery,
    this.nextMatch,
  );
  factory Game.fromMap(Map<String, dynamic> json) {
    return Game(
      json['id'],
      json['title'],
      json['team'],
      json['round'],
      json['winner'],
      json['summery'],
      json['next_match'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'team': team,
      'round': round,
      'winner': winner,
      'summery': summery,
      'next_match': nextMatch,
    };
  }
}
