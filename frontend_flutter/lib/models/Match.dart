import 'dart:convert';

class MatchBattle {
  final String id;
  final String room;
  final String winner;
  final String topic;
  final String player1;
  final String player2;
  final List<String> questionsid;
  final int score1;
  final int score2;
  final List<AnswerBattle> answer1;
  final List<AnswerBattle> answer2;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  MatchBattle({
    required this.id,
    required this.room,
    required this.winner,
    required this.topic,
    required this.player1,
    required this.player2,
    required this.questionsid,
    required this.score1,
    required this.score2,
    required this.answer1,
    required this.answer2,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MatchBattle.fromRawJson(String str) =>
      MatchBattle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MatchBattle.fromJson(Map<String, dynamic> json) => MatchBattle(
        id: json["_id"],
        room: json["room"],
        winner: json["winner"],
        topic: json["topic"],
        player1: json["player1"],
        player2: json["player2"],
        questionsid: List<String>.from(json["questionsid"].map((x) => x)),
        score1: json["score1"],
        score2: json["score2"],
        answer1: List<AnswerBattle>.from(
            json["answer1"].map((x) => AnswerBattle.fromJson(x))),
        answer2: List<AnswerBattle>.from(
            json["answer2"].map((x) => AnswerBattle.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "room": room,
        "winner": winner,
        "topic": topic,
        "player1": player1,
        "player2": player2,
        "questionsid": List<dynamic>.from(questionsid.map((x) => x)),
        "score1": score1,
        "score2": score2,
        "answer1": List<dynamic>.from(answer1.map((x) => x.toJson())),
        "answer2": List<dynamic>.from(answer2.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class AnswerBattle {
  final int index;
  final int selectedIndex;
  final String idAnswer;
  final String id;

  AnswerBattle({
    required this.index,
    required this.selectedIndex,
    required this.idAnswer,
    required this.id,
  });

  factory AnswerBattle.fromRawJson(String str) =>
      AnswerBattle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnswerBattle.fromJson(Map<String, dynamic> json) => AnswerBattle(
        index: json["index"],
        selectedIndex: json["selectedIndex"],
        idAnswer: json["idAnswer"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "selectedIndex": selectedIndex,
        "idAnswer": idAnswer,
        "_id": id,
      };
}
