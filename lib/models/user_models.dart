import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.image,
    required this.name,
    required this.email,
    required this.userName,
    required this.uid,
    required this.followers,
    required this.following,
  });

  String? image;
  String? name;
  String? email;
  String? userName;
  String? uid;
  int? followers;
  int? following;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        image: json["image"],
        name: json["name"],
        email: json["email"],
        userName: json["user-name"],
        uid: json["uid"],
        followers: json["followers"],
        following: json["following"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "email": email,
        "user-name": userName,
        "uid": uid,
        "followers": followers,
        "following": following,
      };
}
