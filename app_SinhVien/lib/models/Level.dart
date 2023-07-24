import 'dart:convert';

class Level {
    final String id;
    final String topicType;
    final String title;
    final int level;
    final DateTime createdAt;
    final DateTime updatedAt;

    Level({
        required this.id,
        required this.topicType,
        required this.title,
        required this.level,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Level.fromRawJson(String str) => Level.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Level.fromJson(Map<String, dynamic> json) => Level(
        id: json["_id"],
        topicType: json["topicType"],
        title: json["title"],
        level: json["level"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "topicType": topicType,
        "title": title,
        "level": level,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}