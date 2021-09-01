import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/BuyNow.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({Key key}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
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
                  )
                ],
              ),
            ),
            Container(
                height: SizeConfig.screenHeight * 0.3,
                width: SizeConfig.screenWidth,
                child: Carousel(
                  images: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          'assets/icons/book.png',
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          'assets/icons/book.png',
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          'assets/icons/book.png',
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          'assets/icons/book.png',
                        ),
                      ),
                    ),
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
                  "Book Name",
                  style: TextStyle(
                      color: Color(black),
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.blockSizeVertical * 1.65),
                ),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.08,
                  vertical: SizeConfig.blockSizeVertical),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Author :",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF656565)),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        Text(
                          "Edition :",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF656565)),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        Text(
                          "Semester :",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF656565)),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        Text(
                          "Condition :",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF656565)),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        Text(
                          "College :",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF656565)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Author Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Color(black)),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        Text(
                          "Edition Detail",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Color(black)),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        Text(
                          "Semester",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Color(black)),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        Text(
                          "Condition Detail",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Color(black)),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        Text(
                          "College",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Color(black)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description :",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Color(0XFF656565)),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Color(black)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.08,
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
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
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.4,
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
                      onPressed: () {},
                      child: Text(
                        "Buy Now: ₹ 200",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.4,
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
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: Colors.white,
                                child: Container(
                                  width: SizeConfig.screenWidth,
                                  height: SizeConfig.screenHeight * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: SizeConfig.screenWidth,
                                          alignment: Alignment.topRight,
                                          child: ImageIcon(
                                            AssetImage('assets/icons/cross.png'),
                                            color: Color(colorBlue),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 2
                                        ),
                                        child: Image.asset('assets/icons/chat.png',
                                        height: SizeConfig.screenHeight * 0.1,),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical
                                        ),
                                        child: Text("Lorem Ipsum is Simply dummy",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600
                                        ),)
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth,
                                        alignment: Alignment.center,
                                        height: SizeConfig.blockSizeVertical * 5,
                                        margin: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 4
                                        ),
                                        child: Container(
                                          width: SizeConfig.screenWidth * 0.4,
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
                                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return BuyNow();
                                              }));
                                            },
                                            child: Text(
                                              "Buy Now",
                                              style: TextStyle(
                                                  color: Colors.white, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        "Chat",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
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
