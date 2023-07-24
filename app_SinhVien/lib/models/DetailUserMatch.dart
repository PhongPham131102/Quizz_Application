import 'dart:convert';

class DetailUserMatch {
    final String id;
    final String uid;
    final int numOfMatchCss;
    final int numOfWinMatchCss;
    final int numOfMatchCPlusPlus;
    final int numOfWinMatchCPlusPlus;
    final int numOfMatchSql;
    final int numOfWinMatchSql;
    final int numOfMatchHtml;
    final int numOfWinMatchHtml;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    DetailUserMatch({
        required this.id,
        required this.uid,
        required this.numOfMatchCss,
        required this.numOfWinMatchCss,
        required this.numOfMatchCPlusPlus,
        required this.numOfWinMatchCPlusPlus,
        required this.numOfMatchSql,
        required this.numOfWinMatchSql,
        required this.numOfMatchHtml,
        required this.numOfWinMatchHtml,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory DetailUserMatch.fromRawJson(String str) => DetailUserMatch.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DetailUserMatch.fromJson(Map<String, dynamic> json) => DetailUserMatch(
        id: json["_id"],
        uid: json["uid"],
        numOfMatchCss: json["numOfMatchCss"],
        numOfWinMatchCss: json["numOfWinMatchCss"],
        numOfMatchCPlusPlus: json["numOfMatchCPlusPlus"],
        numOfWinMatchCPlusPlus: json["numOfWinMatchCPlusPlus"],
        numOfMatchSql: json["numOfMatchSql"],
        numOfWinMatchSql: json["numOfWinMatchSql"],
        numOfMatchHtml: json["numOfMatchHtml"],
        numOfWinMatchHtml: json["numOfWinMatchHtml"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "numOfMatchCss": numOfMatchCss,
        "numOfWinMatchCss": numOfWinMatchCss,
        "numOfMatchCPlusPlus": numOfMatchCPlusPlus,
        "numOfWinMatchCPlusPlus": numOfWinMatchCPlusPlus,
        "numOfMatchSql": numOfMatchSql,
        "numOfWinMatchSql": numOfWinMatchSql,
        "numOfMatchHtml": numOfMatchHtml,
        "numOfWinMatchHtml": numOfWinMatchHtml,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}