import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/Cart.dart';
import 'package:book_buy_and_sell/UI/Activities/ChangePassword.dart';
import 'package:book_buy_and_sell/UI/Activities/EditProfile.dart';
import 'package:book_buy_and_sell/UI/Activities/MyBookList.dart';
import 'package:book_buy_and_sell/UI/Activities/Orders.dart';
import 'package:book_buy_and_sell/UI/Activities/Transactions.dart';
import 'package:book_buy_and_sell/UI/Activities/Wallet.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';

import 'WalletTrans.dart';

class Account extends StatefulWidget {
  const Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset('assets/icons/profile pic.png'),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 4,
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full Name",
                          style: TextStyle(
                              color: Color(matteBlack),
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.blockSizeVertical * 2),
                        ),
                        Text(
                          "Phone No.",
                          style: TextStyle(
                              color: Color(matteBlack),
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.blockSizeVertical * 1.75),
                        ),
                        Text(
                          "Location Name",
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
                                  fontSize: SizeConfig.blockSizeVertical * 1.5,
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
                style:
                    TextStyle(color: Color(black), fontWeight: FontWeight.w500),
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
                        "Cart",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                            fontWeight: FontWeight.w500,
                            color: Color(matteBlack)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.04),
                      leading: ImageIcon(
                        Image.asset('assets/icons/cart.png').image,
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
                          return Cart();
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
                      title: Text(
                        "My Book List",
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
                        "Wallet",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                            fontWeight: FontWeight.w500,
                            color: Color(matteBlack)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.04),
                      leading: ImageIcon(
                        Image.asset('assets/icons/wallet.png').image,
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
                          return WalletTrans();
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
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(colorBlue)),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "1",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize:
                                      SizeConfig.blockSizeVertical * 1.25),
                            ),
                          ),
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
                        "Offers",
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
    ));
  }
}
