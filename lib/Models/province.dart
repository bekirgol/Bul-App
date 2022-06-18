// To parse this JSON data, do
//
//     final cityAndRegion = cityAndRegionFromJson(jsonString);

import 'dart:convert';

List<CityAndRegion> cityAndRegionFromJson(String str) =>
    List<CityAndRegion>.from(
        json.decode(str).map((x) => CityAndRegion.fromJson(x)));

class CityAndRegion {
  CityAndRegion({
    this.il,
    this.ilceleri,
  });

  String? il;
  List<String>? ilceleri;

  factory CityAndRegion.fromJson(Map<String, dynamic> json) => CityAndRegion(
        il: json["il"],
        ilceleri: List<String>.from(json["ilceleri"].map((x) => x)),
      );
}
