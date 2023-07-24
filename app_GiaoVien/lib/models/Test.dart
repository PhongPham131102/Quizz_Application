import 'dart:convert';

class Test {
    final String id;
    final String uid;
    final String heading;
    final String testTheme;
    final String typePost;
    final List<String> listQuestions;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Test({
        required this.id,
        required this.uid,
        required this.heading,
        required this.testTheme,
        required this.typePost,
        required this.listQuestions,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Test.fromRawJson(String str) => Test.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Test.fromJson(Map<String, dynamic> json) => Test(
        id: json["_id"],
        uid: json["uid"],
        heading: json["heading"],
        testTheme: json["testTheme"],
        typePost: json["typePost"],
        listQuestions: List<String>.from(json["listQuestions"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "heading": heading,
        "testTheme": testTheme,
        "typePost": typePost,
        "listQuestions": List<dynamic>.from(listQuestions.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
