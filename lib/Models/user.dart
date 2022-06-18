// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? name;
  String? lastName;
  String? mail;
  String? password;
  String? id;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.name,
    this.lastName,
    this.mail,
    this.password,
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        lastName: json["lastName"],
        mail: json["mail"],
        password: json["password"],
        id: json["_id"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "mail": mail,
        "password": password,
        "_id": id,
        "userId": userId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
