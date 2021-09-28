import 'dart:convert';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/ClassModel/BuyerOrderModel.dart';
import 'package:flutter/material.dart';

import '../Buylist.dart';
import '../Sellerlist.dart';

class Orders extends StatefulWidget {
  const Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(backgroundColor),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
             margin: EdgeInsets.symmetric(
                 horizontal: SizeConfig.screenWidth * 0.02,
                 vertical: SizeConfig.blockSizeVertical * 2),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ImageIcon(
                    AssetImage('assets/icons/back.png'),
                    color: Color(colorBlue),
                    size: SizeConfig.blockSizeVertical * 4,
                  ),
                ),
                /*  Container(
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
                ),
                ImageIcon(
                  AssetImage('assets/icons/notification.png'),
                  color: Color(colorBlue),
                  size: SizeConfig.blockSizeVertical * 4,
                ) */
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(

              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: Color(colorBlue),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: 'Buy Order',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Sell Order',
                ),
              ],
            ),
          ),

         Expanded(child: TabBarView(controller: _tabController,children: [buylist(),Sellerlist()])),


          /* Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Color(colorBlue))),
            child: Row(
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.8,
                  child: TextFormField(
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "Search an item",
                        hintStyle: TextStyle(
                          color: Color(0XFF787878),
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Icon(
                  Icons.search,
                  color: Color(colorBlue),
                ),
              ],
            ),
          ),
          Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical),
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Orders",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Color(black)),
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.12,
                      height: SizeConfig.blockSizeVertical * 0.2,
                      decoration: BoxDecoration(color: Color(colorBlue)),
                    ),
                  ],
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.4,
                  height: SizeConfig.blockSizeVertical * 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Color(colorBlue),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width:SizeConfig.screenWidth * 0.25,
                        height: SizeConfig.blockSizeVertical * 4,
                        alignment: Alignment.center,
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Latest Orders",
                              hintStyle: TextStyle(
                                color: Color(hintGrey),
                                fontSize: SizeConfig.blockSizeVertical * 1.25,
                              ),
                              contentPadding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2.5)
                          ),
                          textAlign: TextAlign.center,
                          readOnly: true,
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.1,
                        height: SizeConfig.blockSizeVertical * 4,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                topRight: Radius.circular(25)
                            ),
                            color: Color(colorBlue)
                        ),
                        child: Icon(Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: SizeConfig.blockSizeVertical * 3,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),*/
        ],
      ),
    ));
  }

  // Widget _getBuyerOrdersList() {
  //   return FutureBuilder<BookOrderModel>(
  //     future: _callBuyerAPI(),
  //       builder: (context, AsyncSnapshot<BookOrderModel> snapshot) {
  //     if (snapshot.hasData) {
  //       return Container(
  //         width: SizeConfig.screenWidth,
  //         margin: EdgeInsets.symmetric(
  //             horizontal: SizeConfig.screenWidth * 0.05,
  //             vertical: SizeConfig.blockSizeVertical),
  //         child: ListView.builder(
  //           itemBuilder: (context, int index) {
  //             return InkWell(
  //               onTap: () {
  //                 Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                   return BookDetail("");
  //                 }));
  //               },
  //               child: Container(
  //                 width: SizeConfig.screenWidth,
  //                 margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical),
  //                 padding: EdgeInsets.all(8),
  //                 decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(15),
  //                     boxShadow: [
  //                       BoxShadow(
  //                           color: Colors.grey[200],
  //                           spreadRadius: 3.0,
  //                           blurRadius: 2.0),
  //                     ]),
  //                 child: Row(
  //                   children: [
  //                     Container(
  //                       width: SizeConfig.screenWidth * 0.2,
  //                       height: SizeConfig.screenHeight * 0.15,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(15),
  //                       ),
  //                       child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(15),
  //                         child: Image.network(snapshot.data.image_url +
  //                             "/" +
  //                             snapshot.data.date[index].book_image),
  //                       ),
  //                     ),
  //                     Container(
  //                       margin: EdgeInsets.only(
  //                           left: SizeConfig.blockSizeHorizontal * 4),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             snapshot.data.date[index].book_name,
  //                             style: TextStyle(
  //                                 color: Color(0XFF06070D),
  //                                 fontWeight: FontWeight.w600),
  //                           ),
  //                           SizedBox(height: 10,),
  //                           Text(
  //                             "$rs ${snapshot.data.date[index].pay_amount}",
  //                             style: TextStyle(
  //                                 color: Color(colorBlue),
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                           SizedBox(
  //                             height: SizeConfig.blockSizeVertical,
  //                           ),
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 width: SizeConfig.screenWidth * 0.2,
  //                                 child: Column(
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Text(
  //                                       "Status :",
  //                                       style: TextStyle(
  //                                           fontWeight: FontWeight.w500,
  //                                           color: Color(0XFF656565),
  //                                           fontSize:
  //                                               SizeConfig.blockSizeVertical *
  //                                                   1.5),
  //                                     ),
  //
  //                                   ],
  //                                 ),
  //                               ),
  //                               Container(
  //                                 width: SizeConfig.screenWidth * 0.3,
  //                                 child: Column(
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Text(
  //                                       snapshot.data.date[index].order_status,
  //                                       style: TextStyle(
  //                                           fontWeight: FontWeight.w600,
  //                                           color: Color(0XFF656565),
  //                                           fontSize:
  //                                               SizeConfig.blockSizeVertical *
  //                                                   1.5),
  //                                     ),
  //
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                          /* Container(
  //                             width: SizeConfig.screenWidth * 0.6,
  //                             alignment: Alignment.centerRight,
  //                             child: Text(
  //                               "More Info",
  //                               style: TextStyle(
  //                                   color: Color(colorBlue),
  //                                   fontWeight: FontWeight.w500,
  //                                   fontSize:
  //                                       SizeConfig.blockSizeVertical * 1.35),
  //                             ),
  //                           ),*/
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //           shrinkWrap: true,
  //           itemCount: snapshot.data.date.length,
  //           primary: false,
  //         ),
  //       );
  //     } else {
  //       return getNotDataWidget(
  //
  //       );
  //     }
  //   });
  // }
  //
  // Widget _getSellerOrdersList() {
  //   return FutureBuilder<BookOrderModel>(
  //       future: _callSellerAPI(),
  //       builder: (context, AsyncSnapshot<BookOrderModel> snapshot) {
  //         if (snapshot.hasData) {
  //           return Container(
  //             width: SizeConfig.screenWidth,
  //             margin: EdgeInsets.symmetric(
  //                 horizontal: SizeConfig.screenWidth * 0.05,
  //                 vertical: SizeConfig.blockSizeVertical),
  //             child: ListView.builder(
  //               itemBuilder: (context, int index) {
  //                 return InkWell(
  //                   onTap: () {
  //                     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                       return BookDetail("");
  //                     }));
  //                   },
  //                   child: Container(
  //                     width: SizeConfig.screenWidth,
  //                     margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical),
  //                     padding: EdgeInsets.all(8),
  //                     decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(15),
  //                         boxShadow: [
  //                           BoxShadow(
  //                               color: Colors.grey[200],
  //                               spreadRadius: 3.0,
  //                               blurRadius: 2.0),
  //                         ]),
  //                     child: Row(
  //                       children: [
  //                         Container(
  //                           width: SizeConfig.screenWidth * 0.2,
  //                           height: SizeConfig.screenHeight * 0.15,
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(15),
  //                           ),
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(15),
  //                             child: Image.network(snapshot.data.image_url +
  //                                 "/" +
  //                                 snapshot.data.date[index].book_image),
  //                           ),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(
  //                               left: SizeConfig.blockSizeHorizontal * 4),
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 snapshot.data.date[index].book_name,
  //                                 style: TextStyle(
  //                                     color: Color(0XFF06070D),
  //                                     fontWeight: FontWeight.w600),
  //                               ),
  //                               SizedBox(height: 10,),
  //                               Text(
  //                                 "$rs ${snapshot.data.date[index].pay_amount}",
  //                                 style: TextStyle(
  //                                     color: Color(colorBlue),
  //                                     fontWeight: FontWeight.bold),
  //                               ),
  //                               SizedBox(
  //                                 height: SizeConfig.blockSizeVertical,
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   Container(
  //                                     width: SizeConfig.screenWidth * 0.2,
  //                                     child: Column(
  //                                       mainAxisAlignment: MainAxisAlignment.start,
  //                                       crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                       children: [
  //                                         Text(
  //                                           "Status :",
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.w500,
  //                                               color: Color(0XFF656565),
  //                                               fontSize:
  //                                               SizeConfig.blockSizeVertical *
  //                                                   1.5),
  //                                         ),
  //
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Container(
  //                                     width: SizeConfig.screenWidth * 0.3,
  //                                     child: Column(
  //                                       mainAxisAlignment: MainAxisAlignment.start,
  //                                       crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                       children: [
  //                                         Text(
  //                                           snapshot.data.date[index].order_status,
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.w600,
  //                                               color: Color(0XFF656565),
  //                                               fontSize:
  //                                               SizeConfig.blockSizeVertical *
  //                                                   1.5),
  //                                         ),
  //
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               /* Container(
  //                             width: SizeConfig.screenWidth * 0.6,
  //                             alignment: Alignment.centerRight,
  //                             child: Text(
  //                               "More Info",
  //                               style: TextStyle(
  //                                   color: Color(colorBlue),
  //                                   fontWeight: FontWeight.w500,
  //                                   fontSize:
  //                                       SizeConfig.blockSizeVertical * 1.35),
  //                             ),
  //                           ),*/
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               },
  //               shrinkWrap: true,
  //               itemCount: snapshot.data.date.length,
  //               primary: false,
  //             ),
  //           );
  //         } else {
  //           return getNotDataWidget(
  //
  //           );
  //         }
  //       });
  // }
  // Widget getNotDataWidget() {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Icon(Icons.info_outline,size: 100,color: Colors.blue.withOpacity(0.6),),
  //         SizedBox(height: 10,),
  //         Text("No Data Found",style: TextStyle(fontSize: 20),),
  //       ],
  //     ),
  //   );
  // }
  // Future<BookOrderModel> _callBuyerAPI() async {
  //   Map<String, dynamic> body = {
  //     "user_id": "${PreferenceManager.getUserId()}",
  //     "session_key": PreferenceManager.getSessionKey(),
  //   };
  //
  //   var res = await ApiCall.post(buyerOrderListURL, body);
  //   var jsonResponse = json.decode(json.encode(res).toString());
  //
  //   try {
  //     var data = new BookOrderModel.fromJson(jsonResponse);
  //     return data;
  //   } catch (e) {
  //     return null;
  //   }
  // }
  //
  // Future<BookOrderModel> _callSellerAPI() async {
  //   Map<String, dynamic> body = {
  //     "user_id": "${PreferenceManager.getUserId()}",
  //     "session_key": PreferenceManager.getSessionKey(),
  //   };
  //
  //   var res = await ApiCall.post(sellerOrderListURL, body);
  //   var jsonResponse = json.decode(json.encode(res).toString());
  //
  //   try {
  //     var data = new BookOrderModel.fromJson(jsonResponse);
  //     return data;
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
