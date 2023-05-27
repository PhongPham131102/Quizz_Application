import 'package:meta/meta.dart';
import 'dart:convert';

class Profile {
  final String uid;
  String gender;
  int gold;
  int diamond;
  int level;
  String name;
  int star;
  int exp;
  String medalId;
  String shirt;
  String trouser;
  String shoe;
  String bag;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  Profile({
    required this.uid,
    required this.gender,
    required this.gold,
    required this.diamond,
    required this.level,
    required this.name,
    required this.star,
    required this.exp,
    required this.medalId,
    required this.shirt,
    required this.trouser,
    required this.shoe,
    required this.bag,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        uid: json["uid"],
        gender: json["gender"],
        gold: json["gold"],
        diamond: json["diamond"],
        level: json["level"],
        name: json["name"],
        star: json["star"],
        exp: json["exp"],
        medalId: json["medalId"],
        shirt: json["shirt"],
        trouser: json["trouser"],
        shoe: json["shoe"],
        bag: json["bag"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "gender": gender,
        "gold": gold,
        "diamond": diamond,
        "level": level,
        "name": name,
        "star": star,
        "exp": exp,
        "medalId": medalId,
        "shirt": shirt,
        "trouser": trouser,
        "shoe": shoe,
        "bag": bag,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
