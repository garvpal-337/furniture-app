import 'package:flutter/material.dart';
import 'package:furniture/itemController.dart';
import 'package:furniture/listCard.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class listViewWidget extends StatelessWidget {
  listViewWidget(
      {required this.Selectedtab,
      required this.animation,
      required this.controller,
      required this.searchText,
      Key? key})
      : super(key: key);
  AnimationController controller;
  Animation<Offset> animation;
  var Selectedtab;
  List<Furniture> ListShow = [];
  String searchText;

  Future<void> fetchdata() async {
    final data = Get.put(furnitureData());
    await data.fetchData();

    if (searchText != '') {
      ListShow = data.items.where((item) {
        print("index = ${item.name.indexOf(searchText)}");

        return item.name.contains(searchText);
      }).toList();
    } else if (Selectedtab == 0) {
      ListShow = data.items;
    } else if (Selectedtab == 1) {
      ListShow = data.items.where((item) => item.Typ == "sofa").toList();
    } else if (Selectedtab == 2) {
      ListShow = data.items.where((item) => item.Typ == "park").toList();
    } else if (Selectedtab == 3) {
      ListShow = data.items.where((item) => item.Typ == "armchair").toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // background white container with rounded top left and right
        Container(
          margin: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40)),
              color: Colors.white),
        ),
        // Container for listView
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: FutureBuilder(
              future: fetchdata(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListShow.isEmpty
                        ? Center(
                            child: Text(
                              "No item found",
                              style: GoogleFonts.lora(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          )
                        : listCard(
                            ListShow: ListShow,
                            searchText: searchText,
                            animation: animation,
                            cardTyp: "",
                          );
              }),
        ),
      ],
    );
  }
}
