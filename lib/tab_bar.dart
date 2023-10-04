import 'package:flutter/material.dart';

class tabBarWidget extends StatelessWidget {
   tabBarWidget({
    required this.Tabs,
    required this.onTap,
    Key? key}) : super(key: key);
  List Tabs;
  Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: Tabs.length,
        child: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.black38,
            unselectedLabelStyle: TextStyle(
             fontSize: 16
            ),
            labelColor: Theme.of(context).primaryColor,
            onTap: onTap,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
            indicatorWeight: 0.1,

            tabs: Tabs.map((e) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(10),
                    color: Colors.grey.shade300
                ),
                child: Text(e,
                style: TextStyle(
                    fontSize: 19,
                  fontWeight: FontWeight.w600
                ),),
              );
            }).toList()
        ));
  }
}
