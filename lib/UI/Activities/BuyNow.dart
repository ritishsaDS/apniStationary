import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class BuyNow extends StatefulWidget {
  const BuyNow({Key key}) : super(key: key);

  @override
  _BuyNowState createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {

  bool applied = false;
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
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.15,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        colors: [Color(gradientColor1), Color(gradientColor2)])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Wallet Money",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical,
                    ),
                    Text(
                      "₹ 500",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeVertical * 2.5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          height: SizeConfig.blockSizeVertical * 4,
                          minWidth: SizeConfig.screenWidth * 0.4,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Text("Top Up"),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          height: SizeConfig.blockSizeVertical * 4,
                          minWidth: SizeConfig.screenWidth * 0.4,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Text("Pay Now: Price"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical),
                child: Text(
                  "Saved Card",
                  style: TextStyle(
                      color: Color(black),
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.blockSizeVertical * 2),
                ),
              ),
              ListView.builder(
                itemBuilder: (context, int index) {
                  return Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05,
                        vertical: SizeConfig.blockSizeVertical),
                    padding: EdgeInsets.all(8),
                    height: SizeConfig.screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          spreadRadius: 2.0,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset('assets/icons/axis.png'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Axis Bank",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.screenWidth * 0.25),
                                    width: SizeConfig.screenWidth * 0.15,
                                    child: Image.asset(
                                        'assets/icons/mastercard.png'),
                                  ),
                                ],
                              ),
                              Text(
                                "**** **** **** 0230",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Debit Card",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: SizeConfig.blockSizeVertical * 1.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                primary: false,
                itemCount: 2,
                shrinkWrap: true,
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical),
                child: Text(
                  "Other Options",
                  style: TextStyle(
                      color: Color(black),
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.blockSizeVertical * 2),
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200],
                      spreadRadius: 2.0,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/debit.png',
                            width: SizeConfig.screenWidth * 0.2,),
                          Text("Debit / Credit Card",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.blockSizeVertical * 1.5

                            ),)
                        ],
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/net banking.png',
                            width: SizeConfig.screenWidth * 0.2,),
                          Text("Net Banking",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.blockSizeVertical * 1.5

                            ),)
                        ],
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/upi.png',
                              width: SizeConfig.screenWidth * 0.2,
                              height: SizeConfig.screenHeight * 0.1),
                          Text("UPI Payments",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.blockSizeVertical * 1.5

                            ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical
                ),
                height: SizeConfig.blockSizeVertical * 7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color.fromRGBO(212,247,255,0.45)
                ),
                child: Row(
                  children: [
                    ImageIcon(AssetImage('assets/icons/offer.png'),color: Color(colorBlue),size: SizeConfig.blockSizeVertical * 4,),
                    Text("Get 10% off on 1st Purchase.",
                      style: TextStyle(
                          color: Color(black),
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.blockSizeVertical * 1.65
                      ),),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    MaterialButton(onPressed: (){
                      if(applied == false)
                      setState(() {
                        applied = true;
                      });
                      else
                        setState(() {
                          applied = false;
                        });
                    },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                      ),
                      color: Colors.white,
                      child: Text(applied==false?"Apply Now":"Applied",
                        style: TextStyle(
                            color: Color(colorBlue),
                            fontWeight: FontWeight.w600
                        ),),
                      minWidth: SizeConfig.screenWidth * 0.25,
                      padding: EdgeInsets.zero,)
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical
                ),
                height: SizeConfig.blockSizeVertical * 7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      colors: [
                        Color(gradientColor1),
                        Color(gradientColor2),
                      ]
                    ),
                ),
                child: MaterialButton(onPressed: (){
                },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Text("Total : ₹ 500",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.blockSizeVertical * 2
                    ),),
                  padding: EdgeInsets.zero,),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
