import 'dart:convert';

class Muster {
    final String id;
    final String uid;
    final DateTime createdAt;
    final DateTime updatedAt;

    Muster({
        required this.id,
        required this.uid,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Muster.fromRawJson(String str) => Muster.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Muster.fromJson(Map<String, dynamic> json) => Muster(
        id: json["_id"],
        uid: json["uid"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}