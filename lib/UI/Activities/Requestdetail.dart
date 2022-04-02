import 'dart:convert';

import 'package:book_buy_and_sell/ChatUi/views/chat.dart';
import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/UI/Activities/BuyNow.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/Dialog.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/Utils/helper/helperfunctions.dart';
import 'package:book_buy_and_sell/Utils/services/database.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/ClassModel/BookDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart';

import 'CheckoutScreen.dart';

class RequestDetail extends StatefulWidget {
   String catId;
   String firsname;
   String college_name;

  RequestDetail({this.catId,this.college_name,this.firsname});

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<RequestDetail> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  Stream chatRooms;
  bool isLoading=false;
  @override
  void initState() {
    getUserInfogetChats();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(backgroundColor),
          body:isLoading?
          CircularProgressIndicator()
              :
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: FutureBuilder<BookDataModel>(
              future: _callBookDataAPI(),
              builder: (context, AsyncSnapshot<BookDataModel> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
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
                          ),
                           */
                            ],
                          ),
                        ),
                        Container(
                            height: SizeConfig.screenHeight * 0.3,
                            width: SizeConfig.screenWidth,
                            child: Carousel(
                              images: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(image:snapshot.data.image_url +
                                        "/" +
                                        snapshot.data.date.image1)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(snapshot.data.image_url +
                                          "/" +
                                          snapshot.data.date.image1),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(image:snapshot.data.image_url +
                                        "/" +
                                        snapshot.data.date.image2)));
                                  },
                                  child:
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(snapshot.data.image_url +
                                          "/" +
                                          snapshot.data.date.image2),
                                    ),
                                  ),),  GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(image:snapshot.data.image_url +
                                        "/" +
                                        snapshot.data.date.image3)));
                                  },
                                  child:
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(snapshot.data.image_url +
                                          "/" +
                                          snapshot.data.date.image3),
                                    ),
                                  ),),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(image:snapshot.data.image_url +
                                        "/" +
                                        snapshot.data.date.image4)));
                                  },
                                  child:
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(snapshot.data.image_url +
                                          "/" +
                                          snapshot.data.date.image4),
                                    ),
                                  ),),
                              ],
                              dotColor: Colors.grey,
                              dotIncreasedColor: Color(colorBlue),
                              dotBgColor: Colors.transparent,
                              dotSize: SizeConfig.blockSizeVertical,
                              dotPosition: DotPosition.bottomCenter,
                            )),
                        Container(
                          width: SizeConfig.screenWidth,
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05,
                              vertical: SizeConfig.blockSizeVertical),
                          height: SizeConfig.blockSizeVertical * 5,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color.fromRGBO(212, 247, 255, 0.45)),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              snapshot.data.date.name,
                              style: TextStyle(
                                  color: Color(black),
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.blockSizeVertical * 1.65),
                            ),
                          ),
                        ),
                        // Container(
                        //   width: SizeConfig.screenWidth,
                        //   margin: EdgeInsets.symmetric(
                        //       horizontal: SizeConfig.screenWidth * 0.08,
                        //       vertical: SizeConfig.blockSizeVertical),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Container(
                        //         width: SizeConfig.screenWidth * 0.3,
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               "Author :",
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w500,
                        //                   color: Color(0XFF656565)),
                        //             ),
                        //             SizedBox(
                        //               height: SizeConfig.blockSizeVertical,
                        //             ),
                        //             Text(
                        //               "Edition :",
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w500,
                        //                   color: Color(0XFF656565)),
                        //             ),
                        //             SizedBox(
                        //               height: SizeConfig.blockSizeVertical,
                        //             ),
                        //
                        //             Text(
                        //               "Condition :",
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w500,
                        //                   color: Color(0XFF656565)),
                        //             ),
                        //             SizedBox(
                        //               height: SizeConfig.blockSizeVertical,
                        //             ),
                        //             Text(
                        //               "College :",
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w500,
                        //                   color: Color(0XFF656565)),
                        //             ),
                        //             SizedBox(
                        //               height: SizeConfig.blockSizeVertical*3,
                        //             ),
                        //             Text(
                        //               "Category :",
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w500,
                        //                   color: Color(0XFF656565)),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: SizeConfig.screenWidth * 0.5,
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               snapshot.data.date.auther_name,
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600,
                        //                   color: Color(black)),
                        //             ),
                        //             SizedBox(
                        //               height: SizeConfig.blockSizeVertical,
                        //             ),
                        //             Text(
                        //               snapshot.data.date.edition_detail,
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600,
                        //                   color: Color(black)),
                        //             ),
                        //             SizedBox(
                        //               height: SizeConfig.blockSizeVertical,
                        //             ),
                        //             Text(
                        //               snapshot.data.date.semester,
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600,
                        //                   color: Color(black)),
                        //             ),
                        //             SizedBox(
                        //               height: SizeConfig.blockSizeVertical,
                        //             ),
                        //             Text(
                        //               snapshot.data.date.conditions,
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600,
                        //                   color: Color(black)),
                        //             ),
                        //             SizedBox(
                        //               height: SizeConfig.blockSizeVertical,
                        //             ),
                        //             Text(
                        //               snapshot.data.date.college_name,maxLines: 2,
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600,
                        //                   color: Color(black)),
                        //             ),
                        //             SizedBox(
                        //               height: SizeConfig.blockSizeVertical,
                        //             ),
                        //             Text(
                        //               snapshot.data.date.category_name,
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600,
                        //                   color: Color(black)),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   width: SizeConfig.screenWidth,
                        //   margin: EdgeInsets.symmetric(
                        //       horizontal: SizeConfig.screenWidth * 0.08),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         "Description :",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w500,
                        //             color: Color(0XFF656565)),
                        //       ),
                        //       SizedBox(
                        //         height: SizeConfig.blockSizeVertical,
                        //       ),
                        //       Text(
                        //         snapshot.data.date.description,
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w500, color: Color(black)),
                        //       ),
                        //
                        //     ],
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(

                            children: [
                              Container(
                                  width:SizeConfig.screenWidth*0.24,
                                  child: Text("Author:")),
                              SizedBox(width: SizeConfig.screenWidth*0.10,),
                              Text(snapshot.data.date.auther_name,style: TextStyle(
                                  color: Color(black),
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeVertical * 1.65),),
                            ],
                          ),),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(

                            children: [
                          Container(
                          width:SizeConfig.screenWidth*0.24,
                            child:Text("Edition:")),
                              SizedBox(width: SizeConfig.screenWidth*0.10,),
                              Text(snapshot.data.date.edition_detail,style: TextStyle(
                                  color: Color(black),
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeVertical * 1.65),),
                            ],
                          ),),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(

                            children: [
                          Container(
                          width:SizeConfig.screenWidth*0.24,
                            child:Text("Condition:")),
                              SizedBox(width: SizeConfig.screenWidth*0.10,),
                              Text(snapshot.data.date.conditions,style: TextStyle(
                                  color: Color(black),
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeVertical * 1.65),),
                            ],
                          ),),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(

                            children: [
                          Container(
                          width:SizeConfig.screenWidth*0.24,
                            child: Text("College:")),
                              SizedBox(width: SizeConfig.screenWidth*0.10,),
                              Text(snapshot.data.date.college_name,style: TextStyle(
                                  color: Color(black),
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeVertical * 1.65),),
                            ],
                          ),),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(

                            children: [
                          Container(
                          width:SizeConfig.screenWidth*0.24,
                            child:Text("Category :")),
                              SizedBox(width: SizeConfig.screenWidth*0.10,),
                              Text(snapshot.data.date.category_name,style: TextStyle(
                                  color: Color(black),
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeVertical * 1.65),),
                            ],
                          ),),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.08),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Container(
                          width:SizeConfig.screenWidth*0.24,
                            child:Text(
                                "Description :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFF656565))),
                              ),
                              SizedBox(width: SizeConfig.screenWidth*0.10,),
                              Text(
                                snapshot.data.date.description,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,color: Color(black)),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(

                          children: [
                            Text("Buyer Name:"),
                            SizedBox(width: SizeConfig.screenWidth*0.10,),
                            Text(widget.firsname,style: TextStyle(
                                color: Color(black),
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.blockSizeVertical * 1.65),),
                          ],
                        ),),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Buyer College Name:"),
                              SizedBox(width: SizeConfig.screenWidth*0.10,),
                              Text(widget.college_name,maxLines: 2,style: TextStyle(
                                  color: Color(black),
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeVertical * 1.65),),
                            ],
                          ),),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.04,
                        ),

                        // Container(
                        //   width: SizeConfig.screenWidth,
                        //   margin: EdgeInsets.symmetric(
                        //       horizontal: SizeConfig.screenWidth * 0.03,
                        //       vertical: SizeConfig.blockSizeVertical),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Container(
                        //         width: SizeConfig.screenWidth*0.30,
                        //         decoration: BoxDecoration(
                        //           gradient: LinearGradient(
                        //             colors: [
                        //               Color(gradientColor1),
                        //               Color(gradientColor2),
                        //             ],
                        //           ),
                        //           borderRadius: BorderRadius.circular(25),
                        //         ),
                        //         child: MaterialButton(
                        //           onPressed: () {
                        //             print(snapshot.data.date.user_id);
                        //
                        //             if(
                        //             snapshot.data.date.user_id==PreferenceManager.getUserId()
                        //             ){
                        //               //showAlert(context, "You Are a book owner");
                        //             }
                        //             else{
                        //               print(snapshot.data.date.user_firebase_id);
                        //               Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (context) => CheckoutScreen(id:widget.catId,type:'Buy',price:snapshot.data.date.price,firebaseid:snapshot.data.date.user_firebase_id)));
                        //
                        //             }
                        //             // _callAddToCartAPI("buy");
                        //           },
                        //           child: Text(
                        //             "Buy Now: $rs${snapshot.data.date.price}",
                        //             style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.w600),
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(width: 10,),
                        //
                        //       Container(
                        //         width: SizeConfig.screenWidth*0.30,
                        //         decoration: BoxDecoration(
                        //           gradient: LinearGradient(
                        //             colors: [
                        //               Color(gradientColor1),
                        //               Color(gradientColor2),
                        //             ],
                        //           ),
                        //           borderRadius: BorderRadius.circular(25),
                        //         ),
                        //         child: MaterialButton(
                        //           onPressed: () {
                        //            // _callAddToCartAPI("cart");
                        //           },
                        //           child: Text(
                        //             "Add to cart",
                        //             style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.w600),
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(width: 10,),
                        //
                        //       GestureDetector(
                        //         onTap: (){
                        //           //_callAddToCartAPI("cart");
                        //         },
                        //         child: Container(
                        //           width: SizeConfig.screenWidth * 0.25,
                        //           decoration: BoxDecoration(
                        //             gradient: LinearGradient(
                        //               colors: [
                        //                 Color(gradientColor1),
                        //                 Color(gradientColor2),
                        //               ],
                        //             ),
                        //             borderRadius: BorderRadius.circular(25),
                        //           ),
                        //           child: MaterialButton(
                        //             onPressed: () {
                        //               print(snapshot.data.date.user_name);
                        //               //sendMessage(snapshot.data.date.user_name);
                        //              // Chatstart(snapshot.data.date.user_name,snapshot.data.date.user_firebase_id);
                        //               // showAlert(context,"Lorem Ipsum Dolor sir amet");
                        //
                        //             },
                        //             child: Text(
                        //               "Chat",
                        //               style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontWeight: FontWeight.w600),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       /*Container(
                        //     width: SizeConfig.screenWidth * 0.4,
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         colors: [
                        //           Color(gradientColor1),
                        //           Color(gradientColor2),
                        //         ],
                        //       ),
                        //       borderRadius: BorderRadius.circular(25),
                        //     ),
                        //     child: MaterialButton(
                        //       onPressed: () {},
                        //       child: Text(
                        //         "Buy Now: $rs ${snapshot.data.date.price}",
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //     ),
                        //   ),
                        //   Container(
                        //     width: SizeConfig.screenWidth * 0.4,
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         colors: [
                        //           Color(gradientColor1),
                        //           Color(gradientColor2),
                        //         ],
                        //       ),
                        //       borderRadius: BorderRadius.circular(25),
                        //     ),
                        //     child: MaterialButton(
                        //       onPressed: () {
                        //         showDialog(
                        //             context: context,
                        //             builder: (BuildContext context) {
                        //               return Dialog(
                        //                 shape: RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.circular(15),
                        //                 ),
                        //                 backgroundColor: Colors.white,
                        //                 child: Container(
                        //                   width: SizeConfig.screenWidth,
                        //                   height: SizeConfig.screenHeight * 0.3,
                        //                   decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     borderRadius:
                        //                         BorderRadius.circular(15),
                        //                   ),
                        //                   padding: EdgeInsets.all(8),
                        //                   child: Column(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.start,
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: [
                        //                       InkWell(
                        //                         onTap: () {
                        //                           Navigator.pop(context);
                        //                         },
                        //                         child: Container(
                        //                           width: SizeConfig.screenWidth,
                        //                           alignment: Alignment.topRight,
                        //                           child: ImageIcon(
                        //                             AssetImage(
                        //                                 'assets/icons/cross.png'),
                        //                             color: Color(colorBlue),
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       Container(
                        //                         width: SizeConfig.screenWidth,
                        //                         alignment: Alignment.center,
                        //                         margin: EdgeInsets.only(
                        //                             top: SizeConfig
                        //                                     .blockSizeVertical *
                        //                                 2),
                        //                         child: Image.asset(
                        //                           'assets/icons/chat.png',
                        //                           height:
                        //                               SizeConfig.screenHeight *
                        //                                   0.1,
                        //                         ),
                        //                       ),
                        //                       Container(
                        //                           width: SizeConfig.screenWidth,
                        //                           alignment: Alignment.center,
                        //                           margin: EdgeInsets.only(
                        //                               top: SizeConfig
                        //                                   .blockSizeVertical),
                        //                           child: Text(
                        //                             "Lorem Ipsum is Simply dummy",
                        //                             style: TextStyle(
                        //                                 fontWeight:
                        //                                     FontWeight.w600),
                        //                           )),
                        //                       Container(
                        //                         width: SizeConfig.screenWidth,
                        //                         alignment: Alignment.center,
                        //                         height:
                        //                             SizeConfig.blockSizeVertical *
                        //                                 5,
                        //                         margin: EdgeInsets.only(
                        //                             top: SizeConfig
                        //                                     .blockSizeVertical *
                        //                                 4),
                        //                         child: Container(
                        //                           width: SizeConfig.screenWidth *
                        //                               0.4,
                        //                           decoration: BoxDecoration(
                        //                             gradient: LinearGradient(
                        //                               colors: [
                        //                                 Color(gradientColor1),
                        //                                 Color(gradientColor2),
                        //                               ],
                        //                             ),
                        //                             borderRadius:
                        //                                 BorderRadius.circular(25),
                        //                           ),
                        //                           child: MaterialButton(
                        //                             onPressed: () {
                        //                               Navigator.push(context,
                        //                                   MaterialPageRoute(
                        //                                       builder: (context) {
                        //                                 return BuyNow();
                        //                               }));
                        //                             },
                        //                             child: Text(
                        //                               "Buy Now",
                        //                               style: TextStyle(
                        //                                   color: Colors.white,
                        //                                   fontWeight:
                        //                                       FontWeight.w600),
                        //                             ),
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               );
                        //             });
                        //       },
                        //       child: Text(
                        //         "Add to Cart",
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //     ),
                        //   ), */
                        //     ],
                        //   ),
                        // ),

                      ],
                    ),
                  );
                }
                else {
                  return Container();
                }
              },
            ),
          ),
        ));
  }



  Future<BookDataModel> _callBookDataAPI() async {
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "id": widget.catId,
    };

    var res = await ApiCall.post(bookDetailURL, body);
    var jsonResponse = json.decode(json.encode(res).toString());
    var data = new BookDataModel.fromJson(jsonResponse);

    return data;
  }
  sendMessage(String userName,firebase){
    print(Constants.myName);
    List<String> users = [Constants.myName,userName];

    String chatRoomId = getChatRoomId(Constants.myName,userName);
    print("chatRoomid"+chatRoomId);
    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Chat(
            chatRoomId: chatRoomId,
            catId:widget.catId,
            firebaseid:firebase
        )
    ));

  }
  getUserInfogetChats() async {
    setState(() {
      isLoading=true;
    });
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(()  {
        chatRooms = snapshots;

        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
      //print("snapshots"+snapshots);
    });
    setState(() {
      isLoading=false;
    });
  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }


}



class DetailScreen extends StatefulWidget {
  var image;
  DetailScreen({this.image});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [ GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
              margin: EdgeInsets.only(right: 10,top: 20),
              child: CircleAvatar(backgroundColor:Color(colorBlue),child: Icon(Icons.close,color: Colors.white,))),
        )],),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
                widget.image
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

}