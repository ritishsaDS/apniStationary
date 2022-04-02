import 'dart:convert';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Donescreen.dart';
import 'package:book_buy_and_sell/Utils/Dialog.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Withdrawalwallet extends StatefulWidget{
  var amount;
  Withdrawalwallet({this.amount});
  @override
  _WithdrawalwalletState createState() => _WithdrawalwalletState();
}

class _WithdrawalwalletState extends State<Withdrawalwallet> {
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  bool showupi=false;
  bool showbank=false;
  bool isError = false;
TextEditingController name=TextEditingController();
TextEditingController phone=TextEditingController();
TextEditingController acno=TextEditingController();
TextEditingController reenterac=TextEditingController();
TextEditingController ifsc=TextEditingController();
TextEditingController amount=TextEditingController();
TextEditingController bankname=TextEditingController();
TextEditingController up=TextEditingController();
 bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return LoaderOverlay(

      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(

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
                    height: SizeConfig.screenHeight * 0.10,
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


                      ],
                    ),
                  ),
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            showupi=true;
                            if(showbank==true){
                              showbank=false;
                            }
                          });
                        },
                        child: Container(
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
                      ),
                      SizedBox(width: 10,),
                      Text("Or"),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            showbank=true;
                            if(showupi==true){
                             setState(() {
                               showbank=true;
                               showupi=false;
                             });
                            }
                          });
                        },
                        child: Container(
                          width: SizeConfig.screenWidth * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/net banking.png',
                                width: SizeConfig.screenWidth * 0.2,),
                              Text("From Bank",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: SizeConfig.blockSizeVertical * 1.5

                                ),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                Stack(
                  children: [
                    Visibility(
                      visible: showbank,

                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(children: [
                        TextFormField(
                          // focusNode: emailFn,
                          controller: bankname,
                          decoration: InputDecoration(
                            focusedBorder: outLineGrey,
                            enabledBorder: outLineGrey,
                            isDense: true,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.all(10),
                            errorBorder: outLineRed,
                            focusedErrorBorder: outLineRed,
                            hintText: "Enter Name",
                            hintStyle: TextStyle(
                              color: Color(hintGrey),
                              fontWeight: FontWeight.w500,

                            ),
                          ),
                          validator: (value) {
                            if (value.length<3) {
                              return "Please Input email in right format";
                            } else {
                              return null;
                            }
                          },

                        ),
                        SizedBox(
                          height:20,
                        ),
                        TextFormField(
                          //focusNode: phnFn,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),

                            ],
                             controller: phone,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                focusedBorder: outLineGrey,
                                enabledBorder: outLineGrey,
                                contentPadding: EdgeInsets.all(10),

                                isDense: true,
                                isCollapsed: true,

                                errorBorder: outLineRed,

                                focusedErrorBorder: outLineRed,
                                hintText: "Phone",
                                hintStyle: TextStyle(
                                  color: Color(hintGrey),
                                  fontWeight: FontWeight.w500,
                                )),
                            validator: (value) {
                              if (value.length<10) {
                                return "Phone Number can't be smaller then 10 Chracters";
                              } else {
                                return null;
                              }}
                        ),
                        SizedBox(
                          height:20,
                        ),
                        TextFormField(
controller: acno,
                          decoration: InputDecoration(
                            focusedBorder: outLineGrey,
                            enabledBorder: outLineGrey,
                            isDense: true,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.all(10),

                            errorBorder: outLineRed,
                            focusedErrorBorder: outLineRed,
                            hintText: "Enter Account Number",
                            hintStyle: TextStyle(
                              color: Color(hintGrey),
                              fontWeight: FontWeight.w500,

                            ),
                          ),
                          validator: (value) {
                            if (value.length<3) {
                              return "Please Input email in right format";
                            } else {
                              return null;
                            }
                          },

                        ),
                        SizedBox(
                          height:20,
                        ),
                        TextFormField(
                            controller: reenterac,

                            // focusNode: phnFn,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),

                            ],
                            // controller: phnController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                focusedBorder: outLineGrey,
                                enabledBorder: outLineGrey,
                                contentPadding: EdgeInsets.all(10),

                                isDense: true,
                                isCollapsed: true,

                                errorBorder: outLineRed,

                                focusedErrorBorder: outLineRed,
                                hintText: "Re-Enter Account Number",
                                hintStyle: TextStyle(
                                  color: Color(hintGrey),
                                  fontWeight: FontWeight.w500,
                                )),
                            validator: (value) {
                              if (value.length<10) {
                                return "Phone Number can't be smaller then 10 Chracters";
                              } else {
                                return null;
                              }}
                        ),
                        SizedBox(
                          height:20,
                        ),

                        TextFormField(
                          controller: ifsc,

                          decoration: InputDecoration(
                            focusedBorder: outLineGrey,
                            enabledBorder: outLineGrey,
                            isDense: true,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.all(10),

                            errorBorder: outLineRed,
                            focusedErrorBorder: outLineRed,
                            hintText: "IFSC Code",
                            hintStyle: TextStyle(
                              color: Color(hintGrey),
                              fontWeight: FontWeight.w500,

                            ),
                          ),
                          validator: (value) {
                            if (value.length<3) {
                              return "Please Input IFSC Code in right format";
                            } else {
                              return null;
                            }
                          },

                        ),
                          SizedBox(
                            height:20,
                          ),

                          TextField(
controller: amount,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              focusedBorder: outLineGrey,
                              enabledBorder: outLineGrey,
                              isDense: true,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.all(10),

                              errorBorder: outLineRed,
                              focusedErrorBorder: outLineRed,
                              hintText: "Enter Amount (in Rs.)",
                              hintStyle: TextStyle(
                                color: Color(hintGrey),
                                fontWeight: FontWeight.w500,

                              ),
                            ),


                          ),
                      ],),),
                    ),
                    Visibility(
                      visible: showupi,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            TextField(
                              // focusNode: emailFn,
                              keyboardType: TextInputType.number,
                               controller: amount,
                              decoration: InputDecoration(
                                focusedBorder: outLineGrey,
                                enabledBorder: outLineGrey,
                                isDense: true,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.all(10),
                                errorBorder: outLineRed,
                                focusedErrorBorder: outLineRed,
                                hintText: "Enter Amount (in Rs.)",
                                hintStyle: TextStyle(
                                  color: Color(hintGrey),
                                  fontWeight: FontWeight.w500,

                                ),
                              ),


                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              // focusNode: emailFn,
                              controller: up,
                              decoration: InputDecoration(
                                focusedBorder: outLineGrey,
                                enabledBorder: outLineGrey,
                                isDense: true,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.all(10),
                                errorBorder: outLineRed,
                                focusedErrorBorder: outLineRed,
                                hintText: "Enter Upi Id",
                                hintStyle: TextStyle(
                                  color: Color(hintGrey),
                                  fontWeight: FontWeight.w500,

                                ),
                              ),
                              validator: (value) {
                                if (value.length<3) {
                                  return "Please Input UPI id in right format";
                                } else {
                                  return null;
                                }
                              },

                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                  Center(
                    child: Container(
                      width: SizeConfig.screenWidth * 0.5,
                      height: SizeConfig.blockSizeVertical * 5,
                      margin: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.1,
                          right: SizeConfig.screenWidth * 0.1,
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
                        onPressed: () async {
                          if(amount.text.isEmpty||up.text.isEmpty){
                            CommonSnackBar.snackBar(message: "Amount or UPI id should not be empty");
                          }
                          else if(double.parse(widget.amount)<double.parse(amount.text)){
                           CommonSnackBar.snackBar(message: "Insufficient Balance");
                          }

                        else{
                            moneyaddWallet();
                          }
                       },

                        child: Text(
                          "Withdraw Amount",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  dynamic paymentresponse = new List();
  void moneyaddWallet() async {
    setState(() {
      isLoading = true;
    });
    print("jknjl");
    Dialogs.showLoadingDialog(
        context, loginLoader);
    var data=
    {"user_id" : "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "amount":amount.text,
      "type":showupi==true?"UPI":"Bank",
      "account_number":showupi==true?"":acno.text,
      "ifsc_code":showupi==true?"":ifsc.text,
      "bank_name":showupi==true?"":bankname.text,
      "upi_address":showupi==true?up.text:""}
    ;
    try {
      final response = await post(

          Uri.parse(
              "http://admin.apnistationary.com/api/withdrow-amount"),

          body: (
              {
                "user_id" : "${PreferenceManager.getUserId()}",
                "session_key": PreferenceManager.getSessionKey(),
                "add-amount":amount.text,
                "type":showupi==true?"UPI":"Bank",
                "txn_id":"",
                "account_number":showupi==true?"":acno.text,
                "ifsc_code":showupi==true?"":ifsc.text,
                "bank_name":showupi==true?"":bankname.text,
                "upi_address":showupi==true?up.text:""
              }
          ));
      print("ffvvvf"+response.statusCode.toString());
      print("ffvvvf"+data.toString());

      if (response.statusCode == 256) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        Navigator.of(loginLoader.currentContext,
            rootNavigator: true) .pop();
        setState(() {
          paymentresponse=responseJson['date'];
          Future.delayed(Duration(seconds: 1),
                  () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CheckAnimation(text:"Withdraw ")));
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckAnimation()));
              });
          isError = false;

          isLoading = false;
          print('setstate'+paymentresponse.toString());
         // showPopUp(context, "Money Added to Wallet Successfully");
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