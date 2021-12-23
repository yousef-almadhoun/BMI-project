import 'package:arabic_screen/Component/DDText.dart';
import 'package:arabic_screen/Utils/Responsive.dart';
import 'package:arabic_screen/Utils/TextConstant.dart';
import 'package:flutter/material.dart';

class NotificationDrawer extends StatelessWidget {
  final Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      width: responsive.setWidth(75),
      child: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: responsive.setHeight(3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(0xFF000000),
                  ),
                  iconSize: 40,
                ),
                DDText(
                  title: "${TextConstant.ar["Notification"]["Notification"]}",
                  size: 37,
                  color: Color(0xFF707070),
                ),
                Container(width: responsive.setWidth(15)),
              ],
            ),
            SizedBox(
              height: responsive.setHeight(2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DDText(
                  title: "${TextConstant.ar["Notification"]["Friend"]}",
                  size: 21,
                  weight: "SemiBold",
                  color: Color(0xFF707070),
                ),
                SizedBox(
                  width: responsive.setWidth(3),
                ),
                Icon(
                  Icons.account_circle_rounded,
                  size: 40,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: DDText(
                    title: "05:30 PM",
                    weight: "SemiBold",
                    color: Color(0xFF707070),
                    size: 10,
                  ),
                ),
                trailing: Icon(
                  Icons.location_on,
                  size: 30,
                  color: Color(0xFF000000),
                ),
                title: Container(
                  alignment: Alignment.centerRight,
                  child: DDText(
                    size: 16,
                    color: Color(0xFF707070),
                    // weight: "SemiBold",
                    title: "${TextConstant.ar["Notification"]["Jolt"]}",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: responsive.setHeight(2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DDText(
                  title: "${TextConstant.ar["Notification"]["Friend"]}",
                  size: 21,
                ),
                SizedBox(
                  width: responsive.setWidth(3),
                ),
                Icon(
                  Icons.account_circle_rounded,
                  size: 40,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: DDText(
                    title: "05:30 PM",
                    weight: "SemiBold",
                    size: 10,
                    color: Color(0xFF707070),
                  ),
                ),
                trailing: Icon(
                  Icons.location_on,
                  size: 30,
                  color: Color(0xFF000000),
                ),
                title: Container(
                  alignment: Alignment.centerRight,
                  child: DDText(
                    size: 16,
                    title: "${TextConstant.ar["Notification"]["RiyadhPark"]}",
                    color: Color(0xFF707070),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
