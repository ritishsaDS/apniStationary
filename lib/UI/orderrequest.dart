import 'dart:convert';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Activities/Cart.dart';
import 'Activities/PendingRequests.dart';

class Orderrequest extends StatefulWidget{
  @override
  _OrderrequestState createState() => _OrderrequestState();
}

class _OrderrequestState extends State<Orderrequest> {
  int backgroundColorBlue = 0XFF0066B3;
  int copyrightTextColor = 0XFFE5E5E5;
  int fontColorGray = 0XFF77849C;
  int fontColorSteelGrey = 0XFF445066;
  @override
  void initState() {
    getOrderRequests();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: DefaultTabController(length: 3, child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0.0,
              title: TabBar(
                unselectedLabelStyle: TextStyle(
                  color: Color(fontColorGray),
                  fontWeight: FontWeight.w600,
                ),
                labelStyle: TextStyle(
                  color: Color(backgroundColorBlue),
                  fontWeight: FontWeight.w700,
                ),
                indicatorColor: Color(backgroundColorBlue),
                labelColor: Color(backgroundColorBlue),
                isScrollable: true,
                unselectedLabelColor: Color(fontColorGray),
                tabs: [
                  Tab(
                    text: "Pending Requests",
                  ),
                  Tab(
                    text: "Accepted Requests",
                  ),
                  Tab(
                    text: "Rejected Requests",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                OrdersRequest(status:"1"),
                OrdersRequest(status:"2"),
                OrdersRequest(status:"3"),
              ],
            ))));

  }
  dynamic cartdata = new List();
  void getOrderRequests() async {
    setState(() {

    });


    try {
      final response = await post(
          Uri.parse(
              "http://admin.apnistationary.com/api/list-order-requests"),
          body: (
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

          print('setstate'+cartdata.toString());
        });


      } else {

        setState(() {

        });
      }
    } catch (e) {
      print(e);
      setState(() {

      });
    }
  }
}