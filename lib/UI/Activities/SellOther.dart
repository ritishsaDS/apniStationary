import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:flutter/material.dart';

class SellOther extends StatefulWidget {
  const SellOther({Key key}) : super(key: key);

  @override
  _SellOtherState createState() => _SellOtherState();
}

class _SellOtherState extends State<SellOther> {

  TextEditingController other = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController desc = TextEditingController();

  FocusNode otherFn = FocusNode();
  FocusNode itemNameFn = FocusNode();
  FocusNode descFn = FocusNode();

  GlobalKey<FormState> otherForm = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    otherFn = FocusNode();
    itemNameFn = FocusNode();
    descFn = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otherFn.dispose();
    itemNameFn.dispose();
    descFn.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Color(backgroundColor),
      body: SingleChildScrollView(
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
                  Container(
                    margin: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 5,
                    ),
                    child: Row(
                      children: [
                        Text(
                          Constants.userlocation,
                          style: TextStyle(color: Color(black)),
                        ),
                        // SizedBox(
                        //   width: SizeConfig.blockSizeHorizontal * 2,
                        // ),
                        // ImageIcon(
                        //   AssetImage('assets/icons/current.png'),
                        //   color: Color(colorBlue),
                        //   size: SizeConfig.blockSizeVertical * 3,
                        // )
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),

                ],
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical,
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:  BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[200],
                      blurRadius: 4.0,
                      spreadRadius: 1.0
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.4,
                        height: SizeConfig.screenHeight * 0.15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  spreadRadius: 1.0,
                                  blurRadius: 2.0
                              ),
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle,color: Color(colorBlue),size: SizeConfig.blockSizeVertical * 6,),
                            Text("Add Book Pic")
                          ],
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.4,
                        height: SizeConfig.screenHeight * 0.15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  spreadRadius: 1.0,
                                  blurRadius: 2.0
                              ),
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle,color: Color(colorBlue),size: SizeConfig.blockSizeVertical * 6,),
                            Text("Add Book Pic")
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.4,
                        height: SizeConfig.screenHeight * 0.15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  spreadRadius: 1.0,
                                  blurRadius: 2.0
                              ),
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle,color: Color(colorBlue),size: SizeConfig.blockSizeVertical * 6,),
                            Text("Add Book Pic")
                          ],
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.4,
                        height: SizeConfig.screenHeight * 0.15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  spreadRadius: 1.0,
                                  blurRadius: 2.0
                              ),
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle,color: Color(colorBlue),size: SizeConfig.blockSizeVertical * 6,),
                            Text("Add Book Pic")
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Form(
              key: otherForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              spreadRadius: 2.0,
                              blurRadius: 4.0
                          ),
                        ]
                    ),
                    child: TextFormField(
                      controller: other,
                      focusNode: otherFn,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        otherFn.unfocus();
                        FocusScope.of(context).requestFocus(itemNameFn);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "Other",
                        hintStyle: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              spreadRadius: 2.0,
                              blurRadius: 4.0
                          ),
                        ]
                    ),
                    child: TextFormField(
                      controller: itemName,
                      focusNode: itemNameFn,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        itemNameFn.unfocus();
                        FocusScope.of(context).requestFocus(descFn);
                      },
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 1.5,
                              horizontal: SizeConfig.blockSizeHorizontal * 5),
                          hintText: "Item Name",
                          hintStyle: TextStyle(
                            color: Color(hintGrey),
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              spreadRadius: 2.0,
                              blurRadius: 4.0
                          ),
                        ]
                    ),
                    child: TextFormField(
                      controller: desc,
                      focusNode: descFn,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        descFn.unfocus();
                      },
                      maxLength: 50,
                      maxLines: 3,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "Description",
                        hintStyle: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.4,
                          height: SizeConfig.blockSizeVertical * 5,
                          margin: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                              top: SizeConfig.blockSizeVertical * 3,
                              bottom: SizeConfig.blockSizeVertical),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(colorBlue),
                              ),
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white
                          ),
                          child: MaterialButton(
                            onPressed: () {
                            },
                            child: Text(
                              "Price",
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                        ),
                        Container(
                          width: SizeConfig.screenWidth * 0.4,
                          height: SizeConfig.blockSizeVertical * 5,
                          margin: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                              top: SizeConfig.blockSizeVertical * 3,
                              bottom: SizeConfig.blockSizeVertical),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(gradientColor1),
                                Color(gradientColor2).withOpacity(0.95),
                              ],
                              begin: Alignment(1.0, -3.0),
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                            },
                            child: Text(
                              "Sell Now",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
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
      ),
    ));
  }
}
