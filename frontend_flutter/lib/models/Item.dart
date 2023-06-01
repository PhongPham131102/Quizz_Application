import 'dart:convert';

class Item {
    final String name;
    final String shortName;
    final String type;
    final String detailType;
    final String gender;
    final String typeMoney;
    final int price;
    final bool quantityPurchasable;
    final bool buyAble;
    final String id;
    final DateTime createdAt;
    final DateTime updatedAt;

    Item({
        required this.name,
        required this.shortName,
        required this.type,
        required this.detailType,
        required this.gender,
        required this.typeMoney,
        required this.price,
        required this.quantityPurchasable,
        required this.buyAble,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        shortName: json["shortName"],
        type: json["type"],
        detailType: json["detailType"],
        gender: json["gender"],
        typeMoney: json["typeMoney"],
        price: json["price"],
        quantityPurchasable: json["quantityPurchasable"],
        buyAble: json["buyAble"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "shortName": shortName,
        "type": type,
        "detailType": detailType,
        "gender": gender,
        "typeMoney": typeMoney,
        "price": price,
        "quantityPurchasable": quantityPurchasable,
        "buyAble": buyAble,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}