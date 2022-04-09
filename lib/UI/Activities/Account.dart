import 'package:book_buy_and_sell/ChatUi/views/chatrooms.dart';
import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/Cart.dart';
import 'package:book_buy_and_sell/UI/Activities/ChangePassword.dart';
import 'package:book_buy_and_sell/UI/Activities/EditProfile.dart';
import 'package:book_buy_and_sell/UI/Activities/Login.dart';
import 'package:book_buy_and_sell/UI/Activities/MyBookList.dart';
import 'package:book_buy_and_sell/UI/Activities/Orders.dart';
import 'package:book_buy_and_sell/UI/Activities/Transactions.dart';
import 'package:book_buy_and_sell/UI/Activities/Wallet.dart';
import 'package:book_buy_and_sell/UI/Activities/WebViewPage.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/Utils/services/auth.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/services/AppNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

import '../../main.dart';
import '../orderrequest.dart';
import 'MainScreen.dart';
import 'WalletTrans.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';

class Account extends StatefulWidget {
  const Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final logout = GetStorage();
  Future<String> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    final location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var addresses =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    print("-------------------------------------------------");
    print(addresses);
    return addresses[0].street.toString();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      },
      child: SafeArea(
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          FutureBuilder(
                              future: _determinePosition(),
                              builder: (context, snapshot) {
                                // print("searchhhhh" + snapshot.data);
                                if (snapshot.hasData) {
                                  return GestureDetector(
                                    onTap: () async {
                                      Prediction p =
                                          await PlacesAutocomplete.show(
                                              context: context,
                                              apiKey: kGoogleApiKey,
                                              mode: Mode.overlay,
                                              // Mode.fullscreen
                                              language: "en",
                                              components: [
                                            new Component(
                                                Component.country, "in")
                                          ],
                                              types: []);
                                    },
                                    child: Text(
                                      snapshot.data,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Color(black)),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                          /* SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        ImageIcon(
                          AssetImage('assets/icons/current.png'),
                          color: Color(colorBlue),
                          size: SizeConfig.blockSizeVertical * 3,
                        )*/
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.08,
                    vertical: SizeConfig.blockSizeVertical * 2),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[200],
                          spreadRadius: 2.0,
                          blurRadius: 4.0),
                    ]),
                child: Row(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.23,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: PreferenceManager.getImage() != null
                            ? Image.network(PreferenceManager.getImage())
                            : Icon(
                                Icons.person_outline_rounded,
                                color: Color(colorBlue),
                                size: 60,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PreferenceManager.getName(),
                            style: TextStyle(
                                color: Color(matteBlack),
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.blockSizeVertical * 2),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            PreferenceManager.getPhoneNo(),
                            style: TextStyle(
                                color: Color(matteBlack),
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.blockSizeVertical * 1.75),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            PreferenceManager.getEmailId(),
                            style: TextStyle(
                                color: Color(matteBlack),
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.blockSizeVertical * 1.75),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return EditProfile();
                              }));
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical),
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    color: Color(colorBlue),
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 1.5,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
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
                  vertical: SizeConfig.blockSizeVertical * 2,
                ),
                child: Text(
                  "My Dashboard",
                  style: TextStyle(
                      color: Color(black), fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical * 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       boxShadow: [
                    //         BoxShadow(
                    //             color: Colors.grey[200],
                    //             blurRadius: 5,
                    //             spreadRadius: 2),
                    //       ],
                    //       borderRadius: BorderRadius.circular(15)),
                    //   margin: EdgeInsets.only(
                    //       bottom: SizeConfig.blockSizeVertical * 2),
                    //   child: ListTile(
                    //     title: Text(
                    //       "Cart",
                    //       style: TextStyle(
                    //           fontSize: SizeConfig.blockSizeVertical * 2,
                    //           fontWeight: FontWeight.w500,
                    //           color: Color(matteBlack)),
                    //     ),
                    //     contentPadding: EdgeInsets.symmetric(
                    //         horizontal: SizeConfig.screenWidth * 0.04),
                    //     leading: ImageIcon(
                    //       Image.asset('assets/icons/cart.png').image,
                    //       color: Color(colorBlue),
                    //     ),
                    //     trailing: Icon(
                    //       Icons.arrow_forward_ios_rounded,
                    //       color: Color(matteBlack),
                    //       size: SizeConfig.blockSizeVertical * 2.5,
                    //     ),
                    //     onTap: () {
                    //       Map<String, dynamic>   body = {
                    //         'senderId': 'UaBPR2fvSkw9FsRzksp2',
                    //         'receiverId': 'bkGnMUDMybaViNt2kPJw',
                    //         'img': "widget.img",
                    //         'userName': "widget.userName",
                    //       };
                    //       AppNotificationHandler.sendMessage(
                    //           msg: "message", data: body, token:"ebuUoLKZQsmLZSrteD4H--:APA91bGlq0TQRhL4Zk40OGYBJ0Q937mDTJmctlFUs54FJDlmKkApm5k6qbnG-rsO-kzoj8ZmyTZ6hGMctvewpJp-L2ifapekG4S92Q8JSTLlEMUeLjUCEnEpb-DK3ddMoR4eA1zMaOMS");
                    //       // Navigator.push(context,
                    //       //     MaterialPageRoute(builder: (context) {
                    //       //   return Cart();
                    //       // }));
                    //     },
                    //   ),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 5,
                                spreadRadius: 2),
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeVertical * 2),
                      child: ListTile(
                        title: Text(
                          "My Posts",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.w500,
                              color: Color(matteBlack)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.04),
                        leading: ImageIcon(
                          Image.asset('assets/icons/notes.png').image,
                          color: Color(colorBlue),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(matteBlack),
                          size: SizeConfig.blockSizeVertical * 2.5,
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MyBookList();
                          }));
                        },
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       boxShadow: [
                    //         BoxShadow(
                    //             color: Colors.grey[200],
                    //             blurRadius: 5,
                    //             spreadRadius: 2),
                    //       ],
                    //       borderRadius: BorderRadius.circular(15)),
                    //   margin: EdgeInsets.only(
                    //       bottom: SizeConfig.blockSizeVertical * 2),
                    //   child: ListTile(
                    //     title: Text(
                    //       "Wallet",
                    //       style: TextStyle(
                    //           fontSize: SizeConfig.blockSizeVertical * 2,
                    //           fontWeight: FontWeight.w500,
                    //           color: Color(matteBlack)),
                    //     ),
                    //     contentPadding: EdgeInsets.symmetric(
                    //         horizontal: SizeConfig.screenWidth * 0.04),
                    //     leading: ImageIcon(
                    //       Image.asset('assets/icons/wallet.png').image,
                    //       color: Color(colorBlue),
                    //     ),
                    //     trailing: Icon(
                    //       Icons.arrow_forward_ios_rounded,
                    //       color: Color(matteBlack),
                    //       size: SizeConfig.blockSizeVertical * 2.5,
                    //     ),
                    //     onTap: () {
                    //       Navigator.push(context,
                    //           MaterialPageRoute(builder: (context) {
                    //         return WalletTrans();
                    //       }));
                    //     },
                    //   ),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 5,
                                spreadRadius: 2),
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeVertical * 2),
                      child: ListTile(
                        title: Text(
                          "Transactions",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.w500,
                              color: Color(matteBlack)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.04),
                        leading: ImageIcon(
                          Image.asset('assets/icons/transactions.png').image,
                          color: Color(colorBlue),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(matteBlack),
                          size: SizeConfig.blockSizeVertical * 2.5,
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Transactions();
                          }));
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 5,
                                spreadRadius: 2),
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeVertical * 2),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Orders",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                  fontWeight: FontWeight.w500,
                                  color: Color(matteBlack)),
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       color: Color(colorBlue)),
                            //   padding: EdgeInsets.all(5),
                            //   child: Text(
                            //     "1",
                            //     style: TextStyle(
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.w500,
                            //         fontSize:
                            //             SizeConfig.blockSizeVertical * 1.25),
                            //   ),
                            // ),
                          ],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.04),
                        leading: ImageIcon(
                          Image.asset('assets/icons/orders.png').image,
                          color: Color(colorBlue),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(matteBlack),
                          size: SizeConfig.blockSizeVertical * 2.5,
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Orders();
                          }));
                        },
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       boxShadow: [
                    //         BoxShadow(
                    //             color: Colors.grey[200],
                    //             blurRadius: 5,
                    //             spreadRadius: 2),
                    //       ],
                    //       borderRadius: BorderRadius.circular(15)),
                    //   margin: EdgeInsets.only(
                    //       bottom: SizeConfig.blockSizeVertical * 2),
                    //   child: ListTile(
                    //     title: Text(
                    //       "Offers",
                    //       style: TextStyle(
                    //           fontSize: SizeConfig.blockSizeVertical * 2,
                    //           fontWeight: FontWeight.w500,
                    //           color: Color(matteBlack)),
                    //     ),
                    //     contentPadding: EdgeInsets.symmetric(
                    //         horizontal: SizeConfig.screenWidth * 0.04),
                    //     leading: ImageIcon(
                    //       Image.asset('assets/icons/offer.png').image,
                    //       color: Color(colorBlue),
                    //     ),
                    //     trailing: Icon(
                    //       Icons.arrow_forward_ios_rounded,
                    //       color: Color(matteBlack),
                    //       size: SizeConfig.blockSizeVertical * 2.5,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 5,
                                spreadRadius: 2),
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeVertical * 2),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Orderrequest()));
                        },
                        title: Text(
                          "Order Requests",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.w500,
                              color: Color(matteBlack)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.04),
                        leading: ImageIcon(
                          Image.asset('assets/icons/offer.png').image,
                          color: Color(colorBlue),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(matteBlack),
                          size: SizeConfig.blockSizeVertical * 2.5,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 5,
                                spreadRadius: 2),
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeVertical * 2),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WebViewPage(
                                        title: "Contact us",
                                        url: contactUsURL)));
                        },
                        title: Text(
                          "Help & Support",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.w500,
                              color: Color(matteBlack)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.04),
                        leading: ImageIcon(
                          Image.asset('assets/icons/help.png').image,
                          color: Color(colorBlue),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(matteBlack),
                          size: SizeConfig.blockSizeVertical * 2.5,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 5,
                                spreadRadius: 2),
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeVertical * 2),
                      child: ListTile(
                        title: Text(
                          "Share with Friends",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.w500,
                              color: Color(matteBlack)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.04),
                        leading: ImageIcon(
                          Image.asset('assets/icons/share.png').image,
                          color: Color(colorBlue),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(matteBlack),
                          size: SizeConfig.blockSizeVertical * 2.5,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 5,
                                spreadRadius: 2),
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeVertical * 2),
                      child: ListTile(
                        title: Text(
                          "Change Password",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.w500,
                              color: Color(matteBlack)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.04),
                        leading: Icon(
                          Icons.vpn_key,
                          color: Color(colorBlue),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(matteBlack),
                          size: SizeConfig.blockSizeVertical * 2.5,
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChangePassword();
                          }));
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 5,
                                spreadRadius: 2),
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeVertical * 2),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatRoom()));
                        },
                        title: Text(
                          "Chats",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.w500,
                              color: Color(matteBlack)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.04),
                        leading: Icon(
                          Icons.chat_bubble,
                          color: Colors.blue,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(matteBlack),
                          size: SizeConfig.blockSizeVertical * 2.5,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 5,
                                spreadRadius: 2),
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeVertical * 2),
                      child: ListTile(
                        onTap: () {
                          return showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text("Logout"),
                              content: Text("Are you sure you want to logout"),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    AuthService().signOut();
                                    logout.remove("email_id");
                                    logout.remove("name");
                                    PreferenceManager.clearData();
                                    GetStorage().erase();
                                    logout.remove("userfirebasetoken");
                                    logout.remove("userfirebasetokens");
                                    logout.remove("userfirebaseid");

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child: Text("Yes"),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No"),
                                ),
                              ],
                            ),
                          );
                        },
                        title: Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.w500,
                              color: Color(matteBlack)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.04),
                        leading: ImageIcon(
                          Image.asset('assets/icons/logout.png').image,
                          color: Color(colorBlue),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(matteBlack),
                          size: SizeConfig.blockSizeVertical * 2.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
