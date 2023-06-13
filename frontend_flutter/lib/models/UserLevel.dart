import 'dart:convert';

class UserLevel {
     String id;
     String uid;
     String topicType;
     int level;
     int score;
     int star;
     DateTime createdAt;
     DateTime updatedAt;

    UserLevel({
        required this.id,
        required this.uid,
        required this.topicType,
        required this.level,
        required this.score,
        required this.star,
        required this.createdAt,
        required this.updatedAt,
    });

    factory UserLevel.fromRawJson(String str) => UserLevel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserLevel.fromJson(Map<String, dynamic> json) => UserLevel(
        id: json["_id"],
        uid: json["uid"],
        topicType: json["topicType"],
        level: json["level"],
        score: json["score"],
        star: json["star"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "topicType": topicType,
        "level": level,
        "score": score,
        "star": star,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}