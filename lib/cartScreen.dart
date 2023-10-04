import 'package:flutter/material.dart';
import 'package:furniture/cartController.dart';
import 'package:furniture/listCard.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class cartScreen extends StatefulWidget {
  cartScreen({Key? key}) : super(key: key);

  @override
  State<cartScreen> createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> with SingleTickerProviderStateMixin{
  final cartdata = Get.find<cartData>();

  late Animation<Offset> _animation;

  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartdata.totalA = 0.obs;
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 500))..forward();
    _animation = Tween<Offset>(begin: Offset(0.0,2.0),end: Offset(0.0,0.0)).animate(CurvedAnimation(parent: _controller,
        curve: Curves.elasticInOut));
    cartdata.total();
  }

  @override
  Widget build(BuildContext context) {
    final cartList = cartdata.items;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          SafeArea(
              child: Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                child: Row(
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                  },
                      icon: Icon(Icons.arrow_back_rounded,size: 30,color: Colors.white,),
                  ),
                 SizedBox(width: 20,),
                 Text("CART",
                 style: GoogleFonts.lora(
                 fontSize: 20,
                     fontWeight: FontWeight.w600,
                   color: Colors.white
                  ),),
                ],
              ),
              ) ),
          Expanded(child:
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
                  color: Colors.white,
                ),
              ),
              Container(
                 padding: EdgeInsets.only(left: 20,right: 20),
                  child: GestureDetector(
                    onTap: (){
                      setState((){});
                    },
                      child: listCard(searchText: '',ListShow: cartList,animation: _animation,cardTyp: "cart",))
              ),

              Positioned(
                  bottom: 30,
                 // right: 30,
                  child: Container(
                    //height: 20,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.amber,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColor,
                            blurRadius: 3
                          )
                        ]
                      ),
                      child: Row(
                        children: [
                          Text("Total  ",
                            style: GoogleFonts.lora(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),),
                          SizedBox(width: 4,),
                          Obx(() {
                            cartdata.total();
                                return Text(
                                  "\$ ${cartdata.totalA.toDouble()}",
                                  style: GoogleFonts.lora(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600),
                                );
                              }),
                          Spacer(),
                          Icon(Icons.price_change_outlined,color: Colors.white,),
                          SizedBox(width: 4,),
                          Text("Buy Now",
                            style: GoogleFonts.lora(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),),
                        ],
                      ),
                    ),
                    //color: Colors.amber,
                  ))
            ],
          ))
        ],
      ),
    );
  }
}
