// To parse this JSON data, do
//
//     final friendModel = friendModelFromJson(jsonString);

import 'dart:convert';

FriendModel friendModelFromJson(String str) =>
    FriendModel.fromJson(json.decode(str));

String friendModelToJson(FriendModel data) => json.encode(data.toJson());

class FriendModel {
  FriendModel({
    required this.uidOwner,
    required this.uidFriend,
    required this.dateCreated,
    required this.uid,
  });

  String uidOwner;
  String uidFriend;
  String dateCreated;
  String uid;

  factory FriendModel.fromJson(Map<String, dynamic> json) => FriendModel(
        uidOwner: json["uid-owner"],
        uidFriend: json["uid-friend"],
        dateCreated: json["date-created"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "uid-owner": uidOwner,
        "uid-friend": uidFriend,
        "date-created": dateCreated,
        "uid": uid,
      };
}
