import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/Account.dart';
import 'package:book_buy_and_sell/UI/Activities/Cart.dart';
import 'package:book_buy_and_sell/UI/Activities/Home.dart';
import 'package:book_buy_and_sell/UI/Activities/Offers.dart';
import 'package:book_buy_and_sell/UI/Activities/Orders.dart';
import 'package:book_buy_and_sell/UI/Activities/Sell.dart';
import 'package:book_buy_and_sell/UI/Activities/Transactions.dart';
import 'package:book_buy_and_sell/UI/Activities/Wallet.dart';
import 'package:book_buy_and_sell/UI/Activities/WalletTrans.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> widgetOptions = <Widget>[
    Home(),
   // Wallet(),
    WalletTrans(),
    Cart(),
    Account(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(backgroundColor),
          bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.05,
            vertical: SizeConfig.blockSizeVertical * 2),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(35)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            unselectedItemColor: Color(0XFFBABCC3),
            selectedItemColor: Color(colorBlue),
            showUnselectedLabels: true,
            showSelectedLabels: true,
            elevation: 0.0,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  Image.asset('assets/icons/home.png').image,
                  size: SizeConfig.blockSizeVertical * 3,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                      color: Color(matteBlack),
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.blockSizeVertical * 1.4),
                ),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  Image.asset('assets/icons/wallet.png').image,
                  size: SizeConfig.blockSizeVertical * 3,
                ),
                title: Text(
                  "Wallet",
                  style: TextStyle(
                      color: Color(matteBlack),
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.blockSizeVertical * 1.4),
                ),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  Image.asset('assets/icons/cart.png').image,
                  size: SizeConfig.blockSizeVertical * 3,
                ),
                title: Text(
                  "Cart",
                  style: TextStyle(
                      color: Color(matteBlack),
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.blockSizeVertical * 1.4),
                ),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  Image.asset('assets/icons/account.png').image,
                  size: SizeConfig.blockSizeVertical * 3,
                ),
                title: Text(
                  "Account",
                  style: TextStyle(
                      color: Color(matteBlack),
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.blockSizeVertical * 1.4),
                ),
              ),
            ],
          ),
        ),
      ),
          floatingActionButton: Container(
            height: SizeConfig.blockSizeVertical * 8,
            decoration: BoxDecoration(
            border: Border.all(color: Color(colorBlue), width: 4),
            shape: BoxShape.circle),
            child: FloatingActionButton(
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Sell();
            }));
            },
              child: Image.asset(
            'assets/icons/fbtn.png',
            height: SizeConfig.blockSizeVertical * 5,
          ),
          backgroundColor: Colors.white,
        ),
      ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          drawer: Drawer(
        elevation: 0.0,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 1.5,
                    horizontal: SizeConfig.blockSizeHorizontal * 4),
                child: ImageIcon(
                  Image.asset(
                    'assets/icons/drawer.png',
                  ).image,
                  color: Color(colorBlue),
                  size: SizeConfig.blockSizeVertical * 4,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.23,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset('assets/icons/profile pic.png'),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.4,
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
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 4),
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                  color: Color(colorBlue),
                                  fontSize: SizeConfig.blockSizeVertical * 1.25,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                    ListTile(
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
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Cart();
                        }));
                      },
                    ),
                    ListTile(
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
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return WalletTrans();
                        }));
                      },
                    ),
                    ListTile(
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
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Transactions();
                        }));
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Orders",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                            fontWeight: FontWeight.w500,
                            color: Color(matteBlack)),
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
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Orders();
                        }));
                      },
                    ),
                    ListTile(
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
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Offers();
                        }));
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Notification",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                            fontWeight: FontWeight.w500,
                            color: Color(matteBlack)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.04),
                      leading: ImageIcon(
                        Image.asset('assets/icons/notification.png').image,
                        color: Color(colorBlue),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(matteBlack),
                        size: SizeConfig.blockSizeVertical * 2.5,
                      ),
                    ),
                    ListTile(
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
                    ListTile(
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
                    ListTile(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
          body: widgetOptions.elementAt(currentIndex),
    ));
  }
}
