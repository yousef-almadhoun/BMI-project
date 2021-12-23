// To parse this JSON data, do
//
//     final landMarksModel = landMarksModelFromJson(jsonString);

import 'dart:convert';

import 'package:arabic_screen/enums/place_type.dart';

LandMarksModel landMarksModelFromJson(String str) =>
    LandMarksModel.fromJson(json.decode(str));

String landMarksModelToJson(LandMarksModel data) => json.encode(data.toJson());

class LandMarksModel {
  LandMarksModel({
    required this.uidOwner,
    required this.lat,
    required this.lng,
    this.category,
    required this.dateCreated,
    required this.uid,
    required this.placeId,
  });

  String? uidOwner;
  double? lat;
  double? lng;
  String? dateCreated;
  String? uid;
  PlaceType? category;
  String placeId;

  factory LandMarksModel.fromJson(Map<String, dynamic> json) => LandMarksModel(
      uidOwner: json["uid-owner"],
      lat: json["lat"].toDouble(),
      lng: json["lng"].toDouble(),
      category: PlaceType.values[json["category"]],
      dateCreated: json["date-created"],
      uid: json["uid"],
      placeId: json["place-id"]);

  Map<String, dynamic> toJson() => {
        "uid-owner": uidOwner,
        "lat": lat,
        "lng": lng,
        "category": category?.index,
        "date-created": dateCreated,
        "uid": uid,
        "place-id": placeId,
      };
}
