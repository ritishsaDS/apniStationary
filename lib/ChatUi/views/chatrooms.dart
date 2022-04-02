
import 'package:book_buy_and_sell/ChatUi/views/search.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/Utils/helper/helperfunctions.dart';
import 'package:book_buy_and_sell/Utils/helper/theme.dart';
import 'package:book_buy_and_sell/Utils/services/auth.dart';
import 'package:book_buy_and_sell/Utils/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRooms,
      builder: (context, snapshot) {

        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.docs[index].get('chatRoomId')
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    chatRoomId: snapshot.data.docs[index].get("chatRoomId"),
                     data: snapshot.data.docs[index].data().toString()
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(()  {
        chatRooms = snapshots;

        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
      print("snapshots"+snapshots);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Your Chats"),
        elevation: 0.0,
        centerTitle: false,
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       AuthService().signOut();
        //       // Navigator.pushReplacement(context,
        //       //     MaterialPageRoute(builder: (context) => Authenticate()));
        //     },
        //     child: Container(
        //         padding: EdgeInsets.symmetric(horizontal: 16),
        //         child: Icon(Icons.exit_to_app)),
        //   )
        // ],
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.search),
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => Search()));
      //   },
      // ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Image.asset(
    //       "assets/images/logo.png",
    //       height: 40,
    //     ),
    //     elevation: 0.0,
    //     centerTitle: false,
    //     actions: [
    //       GestureDetector(
    //         onTap: () {
    //           AuthService().signOut();
    //           // Navigator.pushReplacement(context,
    //           //     MaterialPageRoute(builder: (context) => Authenticate()));
    //         },
    //         child: Container(
    //             padding: EdgeInsets.symmetric(horizontal: 16),
    //             child: Icon(Icons.exit_to_app)),
    //       )
    //     ],
    //   ),
    //   body: Container(
    //     child: chatRoomsList(),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     child: Icon(Icons.search),
    //     onPressed: () {
    //       Navigator.push(
    //           context, MaterialPageRoute(builder: (context) => Search()));
    //     },
    //   ),
    // );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  final dynamic data;

  ChatRoomsTile({this.userName,this.data,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Chat(
            chatRoomId: chatRoomId,
            data:data
          )
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage("assets/icons/chatavatar.jpeg"))
                     ),

                ),
                SizedBox(
                  width: 12,
                ),
                Text(userName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black
                        ,
                        fontSize: 16,

                        fontWeight: FontWeight.w900)),
                Expanded(child: SizedBox(),),
                GestureDetector(
                  onTap: (){
                    print(userName);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Chat(
                          chatRoomId: chatRoomId,
                        )
                    ));
                    //sendMessage(userName);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24)
                    ),
                    child: Text("Message",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),),
                  ),
                )
              ],
            ),
            Divider(thickness: 1,)
          ],
        ),
      ),
    );
  }
}
