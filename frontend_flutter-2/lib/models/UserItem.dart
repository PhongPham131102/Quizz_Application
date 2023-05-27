import 'dart:convert';

class UsersItem {
    final String id;
    final String idItem;
    final String uid;
    final int quantity;
    final DateTime updatedAt;
    final DateTime createdAt;

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
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "idItem": idItem,
        "uid": uid,
        "quantity": quantity,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
    };
}