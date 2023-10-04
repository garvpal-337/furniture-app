import 'package:flutter/material.dart';
import 'package:furniture/cartController.dart';
import 'package:furniture/itemController.dart';
import 'package:furniture/listViewWidget.dart';
import 'package:furniture/searchBar.dart';
import 'package:furniture/tab_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<Offset> _animation;
  String searchText= '';

  void getStext(String Stext){
    setState((){
      searchText = Stext;

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 1200))..forward();
    _animation = Tween<Offset>(begin: Offset(0.0,2.0),end: Offset(0.0,0.0)).animate(CurvedAnimation(parent: _controller,
        curve: Curves.easeInSine));
  }
  final cartdata = Get.put(cartData());

  var selectedTab = 0;
  void onTap (index){
    setState((){
      selectedTab = index;
      _controller.reset();
      _controller.forward();
      print(selectedTab);
    });
  }

  final postthis = Get.put(furnitureData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.indigo,
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text("Dashboard",
                        style: GoogleFonts.lora(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                      Spacer(),
                      IconButton(onPressed: (){},
                          icon: Icon(Icons.notifications_none_outlined,color: Colors.white,size: 35,))
                    ],
                  ),
                ),
                searchBar(getSearchText: getStext),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: FittedBox(
                    child: tabBarWidget(Tabs: [
                      "All",
                      "Sofa",
                      "Park Bench",
                      "ArmChair"
                    ], onTap: onTap),
                  ),
                )
              ],),
            ),
            Expanded(
              child: listViewWidget(
                Selectedtab: selectedTab,
                controller: _controller,
                animation: _animation,
                searchText: searchText,
              )),
          ],
        ),
      )
    );
  }
}
