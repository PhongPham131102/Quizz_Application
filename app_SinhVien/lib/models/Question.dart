import 'dart:convert';

class Question {
  final String id;
  final String title;
  final List<Answer> answers;
  final int difficulty;
  final int score;
  final int time;
  final String image;
  final String typeQuestion;
  final String typeLanguage;
  final int level;
  final DateTime createdAt;
  final DateTime updatedAt;

  Question({
    required this.id,
    required this.title,
    required this.answers,
    required this.difficulty,
    required this.score,
    required this.time,
    required this.image,
    required this.typeQuestion,
    required this.typeLanguage,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Question.fromRawJson(String str) =>
      Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["_id"],
        title: json["title"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        difficulty: json["difficulty"],
        score: json["score"],
         time: json["time"]??0,
        image: json["image"],
        typeQuestion: json["typeQuestion"],
        typeLanguage: json["typeLanguage"],
        level: json["level"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "difficulty": difficulty,
        "score": score,
          "time": time,
        "image": image,
        "typeQuestion": typeQuestion,
        "typeLanguage": typeLanguage,
        "level": level,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Answer {
  String answerText;
  bool score;
  String id;

  Answer({
    required this.answerText,
    required this.score,
    required this.id,
  });

  factory Answer.fromRawJson(String str) => Answer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        answerText: json["answerText"],
        score: json["score"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "answerText": answerText,
        "score": score,
        "_id": id,
      };
}
