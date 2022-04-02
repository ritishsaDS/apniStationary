import 'dart:convert';

import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget{
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  bool  isLoading = false;
  bool   isError = false;
  bool   visibility = false;
  @override
  void initState() {
    getfeaturedmatches();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return SafeArea(
       child: Scaffold(
         backgroundColor: Colors.white,
         appBar: AppBar(
           backgroundColor: Colors.white,
           elevation: 0.0,
           leading: InkWell(
             onTap: () {
               Navigator.pop(context);
             },
             child: Icon(
               Icons.arrow_back_ios_rounded,
               color: Colors.blue,
             ),
           ),
           centerTitle: true,
           title: Text(
             "Notifications",
             style: TextStyle(
                 color: Colors.black, fontWeight: FontWeight.w600),
           ),
         ),
         body: SingleChildScrollView(
           physics: BouncingScrollPhysics(),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                 width: SizeConfig.screenWidth,
                 margin: EdgeInsets.symmetric(
                   vertical: SizeConfig.blockSizeVertical,
                   horizontal: SizeConfig.screenWidth * 0.02,
                 ),
                 child: ListView.builder(
                   itemBuilder: (BuildContext context, int index) {
                     return Container(
                       margin:
                       EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                       child: ListTile(
                         tileColor: Colors.white,
                         title: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                         cartdata[index]["created_at"]==null?"": DateFormat("yMMMMd").format(DateTime.parse(
                                   cartdata[index]["created_at"].toString())),
                               style: TextStyle(
                                   fontWeight: FontWeight.w600,
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical * 1.75),
                             ),
                             Padding(
                               padding: EdgeInsets.only(
                                   top: SizeConfig.blockSizeVertical * 2),
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   CircleAvatar(
radius:20,
                                     backgroundColor: Color(0xffE0EDF6),
                                     child: Image.asset("assets/icons/applogo.png",fit: BoxFit.fitWidth,),
                                   ),
                                   SizedBox(
                                     width: 10,
                                   ),
                                   Flexible(
                                     child: Text(
                                       cartdata[index]['notification'],
                                       style: TextStyle(
                                           color: Colors.blueGrey,
                                           fontSize: SizeConfig.blockSizeVertical *
                                               1.85),
                                     ),
                                   ),
                                 ],
                               ),
                             )
                           ],
                         ),
                       ),
                     );
                   },
                   physics: NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   itemCount:
                   cartdata != null && cartdata.length > 0
                       ? cartdata.length
                       : 0,
                   primary: false,
                 ),
               ),
             ],
           ),
         ),
       ));

  }
  dynamic cartdata = new List();
  void getfeaturedmatches() async {
    setState(() {
      isLoading = true;
    });


    try {
      final response = await post(
          Uri.parse(
            "https://admin.apnistationary.com/api/show_order_notifications"),body: (
          {
            "user_id" : "${PreferenceManager.getUserId()}",
            "session_key": PreferenceManager.getSessionKey(),
          }
      ));
      print("ffvvvf"+response.statusCode.toString());
      if (response.statusCode == 256) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        setState(() {
          cartdata=responseJson['data'];
          cartdata==null?visibility=false:visibility=true;
          isError = false;

          isLoading = false;
          print('setstate'+cartdata[1]['created_at'].toString());
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