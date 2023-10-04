import 'package:flutter/material.dart';

class searchBar extends StatefulWidget {
   searchBar({
    required this.getSearchText,
    Key? key}) : super(key: key);

  Function(String) getSearchText;

  @override
  State<searchBar> createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  TextEditingController searchController = TextEditingController();
  String searchText= '';
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade300,
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(
                fontSize: 18
            ),
            // contentPadding: EdgeInsets.all(30),
            prefixIcon: IconButton(
              onPressed: (){
                setState((){
                  searchText = searchController.text.trim();
                  print(searchText);
                });
              },
              icon: Icon(Icons.search,size: 28,),
            )
        ),
        onChanged: (value){
          setState((){
            searchText = value;
            widget.getSearchText(searchText);
            print(searchText);
          });
        },
      ),
    );
  }
}
