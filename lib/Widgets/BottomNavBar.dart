import 'package:arabic_screen/Utils/Responsive.dart';
import 'package:arabic_screen/View/ProfileScreen.dart';
import 'package:arabic_screen/View/SearchScreen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  BuildContext drawerContext;
  int index;
  GlobalKey<ScaffoldState> skey;

  BottomNavBar(
    this.drawerContext,
    this.skey,
    {this.index = 5,}
  );
  @override
  _BottomNavBarState createState() => _BottomNavBarState(
        this.drawerContext,
        // this.index,
      );
}

class _BottomNavBarState extends State<BottomNavBar> {
  BuildContext drawerContext;
  Responsive responsive = Responsive();
  bool isVisible = false;
  // int index = 1;
  int? currentIndex = 1;

  _BottomNavBarState(
    this.drawerContext,
    // this.index,
  );

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      height: responsive.setHeight(9),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Color(0xFF3F7C37),
            Color(0xFF86CB91),
          ],
        ),
      ),
      child: Container(
        height: responsive.setHeight(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                widget.skey.currentState!.openDrawer();
              },
              child: Container(
                margin: EdgeInsets.only(left: 8),
                height: responsive.setHeight(5),
                width: responsive.setWidth(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/menuIcon.png"),
                  ),
                ),
              ),
            ),
            // Padding(
            // padding: const EdgeInsets.only(bottom: 10.0),
            // child:
            GestureDetector(
              onTap: () {
                // setState(() {
                //   currentIndex = index;
                // });
                if (widget.index != 1) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                      (route) => false);
                }
              },
              child: Container(
                height: responsive.setHeight(11),
                width: responsive.setWidth(20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/world.png"),
                  ),
                ),
              ),
            ),
            // ),
            IconButton(
              onPressed: () {
                // setState(() {
                //   currentIndex = index;
                // });
                if (widget.index != 2) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                      (route) => false);
                }
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => ProfileScreen(),
                //     ),
                //     (route) => false);
              },
              icon: Icon(
                Icons.account_circle_rounded,
                color: Color(0xFFFFFFFF),
              ),
              iconSize: 40,
            ),
          ],
        ),
      ),
    );
  }
}
