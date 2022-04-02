import 'dart:convert';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/UI/Activities/CheckoutScreen.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/common/utility.dart';
import 'package:book_buy_and_sell/model/ClassModel/CartListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:http/http.dart';
import 'package:multi_select_item/multi_select_item.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  MultiSelectController controller = new MultiSelectController();
bool  isError = false;
 bool isLoading = false;
 bool visibility=false;
 var orderid=[];
 var allorderid=[];
 @override
  void initState() {
   getfeaturedmatches();
    // TODO: implement initState
    super.initState();
  }
  String texts="All";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(backgroundColor),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    vertical: SizeConfig.blockSizeVertical * 2),
                child: Row(
                  children: [

                    Container(

                      margin: EdgeInsets.symmetric(

                          vertical: SizeConfig.blockSizeVertical),
                      child: Text(
                        "My Cart",
                        style: TextStyle(
                            color: Color(black),
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 2),
                      ),
                    ),
                    /* Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 5,
                          right: SizeConfig.screenWidth * 0.35),
                      child: Row(
                        children: [
                          Text(
                            "Current Location",
                            style: TextStyle(color: Color(black)),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          ImageIcon(
                            AssetImage('assets/icons/current.png'),
                            color: Color(colorBlue),
                            size: SizeConfig.blockSizeVertical * 3,
                          )
                        ],
                      ),
                    ), */
                    /* */
                  ],
                ),
              ),
              Expanded(

                  child: cartdata==null?
                  getNodDataWidget()
                      :ListView(children: featuredwidegt(),)),
              cartdata==null?Container():Visibility(
                visible: visibility,
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.blockSizeVertical * 7,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                      vertical: SizeConfig.blockSizeVertical * 2),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(gradientColor1),
                        Color(gradientColor2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: MaterialButton(
                    onPressed: () {

if(orderid.isEmpty){
  print(allorderid.toString());
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CheckoutScreen(orderid:allorderid,type: "",)));
}
                     else{
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CheckoutScreen(orderid:orderid,type: "",)));

}    },
                    child: Text(
                      "Buy ${texts}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 2),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              /*  SizedBox(
                height: SizeConfig.screenHeight * 0.15,
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05),
                height: SizeConfig.blockSizeVertical * 7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color.fromRGBO(212, 247, 255, 0.45)),
                child: MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      ImageIcon(
                        AssetImage('assets/icons/offer.png'),
                        color: Color(colorBlue),
                        size: SizeConfig.blockSizeVertical * 4,
                      ),
                      Text(
                        "Get 10% off on 1st Purchase.",
                        style: TextStyle(
                            color: Color(black),
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.blockSizeVertical * 1.65),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      MaterialButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: Colors.white,
                        child: Text(
                          "Apply Now",
                          style: TextStyle(
                              color: Color(colorBlue),
                              fontWeight: FontWeight.w600),
                        ),
                        minWidth: SizeConfig.screenWidth * 0.25,
                        padding: EdgeInsets.zero,
                      )
                    ],
                  ),
                ),
              ),*/
            ],
          ),
        ));
  }

  // Widget _getCartData() {
  //   return FutureBuilder<CartListModel>(
  //
  //       builder: (context, AsyncSnapshot<CartListModel> snapshot) {
  //         if (snapshot.connectionState != ConnectionState.done) {
  //           return Container(
  //             child: Center(
  //               child: CircularProgressIndicator(),
  //             ),
  //           );
  //         } else {
  //           if (snapshot.hasData) {
  //             return Column(
  //               children: [
  //                 Container(
  //                   width: SizeConfig.screenWidth,
  //                   margin: EdgeInsets.symmetric(
  //                       horizontal: SizeConfig.screenWidth * 0.05,
  //                       vertical: SizeConfig.blockSizeVertical),
  //                   child: Text(
  //                     "My Cart",
  //                     style: TextStyle(
  //                         color: Color(black),
  //                         fontWeight: FontWeight.w600,
  //                         fontSize: SizeConfig.blockSizeVertical * 2),
  //                   ),
  //                 ),
  //                 Container(
  //                   width: SizeConfig.screenWidth,
  //                   margin: EdgeInsets.symmetric(
  //                       horizontal: SizeConfig.screenWidth * 0.05,
  //                       vertical: SizeConfig.blockSizeVertical),
  //                   child: ListView.builder(
  //                     itemBuilder: (context, int index) {
  //                       return MultiSelectItem(
  //                         isSelecting: controller.isSelecting,
  //                         onSelected: () {
  //                           setState(() {
  //                             controller.toggle(index);
  //                           });
  //                         },
  //                         child: Stack(
  //                           children: [
  //                             GestureDetector(
  //                               onTap: () {
  //                                 removeCart(
  //                                     context,
  //                                     snapshot.data[index].orderId
  //                                         .toString());
  //                               },
  //                               child: Container(
  //                                 decoration: controller.isSelected(index)
  //                                     ? new BoxDecoration(color: Colors.grey[300])
  //                                     :
  //                                  BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(15),
  //                                     gradient: LinearGradient(
  //                                       colors: [
  //                                         Color(gradientColor1),
  //                                         Color(gradientColor2),
  //                                       ],
  //                                     ),
  //                                     boxShadow: [
  //                                       BoxShadow(
  //                                           color: Colors.grey[200],
  //                                           spreadRadius: 2.0,
  //                                           blurRadius: 5.0),
  //                                     ]),
  //                                 margin: EdgeInsets.only(
  //                                   bottom: SizeConfig.blockSizeVertical,
  //                                 ),
  //                                 width: SizeConfig.screenWidth,
  //                                 height: SizeConfig.screenHeight * 0.13,
  //                                 child: Container(
  //                                   margin: EdgeInsets.only(
  //                                       right:
  //                                       SizeConfig.blockSizeHorizontal * 2),
  //                                   child: RotatedBox(
  //                                     child: Text(
  //                                       "Remove",
  //                                       style: TextStyle(
  //                                           color: Colors.white,
  //                                           fontWeight: FontWeight.w600,
  //                                           fontSize:
  //                                           SizeConfig.blockSizeVertical * 2),
  //                                     ),
  //                                     quarterTurns: 1,
  //                                   ),
  //                                 ),
  //                                 alignment: Alignment.centerRight,
  //                               ),
  //                             ),
  //                             Container(
  //                               width: SizeConfig.screenWidth,
  //                               height: SizeConfig.screenHeight * 0.16,
  //                               margin: EdgeInsets.only(
  //                                   right: SizeConfig.screenWidth * 0.09),
  //                               decoration: controller.isSelected(index)
  //                       ? new BoxDecoration(color: Colors.grey[300])
  //                           : BoxDecoration(
  //                                 color: Colors.white,
  //                                 borderRadius: BorderRadius.circular(15),
  //                               ),
  //                               child: Row(
  //                                 children: [
  //                                   Container(
  //                                     width: SizeConfig.screenWidth * 0.25,
  //                                     decoration: BoxDecoration(
  //                                         borderRadius:
  //                                         BorderRadius.circular(25)),
  //                                     child: ClipRRect(
  //                                       borderRadius: BorderRadius.circular(25),
  //                                       child: Image.network(
  //                                           snapshot.data.image_url +
  //                                               "/" +
  //                                               snapshot.data.date[index].image1),
  //                                     ),
  //                                   ),
  //                                   Container(
  //                                     width: SizeConfig.screenWidth * 0.5,
  //                                     margin: EdgeInsets.only(
  //                                         left: SizeConfig.blockSizeHorizontal),
  //                                     child: Column(
  //                                       mainAxisAlignment:
  //                                       MainAxisAlignment.center,
  //                                       crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                       children: [
  //                                         Row(
  //                                           mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                           children: [
  //                                             Text(
  //                                               snapshot.data.date[index].name,
  //                                               style: TextStyle(
  //                                                   color: Color(black),
  //                                                   fontWeight: FontWeight.w500,
  //                                                   fontSize: SizeConfig
  //                                                       .blockSizeVertical *
  //                                                       2),
  //                                             ),
  //                                             Text(
  //                                               snapshot
  //                                                   .data.date[index].created_at.toString().substring(0,10),
  //                                               style: TextStyle(
  //                                                   color: Color(0XFF656565),
  //                                                   fontWeight: FontWeight.w500,
  //                                                   fontSize: SizeConfig
  //                                                       .blockSizeVertical *
  //                                                       1.25),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         Text(
  //                                           snapshot.data.date[index].auther_name,
  //                                           style: TextStyle(
  //                                               color: Color(0XFF656565),
  //                                               fontWeight: FontWeight.w500,
  //                                               fontSize:
  //                                               SizeConfig.blockSizeVertical *
  //                                                   1.75),
  //                                         ),
  //                                         Text(
  //                                           "Condition: ${snapshot.data.date[index].conditions}",
  //                                           style: TextStyle(
  //                                               color: Color(0XFF656565),
  //                                               fontWeight: FontWeight.w500,
  //                                               fontSize:
  //                                               SizeConfig.blockSizeVertical *
  //                                                   1.75),
  //                                         ),
  //                                         Container(
  //                                           width: SizeConfig.screenWidth * 0.5,
  //                                           height:
  //                                           SizeConfig.blockSizeVertical * 4,
  //                                           alignment: Alignment.centerRight,
  //                                           child: Container(
  //                                             decoration: BoxDecoration(
  //                                               gradient: LinearGradient(
  //                                                 colors: [
  //                                                   Color(gradientColor1),
  //                                                   Color(gradientColor2),
  //                                                 ],
  //                                               ),
  //                                               borderRadius:
  //                                               BorderRadius.circular(15),
  //                                             ),
  //                                             child: MaterialButton(
  //                                               onPressed: () {},
  //                                               child: Text(
  //                                                 "$rs ${snapshot.data.date[index].price}",
  //                                                 style: TextStyle(
  //                                                     color: Colors.white,
  //                                                     fontWeight:
  //                                                     FontWeight.w600),
  //                                               ),
  //                                               shape: RoundedRectangleBorder(
  //                                                 borderRadius:
  //                                                 BorderRadius.circular(15),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               padding: EdgeInsets.all(8),
  //                             ),
  //                           ],
  //                         ),
  //                       );
  //                     },
  //                     primary: false,
  //                     shrinkWrap: true,
  //                     itemCount: snapshot.data.date.length,
  //                   ),
  //                 ),
  //                 Container(
  //                   width: SizeConfig.screenWidth,
  //                   height: SizeConfig.blockSizeVertical * 7,
  //                   margin: EdgeInsets.symmetric(
  //                       horizontal: SizeConfig.screenWidth * 0.05,
  //                       vertical: SizeConfig.blockSizeVertical * 2),
  //                   decoration: BoxDecoration(
  //                     gradient: LinearGradient(
  //                       colors: [
  //                         Color(gradientColor1),
  //                         Color(gradientColor2),
  //                       ],
  //                     ),
  //                     borderRadius: BorderRadius.circular(25),
  //                   ),
  //                   child: MaterialButton(
  //                     onPressed: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => CheckoutScreen()));
  //                     },
  //                     child: Text(
  //                       "Buy All",
  //                       style: TextStyle(
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.w600,
  //                           fontSize: SizeConfig.blockSizeVertical * 2),
  //                     ),
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(15),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             );
  //           } else {
  //             return getNodDataWidget();
  //           }
  //         }
  //       });
  // }
  dynamic cartdata = new List();
  void getfeaturedmatches() async {
    setState(() {
      isLoading = true;
    });


    try {
      final response = await post(
          Uri.parse(
              ApiCall.baseURL+cartListURL),body: (
          {
            "user_id" : "${PreferenceManager.getUserId()}",
            "session_key": PreferenceManager.getSessionKey(),
          }
      ));
print("ffvvvf");
      if (response.statusCode == 256) {
        final responseJson = json.decode(response.body);
print(responseJson);
        setState(() {
          cartdata=responseJson['date'];
          cartdata==null?visibility=false:visibility=true;
          isError = false;

          isLoading = false;
          print('setstate'+cartdata.toString());
          for(int i=0;i<=cartdata.length;i++){
            allorderid.add(cartdata[i]['order_id']);
          }
        });


      } else {

        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }
  // Future<CartListModel> _callCartAPI() async {
  //   Map<String, dynamic> body = {
  //     "user_id": "${PreferenceManager.getUserId()}",
  //     "session_key": PreferenceManager.getSessionKey(),
  //   };
  //
  //   var res = await ApiCall.post(cartListURL, body);
  //   var jsonResponse = json.decode(json.encode(res).toString());
  //
  //   try {
  //     var data = new CartListModel.fromJson(jsonResponse);
  //     return data;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  removeCart(BuildContext context, String orderId) async {
    Utility.showLoading(context);

    var res = await ApiCall.apiCall(cartRemoveURL, {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "order_id": orderId,
    });

    var decode = jsonDecode(res.body);
    if (decode["status"] == "200") {
      getfeaturedmatches();
      Utility.hideLoading(context);

      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Cart()));
    } else {
      CommonSnackBar.snackBar(message: decode["message"]);
    }

    setState(() {});
  }
  List<Widget> featuredwidegt() {
    List<Widget> featuredlist = new List();
    for (int i = 0; i < cartdata.length; i++) {
      featuredlist.add(
          Column(
            children: [

              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight*0.18,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical),
                child:MultiSelectItem(
                  isSelecting: controller.isSelecting,
                  onSelected: () {
                    setState(() {
                      controller.toggle(i);
if(controller.isSelecting==true){
  texts="Selected";
}
else{
  texts="All";
}
                      orderid.add(cartdata[i]['order_id'].toString());
                    });
                  },
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          removeCart(
                              context,
                              cartdata[i]['order_id'].toString());
                        },
                        child: Container(
                          decoration: controller.isSelected(i)
                              ? new BoxDecoration(color: Colors.grey[300])
                              :
                          BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  Color(gradientColor1),
                                  Color(gradientColor2),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200],
                                    spreadRadius: 2.0,
                                    blurRadius: 5.0),
                              ]),

                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 0.18,
                          child: Container(
                            margin: EdgeInsets.only(
                                right:
                                SizeConfig.blockSizeHorizontal * 2),
                            child: RotatedBox(
                              child: Text(
                                "Remove",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                    SizeConfig.blockSizeVertical * 2),
                              ),
                              quarterTurns: 1,
                            ),
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.18,
                        margin: EdgeInsets.only(
                            right: SizeConfig.screenWidth * 0.09),
                        decoration: controller.isSelected(i)
                            ? new BoxDecoration(color: Colors.grey[300])
                            : BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(25)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                    "http://admin.apnistationary.com/img/books" +
                                        "/" +
                                        cartdata[i]['image1']),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.5,
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal*1.5),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:SizeConfig.screenWidth*0.30,
                                        child: Text(
                                          cartdata[i]['name'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(black),
                                              fontWeight: FontWeight.w500,
                                              fontSize: SizeConfig
                                                  .blockSizeVertical *
                                                  2),
                                        ),
                                      ),
                                      Text(
                                        cartdata[i]['created_at'].toString().substring(0,10),
                                        style: TextStyle(
                                            color: Color(0XFF656565),
                                            fontWeight: FontWeight.w500,
                                            fontSize: SizeConfig
                                                .blockSizeVertical *
                                                1.25),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    cartdata[i]['auther_name'],
                                    style: TextStyle(
                                        color: Color(0XFF656565),
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                        SizeConfig.blockSizeVertical *
                                            1.75),
                                  ),
                                  Text(
                                    "Condition: ${cartdata[i]['conditions']}",
                                    style: TextStyle(
                                        color: Color(0XFF656565),
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                        SizeConfig.blockSizeVertical *
                                            1.75),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.7,
                                    height:
                                    SizeConfig.blockSizeVertical * 4,

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(


                                            borderRadius:
                                            BorderRadius.circular(15),
                                            border: Border.all(
                                          color:
                                                  Color(gradientColor1),


                                            )
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => CheckoutScreen(orderid: cartdata[i]['order_id'].toString(),id:cartdata[i]['id'],type: "",)));
                                            },
                                            child: Text(
                                              "Buy Now",
                                              style: TextStyle(
                                                  color: Color(gradientColor1),
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(gradientColor1),
                                                Color(gradientColor2),
                                              ],
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {},
                                            child: Text(
                                              "$rs ${cartdata[i]['price']}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(8),
                      ),
                    ],
                  ),
                )



              ),

            ],
          )
      );}
  return featuredlist;
  }
}

Widget getNodDataWidget() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.remove_shopping_cart_outlined,size: 100,color: Colors.blue.withOpacity(0.6),),
        SizedBox(height: 10,),
        Text("Your Cart is Empty",style: TextStyle(fontSize: 20),),
      ],
    ),
  );
}


