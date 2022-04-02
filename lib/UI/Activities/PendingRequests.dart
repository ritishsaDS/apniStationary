import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
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
class OrdersRequest extends StatefulWidget{
  var status;
  OrdersRequest({this.status});
  @override
  _PendingRequestState createState() => _PendingRequestState();
}

class _PendingRequestState extends State<OrdersRequest> {
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  @override
  void initState() {
    getOrderRequests();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(child: Column(children: [

       Expanded(

           child:cartdata.length==0?getNodDataWidget(): ListView(children:orderlists() ,))
     ],),),
   )
   ;
  }
  dynamic cartdata = new List();
  void getOrderRequests() async {
    Dialogs.showLoadingDialog(context, loginLoader);
    setState(() {

    });


    try {
      final response = await post(
          Uri.parse(
              "https://admin.apnistationary.com/api/list-order-requests"),
          body: (
              {
                "user_id" : "${PreferenceManager.getUserId()}",
                "session_key": PreferenceManager.getSessionKey(),
                'order_status':widget.status
              }
          ));
      print("ffvvvf");
      if (response.statusCode == 256) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        if(responseJson['status']=="200"){
          setState(() {
            cartdata=responseJson['data'];
            Navigator.of(loginLoader.currentContext,
                rootNavigator: true) .pop();
            print('setstate'+cartdata.toString());
          });
        }
else{
  if(responseJson["message"]=="Data Not Found"){
   setState(() {
     cartdata.length=0;
     print("jknoan");
     Navigator.of(loginLoader.currentContext,
         rootNavigator: true) .pop();
   });
  }
  else{
    showAlert(context,
        responseJson['message']);
    Navigator.of(loginLoader.currentContext,
        rootNavigator: true) .pop();
  }


        }

      } else {

        setState(() {

        });
        Navigator.of(loginLoader.currentContext,
            rootNavigator: true) .pop();
      }
    } catch (e) {
      print(e);
      setState(() {

      });
      Navigator.of(loginLoader.currentContext,
          rootNavigator: true) .pop();
    }
  }
  List<Widget> orderlists() {
    List<Widget> featuredlist = new List();
    for (int i = 0; i < cartdata.length; i++) {
      featuredlist.add(
          Column(
            children: [

              Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight*0.18,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.01,
                      vertical: SizeConfig.blockSizeVertical),
                  child:Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestDetail(catId:cartdata[i]['book_id'].toString(),firsname:cartdata[i]['first_name'],college_name:cartdata[i]['college_name'])));
                        },
                        child: Container(
                          decoration:
                          BoxDecoration(
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
                                right:
                                SizeConfig.blockSizeHorizontal * 2),
                            child: RotatedBox(
                              child: Text(
                                "View Detail",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                    SizeConfig.blockSizeVertical * 2),
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
                        margin: EdgeInsets.only(
                            right: SizeConfig.screenWidth * 0.09),
                        decoration:
                            BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(25)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                    "http://admin.apnistationary.com/img/books" +
                                        "/" +
                                        cartdata[i]['image1']),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.5,
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal*1.5),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:SizeConfig.screenWidth*0.30,
                                        child: Text(
                                          cartdata[i]['name'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(black),
                                              fontWeight: FontWeight.w500,
                                              fontSize: SizeConfig
                                                  .blockSizeVertical *
                                                  2),
                                        ),
                                      ),
                                      Text(
                                        rs+" "+cartdata[i]['pay_amount'].toString(),
                                        style: TextStyle(
                                            color: Color(0XFF656565),
                                            fontWeight: FontWeight.w500,
                                            fontSize: SizeConfig
                                                .blockSizeVertical *
                                                2),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    cartdata[i]['auther_name'],
                                    style: TextStyle(
                                        color: Color(0XFF656565),
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                        SizeConfig.blockSizeVertical *
                                            1.75),
                                  ),
                                  Text(
                                    "Condition: ${cartdata[i]['conditions']}",
                                    style: TextStyle(
                                        color: Color(0XFF656565),
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                        SizeConfig.blockSizeVertical *
                                            1.75),
                                  ),
                                  SizedBox(height: 10,),
                                  widget.status=="1"?
                                  Container(
                                    width: SizeConfig.screenWidth * 0.7,
                                    height:
                                    SizeConfig.blockSizeVertical * 4,

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Container(
                                          decoration: BoxDecoration(


                                              borderRadius:
                                              BorderRadius.circular(15),
                                              border: Border.all(
                                                color:
                                                Color(gradientColor1),


                                              )
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              showRejectAlert(context,cartdata[i]['order_id'],cartdata[i]['user_firebase_id']);
                                            },
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(
                                                  color: Color(gradientColor1),
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(gradientColor1),
                                                Color(gradientColor2),
                                              ],
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              showAcceptAlert(context,cartdata[i]['order_id'],cartdata[i]['user_firebase_id']);
                                             // AcceptOrder(cartdata[i]['order_id'],cartdata[i]['user_firebase_id']);
                                            },
                                            child: Text(
                                              "Accept",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ):
                                  Container(
                                    width: SizeConfig.screenWidth * 0.9,
                                    height:
                                    SizeConfig.blockSizeVertical * 4,

                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(gradientColor1),
                                            Color(gradientColor2),
                                          ],
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(15),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {},
                                        child: Text(
                                          widget.status=="2"?"Accepted":"Rejected",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15),
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
                  )



              ),

            ],
          )
      );}
    return featuredlist;
  }
  Widget getNodDataWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.info_outline,size: 100,color: Colors.blue.withOpacity(0.6),),
          SizedBox(height: 10,),
          Text("No Order List Found",style: TextStyle(fontSize: 20),),
        ],
      ),
    );
  }
  void AcceptOrder(id,firebasid) async {
    Dialogs.showLoadingDialog(context, loginLoader);
    setState(() {

    });


    try {
      final response = await post(
          Uri.parse(
              "https://admin.apnistationary.com/api/update-order-status"),
          body: (
              {
                "user_id" : PreferenceManager.getUserId().toString(),
                "session_key": PreferenceManager.getSessionKey(),
                'order_status':'2',
                "order_id":id.toString()
              }
          ));
      print("ffvvvf"+response.reasonPhrase);
      if (response.statusCode == 256) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        if(responseJson['status']=="200"){
          Map<String, dynamic>   body = {
            'senderId': PreferenceManager.getfirebaseid(),
            'receiverId': firebasid.toString().split(",")[0],
            'img': "widget.img",
            'userName': PreferenceManager.getName(),
          };
          AppNotificationHandler.sendMessage(
              msg: PreferenceManager.getName()+" Accepted Your Order", data: body, token: firebasid.toString().split(",")[1].toString());


          setState(() {
            Navigator.of(loginLoader.currentContext,
                rootNavigator: true) .pop();
            getOrderRequests();

          });
        }
        else{
          Navigator.of(loginLoader.currentContext,
              rootNavigator: true) .pop();
          showAlert(context,
              responseJson['message']);

        }

      }
      else {
        Map<String, dynamic>   body = {
          'senderId': PreferenceManager.getfirebaseid(),
          'receiverId': firebasid.toString().split(",")[0],
          'img': "widget.img",
          'userName': PreferenceManager.getName(),
        };
        AppNotificationHandler.sendMessage(
            msg: PreferenceManager.getName()+" Accepted Your Order", data: body, token: firebasid.toString().split(",")[1].toString());

        Navigator.of(loginLoader.currentContext,
            rootNavigator: true) .pop();
        setState(() {
          getOrderRequests();
        });
      }
    } catch (e) {
      print(e);
      setState(() {

      });
    }
  }
  void RejectOrder(id,firebasid) async {
  setState(() {

  });


  try {
  final response = await post(
  Uri.parse(
  "https://admin.apnistationary.com/api/update-order-status"),
  body: (
  {
  "user_id" : "${PreferenceManager.getUserId()}",
  "session_key": PreferenceManager.getSessionKey(),
  'order_status':"3",
    "order_id":id.toString()
  }
  ));
  print("ffvvvf");
  if (response.statusCode == 256) {
  final responseJson = json.decode(response.body);
  print(responseJson);
  if(responseJson['status']=="200"){
  setState(() {
    Map<String, dynamic>   body = {
      'senderId': PreferenceManager.getfirebaseid(),
      'receiverId': firebasid.toString().split(",")[0],
      'img': "widget.img",
      'userName': PreferenceManager.getName(),

    };
    AppNotificationHandler.sendMessage(
        msg: PreferenceManager.getName()+" Rejected Your Order", data: body, token: firebasid.toString().split(",")[1].toString());

    //cartdata=responseJson['data'];
    getOrderRequests();

  print('setstate'+cartdata.toString());
  });
  }
  else{
  showAlert(context,
  responseJson['message']);

  }

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
  showAcceptAlert(BuildContext context,orderid,firebaseid) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text("Are you Sure you want to Accept this order"),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.pop(context);
                AcceptOrder(orderid,firebaseid);
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);

              },
            ),
          ],
        );
      },
    );
  }
  showRejectAlert(BuildContext context,orderid,firebaseid) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text("Are you Sure you want to Reject this order"),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.pop(context);
                RejectOrder(orderid,firebaseid);
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {

                Navigator.pop(context);

              },
            ),
          ],
        );
      },
    );
  }
}