import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/WalletTrans.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_place/google_place.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'MainScreen.dart';

class Wallet extends StatefulWidget {
  var amount;
   Wallet({this.amount}) ;

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  TextEditingController moneycontroller=TextEditingController();
  bool isLoading = false;
  bool isError = false;

  Razorpay _razorpay;
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }
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
              height: SizeConfig.screenHeight * 0.25,
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
                    "₹ ${widget.amount}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeVertical * 2.5),
                  ),
                  MaterialButton(
                    onPressed: () {
if(int.parse(moneycontroller.text)<=0){
print("pemkoo");
CommonSnackBar.snackBar(
    message: "Please Enter Valid Amount ");
}
                      else{
  openwallet();
}
                    },
                    height: SizeConfig.blockSizeVertical * 4,
                    minWidth: SizeConfig.screenWidth * 0.4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Text("Top Up"),
                  ),
                  Container(

                    child: TextFormField(
controller: moneycontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: outLineGrey,
                        enabledBorder: outLineGrey,
                        isDense: true,
                        isCollapsed: true,
fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(SizeConfig.blockSizeHorizontal*4),
                        errorBorder: outLineRed,

                        suffixIcon:  Container(
                          margin: EdgeInsets.all(5),
                          child: MaterialButton(
                            onPressed: () {
                              print("klnsdavko");
                              moneycontroller=TextEditingController(text: "500");
                            },
                            //height: SizeConfig.blockSizeVertical * 3,
                           // padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical),
                            minWidth: SizeConfig.screenWidth * 0.25,
                            color: Color(gradientColor1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Text("₹ 500",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        focusedErrorBorder: outLineRed,
                        hintText: "Enter Amount",
                        hintStyle: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,

                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          //   Container(
          //     width: SizeConfig.screenWidth,
          //     margin: EdgeInsets.symmetric(
          //         horizontal: SizeConfig.screenWidth * 0.05,
          //         vertical: SizeConfig.blockSizeVertical),
          //     child: Text(
          //       "Saved Card",
          //       style: TextStyle(
          //           color: Color(black),
          //           fontWeight: FontWeight.w600,
          //           fontSize: SizeConfig.blockSizeVertical * 2),
          //     ),
          //   ),
          //   ListView.builder(
          //     itemBuilder: (context, int index) {
          //       return Container(
          //         width: SizeConfig.screenWidth,
          //         margin: EdgeInsets.symmetric(
          //             horizontal: SizeConfig.screenWidth * 0.05,
          //             vertical: SizeConfig.blockSizeVertical),
          //         padding: EdgeInsets.all(8),
          //         height: SizeConfig.screenHeight * 0.15,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(15),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey[200],
          //               spreadRadius: 2.0,
          //               blurRadius: 5.0,
          //             ),
          //           ],
          //         ),
          //         child: Row(
          //           children: [
          //             Container(
          //               width: SizeConfig.screenWidth * 0.25,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(15)),
          //               child: ClipRRect(
          //                 borderRadius: BorderRadius.circular(15),
          //                 child: Image.asset('assets/icons/axis.png'),
          //               ),
          //             ),
          //             Container(
          //               margin: EdgeInsets.only(
          //                   left: SizeConfig.blockSizeHorizontal * 2),
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Text(
          //                         "Axis Bank",
          //                         style: TextStyle(
          //                           color: Colors.black,
          //                           fontWeight: FontWeight.w500,
          //                         ),
          //                       ),
          //                       Container(
          //                         margin: EdgeInsets.only(
          //                             left: SizeConfig.screenWidth * 0.25),
          //                         width: SizeConfig.screenWidth * 0.15,
          //                         child: Image.asset(
          //                             'assets/icons/mastercard.png'),
          //                       ),
          //                     ],
          //                   ),
          //                   Text(
          //                     "**** **** **** 0230",
          //                     style: TextStyle(
          //                       color: Colors.black,
          //                       fontWeight: FontWeight.w500,
          //                     ),
          //                   ),
          //                   Text(
          //                     "Debit Card",
          //                     style: TextStyle(
          //                         color: Colors.black,
          //                         fontWeight: FontWeight.w400,
          //                         fontSize: SizeConfig.blockSizeVertical * 1.5),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //     primary: false,
          //     itemCount: 2,
          //     shrinkWrap: true,
          //   ),
          //   Container(
          //     width: SizeConfig.screenWidth,
          //     margin: EdgeInsets.symmetric(
          //         horizontal: SizeConfig.screenWidth * 0.05,
          //         vertical: SizeConfig.blockSizeVertical),
          //     child: Text(
          //       "Other Options",
          //       style: TextStyle(
          //           color: Color(black),
          //           fontWeight: FontWeight.w600,
          //           fontSize: SizeConfig.blockSizeVertical * 2),
          //     ),
          //   ),
          //   Container(
          //     width: SizeConfig.screenWidth,
          //     margin: EdgeInsets.symmetric(
          //         horizontal: SizeConfig.screenWidth * 0.05,
          //         vertical: SizeConfig.blockSizeVertical),
          //     padding: EdgeInsets.all(8),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(15),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey[200],
          //           spreadRadius: 2.0,
          //           blurRadius: 5.0,
          //         ),
          //       ],
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //       Container(
          //         width: SizeConfig.screenWidth * 0.25,
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Image.asset('assets/icons/debit.png',
          //             width: SizeConfig.screenWidth * 0.2,),
          //             Text("Debit / Credit Card",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               color: Colors.black,
          //               fontWeight: FontWeight.w600,
          //               fontSize: SizeConfig.blockSizeVertical * 1.5
          //
          //             ),)
          //           ],
          //         ),
          //       ),
          //         Container(
          //           width: SizeConfig.screenWidth * 0.25,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Image.asset('assets/icons/net banking.png',
          //                 width: SizeConfig.screenWidth * 0.2,),
          //               Text("Net Banking",
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: SizeConfig.blockSizeVertical * 1.5
          //
          //                 ),)
          //             ],
          //           ),
          //         ),
          //         Container(
          //           width: SizeConfig.screenWidth * 0.25,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Image.asset('assets/icons/upi.png',
          //                 width: SizeConfig.screenWidth * 0.2,
          //               height: SizeConfig.screenHeight * 0.1),
          //               Text("UPI Payments",
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: SizeConfig.blockSizeVertical * 1.5
          //
          //                 ),)
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   Container(
          //     width: SizeConfig.screenWidth,
          //     margin: EdgeInsets.symmetric(
          //         horizontal: SizeConfig.screenWidth * 0.05,
          //         vertical: SizeConfig.blockSizeVertical),
          //     child: Text(
          //       "Transactions",
          //       style: TextStyle(
          //           color: Color(black),
          //           fontWeight: FontWeight.w600,
          //           fontSize: SizeConfig.blockSizeVertical * 2),
          //     ),
          //   ),
          // Container(
          //   width: SizeConfig.screenWidth,
          //   margin: EdgeInsets.symmetric(
          //       horizontal: SizeConfig.screenWidth * 0.05,
          //       vertical: SizeConfig.blockSizeVertical),
          //   padding: EdgeInsets.all(8),
          //   height: SizeConfig.screenHeight * 0.15,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(15),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey[200],
          //         spreadRadius: 2.0,
          //         blurRadius: 5.0,
          //       ),
          //     ],
          //   ),
          //   child: Row(
          //     children: [
          //       Container(
          //         width: SizeConfig.screenWidth * 0.25,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(15)),
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(15),
          //           child: Image.asset('assets/icons/book.png'),
          //         ),
          //       ),
          //       Container(
          //         margin: EdgeInsets.only(
          //             left: SizeConfig.blockSizeHorizontal * 2),
          //         color: Colors.white,
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Container(
          //                   width:SizeConfig.screenWidth * 0.25,
          //                   child: Text(
          //                     "Book Name",
          //                     style: TextStyle(
          //                       color: Colors.black,
          //                       fontWeight: FontWeight.w500,
          //                     ),
          //                   ),
          //                 ),
          //                 Container(
          //                   margin: EdgeInsets.only(
          //                     left: SizeConfig.screenWidth * 0.15
          //                   ),
          //                   child: Text(
          //                     "10/07/2021",
          //                     style: TextStyle(
          //                       color: Color(black),
          //                       fontWeight: FontWeight.w500,
          //                       fontSize: SizeConfig.blockSizeVertical * 1.25
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             Text(
          //               "Axis Bank",
          //               style: TextStyle(
          //                 color: Colors.black,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   "**** **** **** 0230",
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //                 Container(
          //                   margin: EdgeInsets.only(
          //                     left: SizeConfig.blockSizeHorizontal * 10
          //                   ),
          //                   width: SizeConfig.screenWidth * 0.15,
          //                   child: Image.asset(
          //                       'assets/icons/mastercard.png'),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          //   Container(
          //     width: SizeConfig.screenWidth,
          //     margin: EdgeInsets.symmetric(
          //         horizontal: SizeConfig.screenWidth * 0.05
          //     ),
          //     height: SizeConfig.blockSizeVertical * 7,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(25),
          //         color: Color.fromRGBO(212,247,255,0.45)
          //     ),
          //     child: MaterialButton(
          //       onPressed: (){
          //
          //       },
          //       child: Row(
          //         children: [
          //           ImageIcon(AssetImage('assets/icons/offer.png'),color: Color(colorBlue),size: SizeConfig.blockSizeVertical * 4,),
          //           Text("Get 10% off on 1st Wallet Topup",
          //             style: TextStyle(
          //                 color: Color(black),
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: SizeConfig.blockSizeVertical * 1.65
          //             ),),
          //           SizedBox(
          //             width: SizeConfig.blockSizeHorizontal * 4,
          //           ),
          //           MaterialButton(onPressed: (){},
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(25)
          //             ),
          //             color: Colors.white,
          //             child: Text("Apply Now",
          //               style: TextStyle(
          //                   color: Color(colorBlue),
          //                   fontWeight: FontWeight.w600,
          //                 fontSize: SizeConfig.blockSizeVertical * 1.5
          //               ),),
          //             minWidth: SizeConfig.screenWidth * 0.2,
          //             padding: EdgeInsets.zero,)
          //         ],
          //       ),
          //     ),
          //   ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),

          ],
        ),
      ),
    ));
  }
  static InputBorder outLineGrey = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: Color(colorBlue),
    ),
  );
  static InputBorder outLineRed = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.red,
      ));

  void openwallet()
  {
    print("jbnasdvi"+(int.parse(moneycontroller.text)*100).toString());
    var options = {
      'key': 'rzp_live_b5Jmla6DpICdpO',
      'amount':(int.parse(moneycontroller.text)*100).toString(),
      'name': 'Apni Stationary',
      'description': 'Books for you',

      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e'+e);
    }
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("response.paymentId");
    print(response.paymentId);
   moneyaddWallet(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showPopUp(context,
      "ERROR: " + "Add Payment Failed",
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showPopUp(context, "EXTERNAL_WALLET: " + response.walletName, );
  }
  showPopUp(BuildContext context, String msg) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context).pop();

                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return MainScreen();
                    }));
              },
            ),
          ],
        );
      },
    );
  }
  dynamic paymentresponse = new List();
  void moneyaddWallet(PaymentSuccessResponse responses) async {
    setState(() {
      isLoading = true;
    });


    try {
      final response = await post(
          Uri.parse(
              "http://admin.apnistationary.com/api/add-amount"),
          body: (
          {
            "user_id" : "${PreferenceManager.getUserId()}",
            "session_key": PreferenceManager.getSessionKey(),
            "add-amount":moneycontroller.text,
            "txn_id":responses.paymentId
          }
      ));
      print("ffvvvf"+response.statusCode.toString());
      print("ffvvvf"+moneycontroller.text.toString());
      if (response.statusCode == 256) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        setState(() {
          paymentresponse=responseJson['date'];

          isError = false;

          isLoading = false;
          print('setstate'+paymentresponse.toString());
          showPopUp(context, "Money Added to Wallet Successfully");
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
}
