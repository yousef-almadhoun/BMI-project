import 'package:arabic_screen/Component/DDText.dart';
import 'package:arabic_screen/Utils/Responsive.dart';
import 'package:arabic_screen/Utils/maps.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

// ignore: must_be_immutable
class BottomDrawer extends StatefulWidget {
  final Function(LatLng latLng) callback;

  const BottomDrawer({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<BottomDrawer> createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> {
  Responsive responsive = Responsive();

  List<PlacesSearchResult> items = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Widget drawerContainer(String title) {
    return Container(
      height: responsive.setHeight(15),
      width: responsive.setWidth(74),
      decoration: BoxDecoration(
        color: Color(0xFF4C8B54),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        child: Center(
          child: Container(
            width: responsive.setWidth(40),
            height: responsive.setHeight(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFA1DEAB).withOpacity(0.77),
                  Color(0xFFD9F0DC).withOpacity(0.77),
                ],
              ),
            ),
            child: Center(
              child: DDText(
                title: title,
                center: true,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      width: responsive.setWidth(75),
      child: Drawer(
        child: Container(
          width: responsive.setWidth(70),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.25, 0.5, 0.75, 1.0],
              colors: [
                Color(0xFF5BAF68),
                Color(0xFF549F5F),
                Color(0xFF57A763),
                Color(0xFF38593A),
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: responsive.setHeight(3),
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: responsive.setHeight(5),
              ),
              DDText(
                title: "الأماكن المتداولة",
                size: 28,
                weight: "SemiBold",
                color: Color(0xFFFFFFFF),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: responsive.setHeight(3),
                        ),
                        InkWell(
                          onTap: () {
                            var latLng = LatLng(
                              items[index].geometry?.location.lat ?? 0,
                              items[index].geometry?.location.lng ?? 0,
                            );
                            widget.callback(latLng);
                            Navigator.of(context).pop();
                          },
                          child: drawerContainer(items[index].name),
                        ),
                        SizedBox(
                          height: responsive.setHeight(3),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getData() async {
    var restaurants = await Maps.shared.search(key: "restaurant") ?? [];
    var library = await Maps.shared.search(key: "library") ?? [];
    var cafe = await Maps.shared.search(key: "cafe") ?? [];
    var garden = await Maps.shared.search(key: "garden") ?? [];
    items = [...restaurants, ...library, ...cafe, ...garden];
    setState(() {});
  }
}
