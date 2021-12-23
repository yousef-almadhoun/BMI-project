import 'package:arabic_screen/Component/DDText.dart';
import 'package:arabic_screen/Utils/Responsive.dart';
import 'package:arabic_screen/Utils/TextConstant.dart';
import 'package:arabic_screen/Utils/firebase_manager.dart';
import 'package:arabic_screen/Utils/maps.dart';
import 'package:arabic_screen/Widgets/Visibility/PlaceName.dart';
import 'package:arabic_screen/models/comment_model.dart';
import 'package:arabic_screen/models/land_marks_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

// ignore: must_be_immutable
class Comments extends StatelessWidget {
  Responsive responsive = Responsive();

  final String uidPlace;

  Comments(this.uidPlace);
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xFFDED9D9),
            width: 1,
          ),
        ),
        child: FutureBuilder<PlaceDetails?>(
            future: Maps.shared.displayPrediction(uidPlace),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                PlaceDetails? object = snapshot.data;

                return Column(
                  children: [
                    SizedBox(
                      height: responsive.setHeight(12),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: DDText(
                                weight: "SemiBold",
                                title: object?.name ?? "",
                                color: Color(0xFF599958),
                                size: 12,
                              ),
                            ),
                            DDText(
                              weight: "SemiBold",
                              title:
                                  "${TextConstant.ar["SearchScreen"]["Title"]}",
                              color: Color(0xFF599958),
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsive.setHeight(1),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(right: 5.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         DDText(
                    //           weight: "SemiBold",
                    //           title: (object?.openingHours?.periods ?? [])
                    //               .join(", "),
                    //           color: Color(0xFF599958),
                    //           size: 12,
                    //         ),
                    //         DDText(
                    //           weight: "SemiBold",
                    //           color: Color(0xFF599958),
                    //           size: 12,
                    //           title:
                    //               "${TextConstant.ar["SearchScreen"]["WorkTime"]}",
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: responsive.setHeight(1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: DDText(
                              weight: "SemiBold",
                              title: "${object?.types.first}",
                              color: Color(0xFF599958),
                              size: 12,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: DDText(
                              weight: "SemiBold",
                              title:
                                  "${TextConstant.ar["SearchScreen"]["Category"]}",
                              color: Color(0xFF599958),
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsive.setHeight(3),
                    ),
                    FutureBuilder<LandMarksModel?>(
                        future: FirebaseManager.shared
                            .checkMarkerIsAdded(placeId: object?.placeId ?? ""),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data?.uid != "") {
                              return MaterialButton(
                                minWidth: responsive.setWidth(35),
                                color: Colors.red,
                                onPressed: () async {
                                  await FirebaseManager.shared
                                      .deleteMarker(snapshot.data?.uid ?? "");
                                  Navigator.of(context).pop();
                                },
                                child: DDText(
                                  color: Color(0xFFFFFFFF),
                                  weight: "SemiBold",
                                  size: 13,
                                  title: "إزالة الزيارة",
                                ),
                              );
                            } else {
                              return MaterialButton(
                                minWidth: responsive.setWidth(35),
                                color: Color(0xFF5BAF68),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: PlaceName(
                                            uidPlace: object?.placeId ?? "",
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  // pageController.jumpToPage(1);
                                },
                                child: DDText(
                                  color: Color(0xFFFFFFFF),
                                  weight: "SemiBold",
                                  size: 13,
                                  title:
                                      "${TextConstant.ar["SearchScreen"]["RecordYourVisit"]}",
                                ),
                              );
                            }
                          } else {
                            return SizedBox();
                          }
                        }),
                    SizedBox(
                      height: responsive.setHeight(3),
                    ),
                    DDText(
                      title: "${TextConstant.ar["SearchScreen"]["Comments"]}",
                      color: Color(0xFF599958),
                      size: 20,
                      weight: "SemiBold",
                    ),
                    SizedBox(
                      height: responsive.setHeight(1),
                    ),
                    StreamBuilder<List<CommentModel>>(
                        stream: FirebaseManager.shared.getCommentsByPlaceId(
                            placeId: object?.placeId ?? ""),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data?.length == 0
                                ? DDText(title: "لا يوجد تعليقات")
                                : Expanded(
                                    child: ListView.builder(
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.account_circle_rounded,
                                                size: 36,
                                                color: Colors.transparent,
                                              ),
                                              DDText(
                                                title: snapshot
                                                        .data?[index].comment ??
                                                    "",
                                              ),
                                              Icon(
                                                Icons.account_circle_rounded,
                                                size: 36,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                          } else {
                            return SizedBox();
                          }
                        }),
                    SizedBox(
                      height: responsive.setHeight(2),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            }),
      ),
    );
  }
}
