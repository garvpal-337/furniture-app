import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:furniture/cartController.dart';
import 'package:furniture/cartScreen.dart';
import 'package:furniture/itemController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class detailScreen extends StatefulWidget {
  detailScreen({
    required this.itemList,
    Key? key}) : super(key: key);
   Furniture itemList;

  @override
  State<detailScreen> createState() => _detailScreenState();
}

class _detailScreenState extends State<detailScreen> {

  List<Color> availableColors = [
    Colors.grey,
    Colors.red,
    Colors.indigo
  ];
  final cartdata = Get.find<cartData>();
  bool available = false;

  var selectedcolor = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.96),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
              ),
              child: SafeArea(
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back_rounded,size: 30,),
                        ),
                        Text("BACK",
                        style: GoogleFonts.lora(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                        ),),
                        Spacer(),
                        IconButton(
                          onPressed: (){
                            Get.to(cartScreen());
                          },
                          icon: Icon(Icons.shopping_bag_outlined,size: 30,),
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28,vertical: 10),
                        child: Stack(
                          children: [
                            Hero(
                              tag: widget.itemList.name,
                              child: Container(
                                height: size.height * 0.4,

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                 // border: Border.all(color: Colors.grey.shade300)
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                               height: size.height * 0.4,
                             // padding: EdgeInsets.all(25),
                              child: FadeInImage(
                                placeholder: AssetImage("assets/loading.gif"),
                                image: NetworkImage(widget.itemList.imageUrl),
                              ),
                            ),
                          ],
                        ),
                    ),
                     Container(
                       height: 25,
                       width: 80,
                       //color: Colors.black26,
                       margin: EdgeInsets.only(top: 10),
                       alignment: Alignment.center,
                       child: ListView.builder(
                           itemCount: 3,
                           scrollDirection: Axis.horizontal,

                           itemBuilder: (ctx,index){
                         return GestureDetector(
                           onTap: (){
                             setState((){
                               selectedcolor = index;
                             });
                           },
                           child: Container(
                             height: 15,
                             width: 15,
                             //color: Colors.black,
                             margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                             decoration: BoxDecoration(
                               color: availableColors[index],
                               shape: BoxShape.circle,
                              // border: Border.all(color: Colors.black,width: 3)
                               boxShadow: [
                                 BoxShadow(
                                   color: selectedcolor == index ? Colors.black : Colors.white,
                                   blurRadius: 5
                                 )
                               ]
                             ),
                           ),
                         );
                       }),
                     ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 28,vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1,vertical: 5),
                          child : FittedBox(
                            child: Text(widget.itemList.name,
                            style: GoogleFonts.lora(
                              fontSize: 25,
                              fontWeight: FontWeight.w600
                            ),),
                          )
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5),
                              child : Text("\$ ${widget.itemList.Price}",
                                style: GoogleFonts.lora(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor
                                ),)
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 1),
                              child : Text(widget.itemList.desciption,
                                style: GoogleFonts.lora(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54
                                ),)
                          )
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
            //SizedBox(height: 50,),
            Spacer(),

            Container(
            height: 60,
              margin: EdgeInsets.only(bottom: 15,left: 28,right: 28),
              //padding: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 6,
                shadowColor: Colors.black,
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.chat_bubble,color: Colors.white,),
                      SizedBox(width: 4,),
                      Text("Chat",
                      style: GoogleFonts.lora(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),),
                      Spacer(),
                      SizedBox(width: 4,),
                      GestureDetector(
                        onTap: (){
                          print("open this");
                          print(available);
                          available ?  Get.to(cartScreen()):cartdata.addItem(
                            Furniture(
                                Typ: 1,
                                name: widget.itemList.name,
                                desciption: widget.itemList.desciption,
                                imageUrl: widget.itemList.imageUrl,
                                Price: widget.itemList.Price),
                          );
                          setState((){
                            available = true;
                          });
                        },
                        child: Row(
                          children: [
                             Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                            SizedBox(width: 5,),
                            Text(available ? "Open Cart" : "Add to Cart",
                              style: GoogleFonts.lora(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                              ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),

          ],
        ),
      )
    );
  }
}
