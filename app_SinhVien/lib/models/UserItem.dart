import 'dart:convert';

class UsersItem {
     String id;
     String idItem;
     String uid;
     int quantity;
     DateTime updatedAt;
     DateTime createdAt;

    UsersItem({
        required this.id,
        required this.idItem,
        required this.uid,
        required this.quantity,
        required this.updatedAt,
        required this.createdAt,
    });

    factory UsersItem.fromRawJson(String str) => UsersItem.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UsersItem.fromJson(Map<String, dynamic> json) => UsersItem(
        id: json["_id"],
        idItem: json["idItem"],
        uid: json["uid"],
        quantity: json["quantity"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "idItem": idItem,
        "uid": uid,
        "quantity": quantity,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
    };
}