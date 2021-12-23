import 'package:arabic_screen/models/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  static final UserProfile shared = UserProfile();

  Future<UserModel?> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString('user');
      return data == "" ? null : userModelFromJson(data ?? "");
    } catch (e) {
      return null;
    }
  }

  setUser({@required UserModel? user}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', user == null ? "" : userModelToJson(user));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
