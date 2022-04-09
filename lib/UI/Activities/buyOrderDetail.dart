import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/UI/Activities/MainScreen.dart';
import 'package:book_buy_and_sell/Utils/Dialog.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/services/AppNotification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'dart:convert';

import 'BookDetails.dart';
import 'Requestdetail.dart';

class BuyOrderdeatil extends StatefulWidget {
  @override
  _PendingRequestState createState() => _PendingRequestState();
}

class _PendingRequestState extends State<BuyOrderdeatil> {
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  bool refreshscreen = false;
  bool isLoading = false;
  @override
  void initState() {
    getOrderRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        refreshscreen
            ? Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainScreen()))
            : Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            "All Orders",
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
        ),
        body: SafeArea(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: cartdata.length == 0
                            ? getNodDataWidget()
                            : ListView(
                                children: orderlists(),
                              ))
                  ],
                ),
        ),
      ),
    );
  }

  dynamic cartdata = new List();
  void getOrderRequests() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await post(
          Uri.parse("https://admin.apnistationary.com/api/myOrderList"),
          body: ({
            "user_id": "${PreferenceManager.getUserId()}",
            "session_key": PreferenceManager.getSessionKey(),
          }));
      print("ffvvvf");
      if (response.statusCode == 256) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        if (responseJson['status'] == "200") {
          setState(() {
            cartdata = responseJson['date'];

            print('setstate' + cartdata.toString());
            setState(() {
              isLoading = false;
            });
          });
        } else {
          if (responseJson["message"] == "Data Not Found") {
            setState(() {
              cartdata.length = 0;
              refreshscreen = true;
              print("jknoan");

              setState(() {
                isLoading = false;
              });
            });
          } else {
            showAlert(context, responseJson['message']);
            setState(() {
              isLoading = false;
            });
          }
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Widget> orderlists() {
    List<Widget> featuredlist = new List();
    for (int i = 0; i < cartdata.length; i++) {
      featuredlist.add(Column(
        children: [
          Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.18,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              child: MultiSelectItem(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestDetail(
                                    catId: cartdata[i]['book_id'].toString(),
                                    firsname: cartdata[i]['first_name'],
                                    college_name: cartdata[i]
                                        ['college_name'])));
                      },
                      child: Container(
                        decoration: BoxDecoration(
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
                              right: SizeConfig.blockSizeHorizontal * 2),
                          child: RotatedBox(
                            child: Text(
                              "View Detail",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.blockSizeVertical * 2),
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
                      margin:
                          EdgeInsets.only(right: SizeConfig.screenWidth * 0.09),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: SizeConfig.screenWidth * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                  "http://admin.apnistationary.com/img/books" +
                                      "/" +
                                      cartdata[i]['book_image']),
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.5,
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 1.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth * 0.30,
                                      child: Text(
                                        cartdata[i]['book_name'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Color(black),
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    2),
                                      ),
                                    ),
                                    Text(
                                      rs +
                                          " " +
                                          cartdata[i]['price'].toString(),
                                      style: TextStyle(
                                          color: Color(0XFF656565),
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              SizeConfig.blockSizeVertical * 2),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * 0.30,
                                  child: Text(
                                    cartdata[i]['first_name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(black),
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * 0.9,
                                  height: SizeConfig.blockSizeVertical * 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(gradientColor1),
                                          Color(gradientColor2),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {
                                        showAcceptAlert(
                                            context, cartdata[i]['order_id']);
                                      },
                                      child: Text(
                                        "Item is Delivered?",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
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
              )),
        ],
      ));
    }
    return featuredlist;
  }

  Widget getNodDataWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            size: 100,
            color: Colors.blue.withOpacity(0.6),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "No Order List Found",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  void AcceptOrder(id) async {
    setState(() {});

    try {
      final response = await post(
          Uri.parse("https://admin.apnistationary.com/api/update-order-status"),
          body: ({
            "user_id": "${PreferenceManager.getUserId()}",
            "session_key": PreferenceManager.getSessionKey(),
            'order_status': '4',
            "order_id": id.toString()
          }));
      print("ffvvvf" + response.statusCode.toString());
      if (response.statusCode == 256) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        if (responseJson['status'] == "200") {
          Navigator.pop(context);
          setState(() {
            getOrderRequests();
          });
        } else {
          showAlert(context, responseJson['message']);
        }
      } else {
        setState(() {});
      }
    } catch (e) {
      print(e);
      setState(() {});
    }
  }

  showAcceptAlert(BuildContext context, orderid) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text("Are  you Sure this order is delivered to you"),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                AcceptOrder(orderid);
              },
            ),
            // FlatButton(
            //   child: Text('No'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        );
      },
    );
  }
}
