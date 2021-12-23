import 'dart:async';

import 'package:arabic_screen/Utils/Responsive.dart';
import 'package:arabic_screen/Utils/maps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

// ignore: must_be_immutable
class Search extends StatefulWidget {
  final Function(LatLng latLng) callback;

  const Search({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Responsive responsive = Responsive();

  List<PlacesSearchResult> items = [];

  Widget listCard({context, required String title}) {
    return GestureDetector(
      child: Container(
        height: responsive.setHeight(6),
        child: ListTile(
          trailing: Icon(
            Icons.account_circle,
            color: Color(0xFF000000),
          ),
          title: Text(title),
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
                    child: Icon(
                      CupertinoIcons.multiply,
                      size: 20,
                      color: Color(0xFF707070),
                    ),
                  ),
                  // DDText(
                  //   title: "البحث",
                  //   weight: "SemiBold",
                  //   size: 21,
                  // ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) => onChangeSearchValue(value.trim()),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "بحث",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<PlaceDetails?>(
                      future:
                          Maps.shared.displayPrediction(items[index].placeId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return InkWell(
                            onTap: () {
                              var latLng = LatLng(
                                snapshot.data?.geometry?.location.lat ?? 0,
                                snapshot.data?.geometry?.location.lng ?? 0,
                              );
                              widget.callback(latLng);
                              Navigator.of(context).pop();
                            },
                            child: Column(
                              children: [
                                Divider(),
                                listCard(title: snapshot.data?.name ?? ""),
                                Divider(),
                              ],
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onChangeSearchValue(String? value) async {
    List<PlacesSearchResult>? results =
        await Maps.shared.searchAddress(key: value ?? "");
    items = results ?? [];
    setState(() {});
  }
}
