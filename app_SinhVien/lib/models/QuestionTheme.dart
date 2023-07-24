import 'dart:convert';

class QuestionTheMe {
  final String id;
  final String uid;
  final String title;
  final List<Answer> answers;
  final int score;
  final String image;
  final int time;
  final String theme;
  final DateTime createdAt;
  final DateTime updatedAt;

  QuestionTheMe({
    required this.id,
    required this.uid,
    required this.title,
    required this.answers,
    required this.score,
    required this.image,
    required this.time,
    required this.theme,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuestionTheMe.fromRawJson(String str) =>
      QuestionTheMe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionTheMe.fromJson(Map<String, dynamic> json) => QuestionTheMe(
        id: json["_id"],
        uid: json["uid"],
        title: json["title"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        score: json["score"],
        image: json["image"],
        time: json["time"],
        theme: json["theme"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "title": title,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "score": score,
        "image": image,
        "time": time,
        "theme": theme,
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
