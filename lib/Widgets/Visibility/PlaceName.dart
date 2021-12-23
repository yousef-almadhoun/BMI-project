import 'package:arabic_screen/Component/DDText.dart';
import 'package:arabic_screen/Utils/Responsive.dart';
import 'package:arabic_screen/Utils/TextConstant.dart';
import 'package:arabic_screen/Utils/firebase_manager.dart';
import 'package:arabic_screen/Utils/maps.dart';
import 'package:arabic_screen/View/SearchScreen.dart';
import 'package:arabic_screen/enums/place_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';

class PlaceName extends StatefulWidget {
  final String uidPlace;

  const PlaceName({Key? key, required this.uidPlace}) : super(key: key);

  @override
  _PlaceNameState createState() => _PlaceNameState();
}

class _PlaceNameState extends State<PlaceName> {
  Responsive responsive = Responsive();

  PlaceType? placeType;
  String? value = "";

  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.green,
              width: 1,
            ),
          ),
          child: FutureBuilder<PlaceDetails?>(
              future: Maps.shared.displayPrediction(widget.uidPlace),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  PlaceDetails? object = snapshot.data;

                  return Column(
                    children: [
                      SizedBox(
                        height: responsive.setHeight(4),
                      ),
                      DDText(
                        title: "${object?.name}",
                        weight: "SemiBold",
                        size: 24,
                      ),
                      SizedBox(
                        height: responsive.setHeight(2),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 28.0),
                        alignment: Alignment.centerRight,
                        child: DDText(
                          weight: "SemiBold",
                          size: 12,
                          title:
                              "${TextConstant.ar["SearchScreen"]["Categories"]}",
                          color: Color(0xFF599958),
                        ),
                      ),
                      SizedBox(
                        height: responsive.setHeight(2),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 00.0),
                        child: Container(
                          width: responsive.setWidth(80),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFE5F5E8),
                                Color(0xFFD9F0DC),
                              ],
                            ),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Color(0xFFD9F0DC),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  elevation: 0,
                                  isExpanded: true,
                                  hint: Center(
                                    child: DDText(
                                      center: true,
                                      color: Color(0xFF599958),
                                      weight: "SemiBold",
                                      size: 12,
                                      title: value == ""
                                          ? "${TextConstant.ar["SearchScreen"]["DropDownHint"]}"
                                          : value.toString(),
                                    ),
                                  ),
                                  onChanged: (_value) {
                                    setState(() {
                                      value = _value;
                                      if (_value ==
                                          TextConstant.ar["SearchScreen"]
                                              ["DropDownList1"]) {
                                        placeType = PlaceType.restaurant;
                                      } else if (_value ==
                                          TextConstant.ar["SearchScreen"]
                                              ["DropDownList2"]) {
                                        placeType = PlaceType.cafe;
                                      } else if (_value ==
                                          TextConstant.ar["SearchScreen"]
                                              ["DropDownList3"]) {
                                        placeType = PlaceType.garden;
                                      } else if (_value ==
                                          TextConstant.ar["SearchScreen"]
                                              ["DropDownList4"]) {
                                        placeType = PlaceType.library;
                                      }
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem<String>(
                                      value:
                                          "${TextConstant.ar["SearchScreen"]["DropDownList1"]}",
                                      child: Center(
                                        child: DDText(
                                            color: Color(0xFF599958),
                                            weight: "SemiBold",
                                            size: 12,
                                            title:
                                                "${TextConstant.ar["SearchScreen"]["DropDownList1"]}"),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value:
                                          "${TextConstant.ar["SearchScreen"]["DropDownList2"]}",
                                      child: Center(
                                        child: DDText(
                                            color: Color(0xFF599958),
                                            weight: "SemiBold",
                                            size: 12,
                                            title:
                                                "${TextConstant.ar["SearchScreen"]["DropDownList2"]}"),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value:
                                          "${TextConstant.ar["SearchScreen"]["DropDownList3"]}",
                                      child: Center(
                                        child: DDText(
                                            color: Color(0xFF599958),
                                            weight: "SemiBold",
                                            size: 12,
                                            title:
                                                "${TextConstant.ar["SearchScreen"]["DropDownList3"]}"),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value:
                                          "${TextConstant.ar["SearchScreen"]["DropDownList4"]}",
                                      child: Center(
                                        child: DDText(
                                            color: Color(0xFF599958),
                                            weight: "SemiBold",
                                            size: 12,
                                            title:
                                                "${TextConstant.ar["SearchScreen"]["DropDownList4"]}"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsive.setHeight(20),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20.0),
                        alignment: Alignment.centerRight,
                        child: DDText(
                          title:
                              "${TextConstant.ar["SearchScreen"]["AddNewReview"]}",
                          size: 12,
                          color: Color(0xFF599958),
                          weight: "Bold",
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        width: responsive.setWidth(80),
                        height: responsive.setHeight(15),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Color(0xFFE5F5E8),
                              Color(0xFFD9F0DC),
                            ],
                          ),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  "${TextConstant.ar["SearchScreen"]["WriteAComment"]}",
                            ),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // child: DDText(
                          //   weight: "SemiBold",
                          //   size: 12,
                          //   color: Color(0xFF599958),
                          //   center: true,
                          //   title:
                          //       "${TextConstant.ar["SearchScreen"]["WriteAComment"]}",
                          // ),
                        ),
                        // *************** bad me textField lagegi *******************
                        // child: TextField(
                        //   textDirection: TextDirection.rtl,
                        //   decoration: InputDecoration(
                        //     hintTextDirection: TextDirection.rtl,
                        //     hintStyle: TextStyle(
                        //       color: Color(0xFF599958),
                        //     ),
                        //     hintText: "${TextConstant.ar["SearchScreen"]["WriteAComment"]}",
                        //   ),
                        // ),
                      ),
                      SizedBox(
                        height: responsive.setHeight(2),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 220),
                      //   child: Container(
                      //     alignment: Alignment.centerRight,
                      //     height: 30,
                      //     width: responsive.setWidth(25),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //       gradient: LinearGradient(
                      //         begin: Alignment.centerLeft,
                      //         end: Alignment.centerRight,
                      //         colors: [
                      //           Color(0xFFE5F5E8),
                      //           Color(0xFFD9F0DC),
                      //         ],
                      //       ),
                      //     ),
                      //     child: DDText(
                      //       weight: "Bold",
                      //       size: 10,
                      //       color: Color(0xFF599958),
                      //       title:
                      //           "${TextConstant.ar["SearchScreen"]["AddAPhoto"]}",
                      //       center: true,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: responsive.setHeight(3),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: responsive.setHeight(4),
                            width: responsive.setWidth(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Color(0xFF5BAF68),
                            ),
                            child: MaterialButton(
                              minWidth: responsive.setWidth(40),
                              onPressed: () async {
                                var location = object?.geometry?.location;

                                var comment = _commentController.text;

                                if (comment.trim() != "") {
                                  try {
                                    FirebaseManager.shared.addComment(
                                      placeId: object?.placeId ?? "",
                                      comment: comment,
                                    );
                                  } catch (_) {}
                                }

                                if (placeType == null) {
                                  Get.snackbar(
                                    "خطأ",
                                    "يرجى إختيار نوع المكان",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                  return;
                                }

                                await FirebaseManager.shared.addMarker(
                                  placeId: object?.placeId ?? "",
                                  lat: location?.lat ?? 0,
                                  lng: location?.lng ?? 0,
                                  category: placeType ?? PlaceType.cafe,
                                );
                                SearchScreen.getMarkes(context);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: DDText(
                                size: 13,
                                weight: "SemiBold",
                                title:
                                    "${TextConstant.ar["SearchScreen"]["AddtoMap"]}",
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: responsive.setHeight(1),
                          ),
                          Container(
                            height: responsive.setHeight(4),
                            width: responsive.setWidth(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Color(0xFFFFFFFF),
                              border: Border.all(
                                color: Color(0xFF5BAF68),
                                width: 1,
                              ),
                            ),
                            child: MaterialButton(
                              minWidth: responsive.setWidth(40),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: DDText(
                                color: Color(0xFF5BAF68),
                                size: 13,
                                weight: "SemiBold",
                                title:
                                    "${TextConstant.ar["SearchScreen"]["Cancellation"]}",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: responsive.setHeight(3),
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              }),
        ),
      ),
    );
  }
}
