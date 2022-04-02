import 'dart:convert';
import 'dart:io';

import 'package:book_buy_and_sell/ChatUi/widget/widget.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/UI/Activities/MainScreen.dart';
import 'package:book_buy_and_sell/Utils/Dialog.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/Utils/services/database.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/services/AppNotification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
var catId;
var firebaseid;
var data;
  Chat({this.chatRoomId,this.catId,this.data,this.firebaseid});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages(){

    return StreamBuilder <QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
          itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index){
              return MessageTile(
                message: snapshot.data.docs[index].get("message"),
                sendByMe: Constants.myName == snapshot.data.docs[index].get("sendBy"),
              );
            }) : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime
            .now()
            .millisecondsSinceEpoch,
      };
      setState(() {
        messageEditingController.clear();
      });
      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);
      Map<String, dynamic>   body = {
        'senderId': PreferenceManager.getfirebaseid(),
        'receiverId': widget.firebaseid.toString().split(",")[0],
        'img': "widget.img",
        'userName': PreferenceManager.getName(),
      };
      widget.firebaseid==null?
      AppNotificationHandler.sendMessage(
          msg: messageEditingController.text, data: body, token: widget.data.toString().split(",")[1].toString()): AppNotificationHandler.sendMessage(
          msg: messageEditingController.text, data: body, token: widget.firebaseid.toString().split(",")[1].toString());


      setState(() {
        messageEditingController.text = "";

      });
    }
  }

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
print("username"+Constants.myName);
    KeyboardVisibilityNotification().addNewListener(
      onHide: () {
       setState(() {
         height=0.8;
       });
      },
    );
    super.initState();
  }
var height=0.8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBarMain(context),
      body: Container(
height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
           Container(
             //margin: EdgeInsets.only(top: 70),
             height: SizeConfig.screenHeight*height,
             child:  chatMessages(),),
            // Container(alignment: Alignment.topCenter,
            //   width: MediaQuery
            //       .of(context)
            //       .size
            //       .width,
            //   margin: EdgeInsets.only(top:10,left: 10,right: 10),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            //     color: Colors.blue,
            //     child: Row(
            //       children: [
            //         Text("You Want to buy this book",style: TextStyle(color: Colors.white,fontSize: 14),),
            //         SizedBox(width: 5,),
            //         GestureDetector(
            //           onTap: () {
            //             Acceptbook();
            //           },
            //           child: Container(
            //              padding: EdgeInsets.all(10),
            //               decoration: BoxDecoration(
            //                   gradient: LinearGradient(
            //                       colors: [
            //                         const Color(0x36FFFFFF),
            //                         const Color(0x0FFFFFFF)
            //                       ],
            //                       begin: FractionalOffset.topLeft,
            //                       end: FractionalOffset.bottomRight
            //                   ),
            //                   borderRadius: BorderRadius.circular(40)
            //               ),
            //
            //               child: Text("Accept",style: TextStyle(color: Colors.white),))
            //         ),
            //         SizedBox(width: 20,),
            //         GestureDetector(
            //           onTap: () {
            //             print("mrvm");
            //             rejectbook();
            //           },
            //           child: Container(
            //               padding: EdgeInsets.all(10),
            //               decoration: BoxDecoration(
            //                   gradient: LinearGradient(
            //                       colors: [
            //                         const Color(0x36FFFFFF),
            //                         const Color(0x0FFFFFFF)
            //                       ],
            //                       begin: FractionalOffset.topLeft,
            //                       end: FractionalOffset.bottomRight
            //                   ),
            //                   borderRadius: BorderRadius.circular(40)
            //               ),
            //
            //               child: Text("Reject",style: TextStyle(color: Colors.white),)),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              color: Colors.white,
              alignment: Alignment.bottomCenter,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.blue)),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),

                child: Row(
                  children: [
                    Expanded(
                          child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  height=0.45;

                                });
                              },
                              child: TextField(
                                autofocus: false,


onTap: (){
  setState(() {
    height=0.45;

  });
},
                                onSubmitted: (val){
                                  setState(() {
                                    height=0.8;

                                  });
                                },
                            onChanged: (val){
                              setState(() {
                                height=0.45;

                              });
                            },
                            controller: messageEditingController,
                            style: simpleTextStyle(),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                            ],
                            keyboardType: TextInputType.text,

                            decoration: InputDecoration(
                              fillColor: Colors.white,
                                isDense: true,
                                filled: true,
                                hintText: "Message......",
                                hintStyle: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none
                            ),
                          )),
                    ),
                    SizedBox(width: 16,),
                    GestureDetector(
                      onTap: () {

                        addMessage();

                      },
                      child: Container(

                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                     Colors.blue,
                                    Colors.lightBlue,
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),

                          child: Icon(Icons.send,color: Colors.white,size: 20,)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void Acceptbook() async {

    Dialogs.showLoadingDialog(
        context, loginLoader);
    print(widget.catId);
    try {
      final response = await post(

          Uri.parse("http://admin.apnistationary.com/api/accept"),
          body: (
              {
                "user_id" : "${PreferenceManager.getUserId()}",
                "session_key": PreferenceManager.getSessionKey(),
                "book_id":widget.catId,

              }
          ));
      print("ffvvvf"+response.statusCode.toString());

      if ( json.decode(response.body)['status'] == "256") {
        Navigator.of(loginLoader.currentContext,
            rootNavigator: true) .pop();


        final responseJson = json.decode(response.body);
        print(responseJson);
        setState(() {
          showchatAlert(context, json.decode(response.body)['message']);


        });


      } else {
        Navigator.of(loginLoader.currentContext,
            rootNavigator: true) .pop();
        setState(() {
          showchatAlert(context, json.decode(response.body)['message']);
         // isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {


      });
    }
  }
  void rejectbook() async {

    Dialogs.showLoadingDialog(
        context, loginLoader);
    print(widget.catId);
    try {
      final response = await post(

          Uri.parse("http://admin.apnistationary.com/api/reject"),
          body: (
              {
                "user_id" : "${PreferenceManager.getUserId()}",
                "session_key": PreferenceManager.getSessionKey(),
                "book_id":widget.catId,

              }
          ));
      print("ffvvvf"+response.statusCode.toString());

      if ( json.decode(response.body)['status'] == "256") {
        Navigator.of(loginLoader.currentContext,
            rootNavigator: true) .pop();


        final responseJson = json.decode(response.body);
        print(responseJson);
        setState(() {

          showchatAlert(context, json.decode(response.body)['message']);

        });


      } else {
        Navigator.of(loginLoader.currentContext,
            rootNavigator: true) .pop();
        setState(() {
          showchatAlert(context, json.decode(response.body)['message']);
          // isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        showchatAlert(context, e);

      });
    }
  }
  showchatAlert(BuildContext context,String msg) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen()));
              },
            ),
          ],
        );
      },
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});


  @override
  Widget build(BuildContext context) {
    print(sendByMe);
    return Container(

      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
        topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
              ]
                  : [
                const Color(0xff007EF4),
                const Color(0xff007EF4)
              ],
            )
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,

            fontWeight: FontWeight.w900)),
      ),
    );
  }



}
