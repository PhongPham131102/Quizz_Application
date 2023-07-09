import 'dart:convert';

class User {
    final String id;
    final String fullName;
    final String email;
    final bool isTeacher;
    final bool isAdmin;
    final DateTime createdAt;
    final DateTime updatedAt;

    User({
        required this.id,
        required this.fullName,
        required this.email,
        required this.isAdmin,
        required this .isTeacher,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        isTeacher: json["isTeacher"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}