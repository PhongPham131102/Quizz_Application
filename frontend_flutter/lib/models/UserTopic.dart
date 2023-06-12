import 'dart:convert';

class UserTopic {
    final String id;
    final String uid;
    final String topicType;
    final int levelHightest;
    final int totalScore;
    final bool completed;
    final DateTime createdAt;
    final DateTime updatedAt;

    UserTopic({
        required this.id,
        required this.uid,
        required this.topicType,
        required this.levelHightest,
        required this.totalScore,
        required this.completed,
        required this.createdAt,
        required this.updatedAt,
    });

    factory UserTopic.fromRawJson(String str) => UserTopic.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserTopic.fromJson(Map<String, dynamic> json) => UserTopic(
        id: json["_id"],
        uid: json["uid"],
        topicType: json["topicType"],
        levelHightest: json["levelHightest"],
        totalScore: json["totalScore"],
        completed: json["completed"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "topicType": topicType,
        "levelHightest": levelHightest,
        "totalScore": totalScore,
        "completed": completed,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}