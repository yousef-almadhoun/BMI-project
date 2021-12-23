import 'package:arabic_screen/Component/DDText.dart';
import 'package:arabic_screen/Utils/Responsive.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FriendScreenDrawer extends StatelessWidget {
  Responsive responsive = Responsive();
  Widget listCard() {
    return Container(
      height: responsive.setHeight(6),
      child: ListTile(
        trailing: Icon(
          Icons.account_circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      width: responsive.setWidth(80),
      child: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: responsive.setHeight(3),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: Container(
                        // child: Icon(
                        //   Icons.cancel_sharp,
                        //   size: 20,
                        // ),
                        ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: DDText(
                      title: "+ إضافة صديق",
                      weight: "SemiBold",
                      size: 21,
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.FriendScreenDrawer),
                  // ),
                ],
              ),
            ),
            Divider(),
            listCard(),
            Divider(),
            listCard(),
            Divider(),
            listCard(),
            Divider(),
            listCard(),
            Divider(),
          ],
        ),
      ),
    );
  }
}
