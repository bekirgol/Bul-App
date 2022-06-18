// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String? id;
  String? name;
  String? lastName;
  String? mail;
  DateTime? createdAt;
  DateTime? updatedAt;
  Tokens? tokens;

  LoginResponse({
    this.id,
    this.name,
    this.lastName,
    this.mail,
    this.createdAt,
    this.updatedAt,
    this.tokens,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["_id"],
        name: json["name"],
        lastName: json["lastName"],
        mail: json["mail"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        tokens: Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastName": lastName,
        "mail": mail,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "tokens": tokens?.toJson(),
      };
}

class Tokens {
  String? accesToken;
  String? refreshToken;

  Tokens({
    this.accesToken,
    this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        accesToken: json["acces_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "acces_token": accesToken,
        "refresh_token": refreshToken,
      };
}
