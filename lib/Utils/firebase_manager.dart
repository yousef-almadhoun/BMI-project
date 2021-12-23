import 'dart:io';

import 'package:arabic_screen/Utils/UserProfile.dart';
import 'package:arabic_screen/enums/place_type.dart';
import 'package:arabic_screen/models/comment_model.dart';
import 'package:arabic_screen/models/friend_model.dart';
import 'package:arabic_screen/models/land_marks_model.dart';
import 'package:arabic_screen/models/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseManager {
  static final FirebaseManager shared = FirebaseManager();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection('User');
  final landMarksRef = FirebaseFirestore.instance.collection('LandMarks');
  final friendRef = FirebaseFirestore.instance.collection('Friend');
  final commentRef = FirebaseFirestore.instance.collection('Comment');
  final storageRef = FirebaseStorage.instance.ref();

  Future<String?> _createAccountInFirebase(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      throw e.code.split("-").join(" ");
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> createAccountUser({
    required String name,
    required String email,
    required String userName,
    required String password,
  }) async {
    String? userId;

    UserModel? user = await getUserByUserName(userName: userName);

    if (user != null) {
      throw "Username is not available";
    }

    try {
      userId = await _createAccountInFirebase(email: email, password: password);
    } catch (e) {
      throw e.toString();
    }

    if (userId != null) {
      await userRef.doc(userId).set({
        "image": "",
        "name": name,
        "email": email,
        "user-name": userName,
        "followers": 0,
        "following": 0,
        "uid": userId,
      }).then((value) async {
        return true;
      }).catchError((e) {
        throw e;
      });
    }

    return true;
  }

  editProfile({
    required String image,
    required String name,
    required String email,
    String? password,
  }) async {
    String imageUrl = "";

    if (Uri.parse(image).isAbsolute) {
      imageUrl = image;
    } else if (image != "") {
      imageUrl = await _uploadImage(folderName: "User", imagePath: image);
    }

    // if (password != null && password != "") {
    //   try {
    //     auth.currentUser?.updatePassword(password);
    //   } catch (e) {
    //     throw e;
    //   }
    // }

    await userRef.doc(currentUser()?.uid ?? "").update({
      "image": imageUrl,
      "name": name,
    }).then((value) async {
      return true;
    }).catchError((e) {
      throw e;
    });
  }

  User? currentUser() {
    return auth.currentUser;
  }

  Future<UserModel> getUserByUid({required String uid}) async {
    UserModel userTemp;

    var user = await userRef.doc(uid).snapshots().first;
    userTemp = UserModel.fromJson(user.data() ?? {});

    return userTemp;
  }

  Future<UserModel?> getUserByUserName({required String userName}) async {
    UserModel? user;
    try {
      UserModel tempUser = await userRef
          .where("user-name", isEqualTo: userName)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        return snapshot.docs.map((doc) {
          return UserModel.fromJson(doc.data() as Map<String, dynamic>);
        }).first;
      }).first;

      user = tempUser;
    } catch (e) {
      return null;
    }
    return user;
  }

  Future<UserModel?> login(
      {required String userName, required String password}) async {
    try {
      UserModel? user = await getUserByUserName(userName: userName);

      if (user == null) {
        throw "User not found";
      }

      await auth.signInWithEmailAndPassword(
        email: user.email ?? "",
        password: password,
      );

      UserProfile.shared.setUser(user: user);

      return user;
    } on FirebaseAuthException catch (e) {
      throw e.code.split("-").join(" ");
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      throw e.code.split("-").join(" ");
    }
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await UserProfile.shared.setUser(user: null);
    } catch (e) {
      throw e.toString();
    }
  }

  addMarker({
    required String placeId,
    required double lat,
    required double lng,
    required PlaceType category,
  }) async {
    String uid = landMarksRef.doc().id;

    await landMarksRef.doc(uid).set({
      "place-id": placeId,
      "uid-owner": auth.currentUser?.uid,
      "lat": lat,
      "lng": lng,
      "category": category.index,
      "date-created": DateTime.now().toString(),
      "uid": uid,
    }).catchError((e) {
      throw e;
    });
  }

  Future<List<LandMarksModel>> getMyMarks() {
    return landMarksRef
        .where("uid-owner", isEqualTo: auth.currentUser?.uid)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return LandMarksModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }

  Future<List<LandMarksModel>> getMarksUser(String uidUser) {
    return landMarksRef
        .where("uid-owner", isEqualTo: uidUser)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return LandMarksModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }

  Future<List<LandMarksModel>> getMyMarksFriends() async {
    List<LandMarksModel> marks = [];

    List<FriendModel> friends = await getMyFriends().first;

    for (FriendModel friend in friends) {
      List<LandMarksModel> items = await getMarksUser(friend.uidFriend);

      marks = [...marks, ...items];
    }

    return marks;
  }

  Future<List<UserModel>> getAllUsers() {
    return userRef.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }

  deleteMarker(String uid) {
    try {
      landMarksRef.doc(uid).delete();
    } catch (e) {
      throw e.toString();
    }
  }

  updateFollowers(String uidUser, int value) async {
    UserModel user = await FirebaseManager.shared.getUserByUid(uid: uidUser);
    userRef.doc(uidUser).update({
      "followers": ((user.followers ?? 0) + value),
    });
  }

  updateFollowing(String uidUser, int value) async {
    UserModel user = await FirebaseManager.shared.getUserByUid(uid: uidUser);
    userRef.doc(uidUser).update({
      "following": ((user.following ?? 0) + value),
    });
  }

  addFriend(String uidFriend) async {
    String uid = friendRef.doc().id;

    await friendRef.doc(uid).set({
      "uid-owner": auth.currentUser?.uid,
      "uid-friend": uidFriend,
      "date-created": DateTime.now().toString(),
      "uid": uid,
    }).then((value) {
      updateFollowers(auth.currentUser?.uid ?? "", 1);
      updateFollowing(uidFriend, 1);
    }).catchError((e) {
      throw e;
    });
  }

  Stream<List<FriendModel>> getMyFriends() {
    return friendRef
        .where("uid-owner", isEqualTo: auth.currentUser?.uid)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return FriendModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<List<UserModel>> getSuggestedFriend() async {
    List<UserModel> users = [];

    List<String> friendsIds = [];

    List<FriendModel> friends = await getMyFriends().first;

    for (var friend in friends) {
      friendsIds.add(friend.uidFriend);
    }

    List<UserModel> allUsers = await getAllUsers();

    for (UserModel user in allUsers) {
      if (user.uid != auth.currentUser?.uid && !friendsIds.contains(user.uid)) {
        users.add(user);
      }
    }

    return users;
  }

  deleteFriend(String uid, String uidFriend) {
    friendRef.doc(uid).delete();
    updateFollowers(auth.currentUser?.uid ?? "", -1);
    updateFollowing(uidFriend, -1);
  }

  Future<String> _uploadImage(
      {required String folderName, required String imagePath}) async {
    UploadTask uploadTask =
        storageRef.child('$folderName/${Uuid().v4()}').putFile(File(imagePath));
    String url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }

  addComment({
    required String placeId,
    required String comment,
  }) async {
    String uid = commentRef.doc().id;

    await commentRef.doc(uid).set({
      "uid-owner": auth.currentUser?.uid,
      "comment": comment,
      "place-id": placeId,
      "date-created": DateTime.now().toString(),
      "uid": uid,
    }).catchError((e) {
      throw e;
    });
  }

  Stream<List<CommentModel>> getCommentsByPlaceId({required String placeId}) {
    return commentRef
        .where("place-id", isEqualTo: placeId)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return CommentModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<LandMarksModel> checkMarkerIsAdded({required String placeId}) async {
    List<LandMarksModel> myMarkers = await this.getMyMarks();

    for (var item in myMarkers) {
      if (item.placeId == placeId) {
        return item;
      }
    }

    return LandMarksModel(
        uidOwner: "", lat: 0, lng: 0, dateCreated: "", uid: "", placeId: "");
  }
}
