// To parse this JSON data, do
//
//     final Products = ProductsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  String? id;
  String? title;
  String? description;
  String? latitude;
  String? longitude;
  String? imageUrl;
  UserId? userId;
  String? category;
  String? city;
  String? district;
  DateTime? createdAt;
  DateTime? updatedAt;

  Products({
    this.id,
    this.title,
    this.description,
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.userId,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.city,
    this.district,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        imageUrl: json["imageUrl"],
        userId: UserId.fromJson(json["userId"]),
        // userId: json["userId"],
        category: json["category"],
        city: json["city"],
        district: json["district"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        "imageUrl": imageUrl,
        "category": category,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "city": city,
        "district": district,
      };
}

class UserId {
  String? id;
  String? name;
  String? lastName;

  UserId({
    this.id,
    this.name,
    this.lastName,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        name: json["name"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastName": lastName,
      };
}
