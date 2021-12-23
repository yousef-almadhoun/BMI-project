import 'dart:convert';

CommentModel commentModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
    required this.uidOwner,
    required this.comment,
    required this.placeId,
    required this.dateCreated,
    required this.uid,
  });

  String uidOwner;
  String comment;
  String placeId;
  String dateCreated;
  String uid;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        uidOwner: json["uid-owner"],
        comment: json["comment"],
        placeId: json["place-id"],
        dateCreated: json["date-created"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "uid-owner": uidOwner,
        "comment": comment,
        "place-id": placeId,
        "date-created": dateCreated,
        "uid": uid,
      };
}
