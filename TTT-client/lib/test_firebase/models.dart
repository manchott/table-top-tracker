class Round {
  String id;
  DateTime date;
  List<PlayerScore> playerScores;

  Round({required this.id, required this.date, required this.playerScores});

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'playerScores': playerScores.map((ps) => ps.toJson()).toList(),
    };
  }

  factory Round.fromJson(Map<String, dynamic> json) {
    return Round(
      id: json['id'],
      date: DateTime.parse(json['date']),
      playerScores: (json['playerScores'] as List)
          .map((ps) => PlayerScore.fromJson(ps))
          .toList(),
    );
  }
}

class PlayerScore {
  String playerId;
  int score;

  PlayerScore({required this.playerId, required this.score});

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'score': score,
    };
  }

  factory PlayerScore.fromJson(Map<String, dynamic> json) {
    return PlayerScore(
      playerId: json['playerId'],
      score: json['score'],
    );
  }
}
