import 'package:flutter/material.dart';
import 'package:furniture/cartController.dart';
import 'package:furniture/detailScreen.dart';
import 'package:furniture/itemController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class listCard extends StatefulWidget {
  listCard({
    required this.ListShow ,
    required this.searchText,
    required this.animation,
    required this.cardTyp,
    Key? key}) : super(key: key);

  List<Furniture> ListShow;
  String searchText;
  Animation<Offset> animation;
  String cardTyp;

  @override
  State<listCard> createState() => _listCardState();
}

class _listCardState extends State<listCard> {
   final cartList = Get.find<cartData>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: widget.ListShow.length,
        //padding: EdgeInsets.only(top: 20),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder:(ctx,index){
          var SSindex = widget.ListShow[index].name.indexOf(widget.searchText);
          var SEindex = SSindex + widget.searchText.length;


          return SlideTransition(
            position: widget.animation,
            transformHitTests: true,
            // stack for item card
            child: GestureDetector(
              onTap: (){
                Get.to(detailScreen(itemList: widget.ListShow[index],));
              },
              child: Stack(
                children: [
                  //big container outside of card
                  Container(
                    height: 180,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 30,bottom: 10),
                    // card background container for right colors
                    child: Container(
                      height: 150,
                      padding: EdgeInsets.only(right: 10),
                      width: double.infinity,
                      decoration:  BoxDecoration(
                        color: index.isOdd ? Colors.orange.shade300 :Colors.indigo.shade500,
                        borderRadius: BorderRadius.circular(30),),
                      child: Container(
                          height: 150,
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration:  BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2
                                ),
                              ]
                          ),
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 80,
                            width: 150 ,
                            // color: Colors.black,
                            alignment: Alignment.center,
                            child: widget.searchText.isEmpty ?Text(widget.ListShow[index].name,
                                style : GoogleFonts.lora(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color:  Colors.black
                                )) : RichText(
                                text: TextSpan(
                                    text: SSindex > 0 ? widget.ListShow[index].name.substring(0,SSindex) : "",
                                    style: GoogleFonts.lora(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black
                                    ),
                                    children: [
                                      TextSpan(
                                        text: widget.ListShow[index].name.substring(SSindex,SEindex),
                                        style: GoogleFonts.lora(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.orange[300],
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.ListShow[index].name.substring(SEindex,widget.ListShow[index].name.length),
                                        style: GoogleFonts.lora(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black
                                        ),
                                      )
                                    ]
                                )),
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 30,
                    child: Hero(
                      tag: widget.ListShow[index].name,
                      child: Container(
                        height: 160,
                        width: 160,
                        child: FadeInImage(placeholder: NetworkImage("https://s3.scoopwhoop.com/anj/loading/594155876.gif"),//AssetImage('assets/loading.gif') ,
                          image: NetworkImage(widget.ListShow[index].imageUrl),
                          fadeInCurve: Curves.linear,
                          placeholderFit: BoxFit.fitWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orange.shade300,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))
                            ),
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: widget.cardTyp == "cart" ?  Text("\$ ${widget.ListShow[index].Price * widget.ListShow[index].Typ}") :Text("\$ ${widget.ListShow[index].Price.toString()}"),
                          ),
                         if(widget.cardTyp == "cart")   Row(
                            children: [
                              IconButton(onPressed: (){
                                setState((){
                                cartList.removeQty(widget.ListShow[index].name);
                                cartList.total();
                                });
                              },
                                  icon: Icon(Icons.remove,color: Colors.orange,)),
                              Text(widget.ListShow[index].Typ.toString(),style: TextStyle(
                                color: Colors.black,
                                fontSize: 20
                              ),),
                              IconButton(onPressed: (){
                                setState((){
                                  cartList.addQty(widget.ListShow[index].name);
                                  cartList.total();
                                });
                              },
                                  icon: Icon(Icons.add,color: Colors.orange,))
                            ],
                          )

                        ],
                      ))
                ],
              ),
            ),
          );
        } );
  }
}
