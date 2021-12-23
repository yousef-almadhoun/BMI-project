import 'package:arabic_screen/Component/DDText.dart';
import 'package:arabic_screen/Utils/Responsive.dart';
import 'package:arabic_screen/Utils/TextConstant.dart';
import 'package:arabic_screen/View/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AllowLocation extends StatefulWidget {
  AllowLocation();

  @override
  State<AllowLocation> createState() => _AllowLocationState();
}

class _AllowLocationState extends State<AllowLocation> {
  Responsive responsive = Responsive();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLocationAccess();
  }

  bool locationGranted = false;
  void checkLocationAccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locationGranted = prefs.getBool("locationGranted") ?? false;
    setState(() {});
  }

  void grantLocationAccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("locationGranted", true);
  }

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Visibility(
      visible: true,
      child: Container(
        width: responsive.setWidth(90),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: responsive.setHeight(2),
              ),
              DDText(
                size: 11,
                weight: "SemiBold",
                title: "${TextConstant.ar["AllowLocation"]["Permission"]}",
              ),
              SizedBox(
                height: responsive.setHeight(2),
              ),
              Container(
                height: responsive.setHeight(5),
                width: responsive.setWidth(60),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF5BAF68),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    // grantLocationAccess();
                    final status = await Permission.locationWhenInUse.request();
                    if (status == PermissionStatus.granted) {
                      Navigator.of(context).pop();
                    } else if (status == PermissionStatus.denied) {
                      Fluttertoast.showToast(
                              backgroundColor:
                                  Color(0xFF399843).withOpacity(0.7),
                              msg: "You are not Allowed in this Application")
                          .then(
                        (value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(),
                            ),
                            (route) => false),
                      );
                    } else if (status == PermissionStatus.permanentlyDenied) {
                      await openAppSettings();
                    }
                  },
                  child: DDText(
                    weight: "SemiBold",
                    title: "${TextConstant.ar["AllowLocation"]["Allow"]}",
                    size: 11,
                  ),
                ),
              ),
              SizedBox(
                height: responsive.setHeight(0.5),
              ),
              Container(
                height: responsive.setHeight(5),
                width: responsive.setWidth(60),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF5BAF68),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    Fluttertoast.showToast(
                            backgroundColor: Color(0xFF399843).withOpacity(0.7),
                            msg: "You are not Allowed in this Application")
                        .then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(),
                          ),
                          (route) => false),
                    );
                  },
                  child: DDText(
                    weight: "SemiBold",
                    title: "${TextConstant.ar["AllowLocation"]["DisAllow"]}",
                    size: 11,
                  ),
                ),
              ),
              SizedBox(
                height: responsive.setHeight(5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
