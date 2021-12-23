import 'package:arabic_screen/Component/DDText.dart';
import 'package:arabic_screen/Utils/Responsive.dart';
import 'package:arabic_screen/View/user_profile_view.dart';
import 'package:arabic_screen/models/user_models.dart';
import 'package:flutter/material.dart';

class FollowFriends extends StatelessWidget {
  final UserModel user;
  final bool isFollowWidget;
  final Function(String) onTap;

  FollowFriends({
    Key? key,
    this.isFollowWidget = false,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  final Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserProfileScreen(
              uidUser: user.uid,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: responsive.setHeight(4),
              backgroundColor: Colors.white,
              backgroundImage: user.image != ""
                  ? NetworkImage(user.image ?? "")
                  : AssetImage("assets/images/addImage.png") as ImageProvider,
            ),
            SizedBox(
              height: responsive.setHeight(3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DDText(
                  title: user.name ?? "",
                ),
                DDText(
                  title: " :الاسم",
                  color: Colors.green,
                ),
              ],
            ),
            SizedBox(
              height: responsive.setHeight(1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DDText(
                  title: (user.followers ?? "0").toString(),
                ),
                DDText(
                  title: " :المتابعون",
                  color: Colors.green,
                ),
              ],
            ),
            SizedBox(
              height: responsive.setHeight(1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DDText(
                  title: (user.following ?? "0").toString(),
                ),
                DDText(
                  title: " :المتابعين",
                  color: Colors.green,
                ),
              ],
            ),
            SizedBox(
              height: responsive.setHeight(3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                      color: isFollowWidget ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                    child: DDText(
                      title: isFollowWidget ? "متابعة" : "إلغاء المتابعة",
                      color: Colors.white,
                    ),
                    onPressed: () => onTap(user.uid ?? ""),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
