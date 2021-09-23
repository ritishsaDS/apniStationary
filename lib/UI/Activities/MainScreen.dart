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
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
   setState(() {
     Constants.userlocation =  addresses[0].street.toString();

   });
    return addresses[0].street.toString();
  }

  bool isLoading = false;

  int currentIndex = 0;
  @override
  void initState() {
    _determinePosition();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(

          resizeToAvoidBottomInset: false,
          bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.05,
            vertical: SizeConfig.blockSizeVertical * 2),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), boxShadow: [
          BoxShadow(
              color: Colors.grey[300],
              spreadRadius: 2.0,
              blurRadius: 4.0),
        ]),
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
margin: EdgeInsets.only(top: 20),
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
          body: widgetOptions.elementAt(currentIndex),
    ));
  }
}
