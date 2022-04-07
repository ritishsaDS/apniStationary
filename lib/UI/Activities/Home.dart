import 'dart:convert';
import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:book_buy_and_sell/ChatUi/views/chat.dart';
import 'package:book_buy_and_sell/ChatUi/views/chatrooms.dart';
import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/UI/Activities/Categories.dart';
import 'package:book_buy_and_sell/UI/Activities/MainScreen.dart';
import 'package:book_buy_and_sell/UI/Activities/SubCategory.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/Dialog.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/commonLV.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/Utils/services/auth.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/ClassModel/BookListModel.dart';
import 'package:book_buy_and_sell/model/ClassModel/SliderModel.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/CategoriesResponseModel.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/MyBooksModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../main.dart';
import '../orderrequest.dart';
import 'Cart.dart';
import 'EditProfile.dart';
import 'Login.dart';
import 'NotificationScreen.dart';
import 'Offers.dart';
import 'Orders.dart';
import 'PendingRequests.dart';
import 'SelectedBook.dart';
import 'Transactions.dart';
import 'WalletTrans.dart';
import 'buyOrderDetail.dart';
import 'loadershow.dart';
import 'mobile.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchField = new TextEditingController();
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
bool nofication=true;
  bool  isLoading=false;
  final logout=GetStorage();
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  var notificationcoint=0;
  var notificationremain=0;
  var notificationleft=0;
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
  String resultText = "";
  @override
  void initState() {

    getOrderedbooks();

    getfeaturedmatches();
    getprofile();
    print("---------------"+Constants.userlocation.toString());
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState((){
            resultText = speech;
                _searchField=TextEditingController(text:resultText);
                if(resultText==''){}
                else{
                  Future.delayed(const Duration(milliseconds: 3000), () {
                    _isListening=false;
                    _isAvailable=false;
                    _fieldFocusChange(context);
// Here you can write your code

                    setState(() {
                      // Here you can write your code for open new view
                    });

                  });

                }

          }),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() {
            print("khatam"+resultText);
            _isListening = false;
            if(resultText==''||resultText.isEmpty){}
            else{
              //_fieldFocusChange(context);
            }
          }),
    );

    _speechRecognition.activate().then(
          (result) => setState(() {
            _isAvailable = result;
                print(_isAvailable.toString());
          }
          ),
    );
    getCategory();
    getbooklist();

    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: (){
        SystemNavigator.pop();
      },
      child: Scaffold(
        key: _scaffoldKey,
resizeToAvoidBottomInset: false,
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
                  // height: SizeConfig.blockSizeVertical*10,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child:PreferenceManager.getImage()!=null?Image.network(PreferenceManager.getImage()): Icon(Icons.person_outline_rounded, color: Color(colorBlue),
                            size: 60,),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              PreferenceManager.getName(),maxLines: 1,overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color(matteBlack),
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.blockSizeVertical * 2),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              PreferenceManager.getPhoneNo(),
                              style: TextStyle(
                                  color: Color(matteBlack),
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.blockSizeVertical * 1.75),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return EditProfile();
                                    }));
                              },
                              child: Container(
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
                      // ListTile(
                      //   title: Text(
                      //     "Cart",
                      //     style: TextStyle(
                      //         fontSize: SizeConfig.blockSizeVertical * 2,
                      //         fontWeight: FontWeight.w500,
                      //         color: Color(matteBlack)),
                      //   ),
                      //   contentPadding: EdgeInsets.symmetric(
                      //       horizontal: SizeConfig.screenWidth * 0.04),
                      //   leading: ImageIcon(
                      //     Image.asset('assets/icons/cart.png').image,
                      //     color: Color(colorBlue),
                      //   ),
                      //   trailing: Icon(
                      //     Icons.arrow_forward_ios_rounded,
                      //     color: Color(matteBlack),
                      //     size: SizeConfig.blockSizeVertical * 2.5,
                      //   ),
                      //   onTap: (){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context){
                      //       return Cart();
                      //     }));
                      //   },
                      // ),
                      // ListTile(
                      //   title: Text(
                      //     "Wallet",
                      //     style: TextStyle(
                      //         fontSize: SizeConfig.blockSizeVertical * 2,
                      //         fontWeight: FontWeight.w500,
                      //         color: Color(matteBlack)),
                      //   ),
                      //   contentPadding: EdgeInsets.symmetric(
                      //       horizontal: SizeConfig.screenWidth * 0.04),
                      //   leading: ImageIcon(
                      //     Image.asset('assets/icons/wallet.png').image,
                      //     color: Color(colorBlue),
                      //   ),
                      //   trailing: Icon(
                      //     Icons.arrow_forward_ios_rounded,
                      //     color: Color(matteBlack),
                      //     size: SizeConfig.blockSizeVertical * 2.5,
                      //   ),
                      //   onTap: (){
                      //
                      //     Navigator.push(context, MaterialPageRoute(builder: (context){
                      //       return WalletTrans();
                      //     }));
                      //   },
                      // ),
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
                      // ListTile(
                      //   title: Text(
                      //     "My Orders",
                      //     style: TextStyle(
                      //         fontSize: SizeConfig.blockSizeVertical * 2,
                      //         fontWeight: FontWeight.w500,
                      //         color: Color(matteBlack)),
                      //   ),
                      //   contentPadding: EdgeInsets.symmetric(
                      //       horizontal: SizeConfig.screenWidth * 0.04),
                      //   leading: ImageIcon(
                      //     Image.asset('assets/icons/orders.png').image,
                      //     color: Color(colorBlue),
                      //   ),
                      //   trailing: Icon(
                      //     Icons.arrow_forward_ios_rounded,
                      //     color: Color(matteBlack),
                      //     size: SizeConfig.blockSizeVertical * 2.5,
                      //   ),
                      //   onTap: (){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context){
                      //       return Orders();
                      //     }));
                      //   },
                      // ),
                      ListTile(
                        title: Text(
                          "My Orders Request",
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
                            return Orderrequest();
                          }));
                        },
                      ),
                      // ListTile(
                      //   title: Text(
                      //     "Offers",
                      //     style: TextStyle(
                      //         fontSize: SizeConfig.blockSizeVertical * 2,
                      //         fontWeight: FontWeight.w500,
                      //         color: Color(matteBlack)),
                      //   ),
                      //   contentPadding: EdgeInsets.symmetric(
                      //       horizontal: SizeConfig.screenWidth * 0.04),
                      //   leading: ImageIcon(
                      //     Image.asset('assets/icons/offer.png').image,
                      //     color: Color(colorBlue),
                      //   ),
                      //   trailing: Icon(
                      //     Icons.arrow_forward_ios_rounded,
                      //     color: Color(matteBlack),
                      //     size: SizeConfig.blockSizeVertical * 2.5,
                      //   ),
                      //   onTap: (){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context){
                      //       return Offers();
                      //     }));
                      //   },
                      // ),
                      // ListTile(
                      //   title: Text(
                      //     "Notification",
                      //     style: TextStyle(
                      //         fontSize: SizeConfig.blockSizeVertical * 2,
                      //         fontWeight: FontWeight.w500,
                      //         color: Color(matteBlack)),
                      //   ),
                      //   contentPadding: EdgeInsets.symmetric(
                      //       horizontal: SizeConfig.screenWidth * 0.04),
                      //   leading: ImageIcon(
                      //     Image.asset('assets/icons/notification.png').image,
                      //     color: Color(colorBlue),
                      //   ),
                      //   trailing: Icon(
                      //     Icons.arrow_forward_ios_rounded,
                      //     color: Color(matteBlack),
                      //     size: SizeConfig.blockSizeVertical * 2.5,
                      //   ),
                      // ),
                      ListTile(
                        title: Text(
                          "Chat",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.w500,
                              color: Color(matteBlack)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.04),
                        leading: ImageIcon(
                          Image.asset('assets/icons/chat.png').image,
                          color: Color(colorBlue),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(matteBlack),
                          size: SizeConfig.blockSizeVertical * 2.5,
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ChatRoom();
                          }));
                        },
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
                        onTap: (){
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
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

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

        body: Container(
          child: SingleChildScrollView(
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
                      GestureDetector(
                        onTap: () =>_scaffoldKey.currentState.openDrawer()

                        ,
                        child: ImageIcon(
                          AssetImage('assets/icons/drawer.png'),
                          color: Color(colorBlue),
                          size: SizeConfig.blockSizeVertical * 4,
                        ),
                      ),
                      Row(
                        children: [
                          FutureBuilder(

                              future: _determinePosition(),
                              builder: (context, snapshot) {

                                if (snapshot.hasData) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width*0.7,
                                    child: GestureDetector(
                                      onTap: () async {
                                        // Prediction p =
                                        // await PlacesAutocomplete.show(
                                        //     context: context,
                                        //     apiKey: kGoogleApiKey,
                                        //     mode: Mode.overlay,
                                        //     // Mode.fullscreen
                                        //     language: "en",
                                        //     components: [
                                        //       new Component(
                                        //           Component.country, "in")
                                        //     ],
                                        //     types: []);
                                      },
                                      child: Text(
                                        snapshot.data,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Color(black)),
                                      ),
                                    ),
                                  );
                                }
                                else {
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
                      Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: (){
setState(() {
  nofication=false;
});
                          PreferenceManager.setnotificationzero(notif.length.toString());
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                        },
                        child: Stack(
                          children: [
                            ImageIcon(

                            AssetImage('assets/icons/notification.png'),
                        color: Color(colorBlue),
                        size: SizeConfig.blockSizeVertical * 4,
                      )
                            ,
                            notificationleft<=0?SizedBox():

                        Positioned(
                                  top:0,
                                  right: 0,
                                  child:  Visibility(
                                    visible: nofication,
                                    maintainState: nofication,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.red,child: Text(notificationleft.toString(),style: TextStyle(fontSize: 10,color: Colors.white),),),
                                  ),
      ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                      vertical: SizeConfig.blockSizeVertical),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color(colorBlue))),
                  child: Row(
                    children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.8,
                        child: TextFormField(
                          controller: _searchField,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            suffixIcon:  speechButton(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.blockSizeVertical * 2,
                                horizontal: 5
                                  ),
                              hintText: "Search an item/Institute name",
                              hintStyle: TextStyle(
                                color: Color(hintGrey),
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none),
                          onFieldSubmitted: (val){
                            _fieldFocusChange(context);
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_searchField.text != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SelectedBook(
                                      searchedWord: _searchField.text,catId: "",);
                                },
                              ),
                            );
                          } else {
                            showAlert(context, "Search Item cannot be empty");
                          }
                        },
                        child: Icon(
                          Icons.search,
                          color: Color(colorBlue),
                        ),
                      ),
                    ],
                  ),
                ),
                _getSliders(),
                cartdata==null||cartdata.length==0?SizedBox(): Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueGrey)

                  ),
                  margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(8),
                  child:

                  Column(children: [
                    Row(children: [
                      Container(
                        height:10,
                        width: 10,
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue),

                      ),
                      Container(
                        height:5,
                        width: SizeConfig.blockSizeHorizontal*30,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Colors.blue,),

                      ),
                      Container(
                        height:10,
                        width: 10,
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue),

                      ),
                      Container(
                        height:5,
                        width: SizeConfig.blockSizeHorizontal*30,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Colors.blue,),

                      ),
                      Container(
                        height:10,
                        width: 10,
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blueGrey),

                      ),
                      Container(
                        height:5,
                        width: SizeConfig.blockSizeHorizontal*25,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Colors.blueGrey,),

                      ),
                    ],),
                    Row(children: [
                      Container(
                        height:10,
                        width: 10,
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue),

                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal*30,
                       child: Text("Order Accepted",style: TextStyle(fontSize: 12),),

                      ),

                      Container(
                        height:10,
                        width: 10,
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue),

                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal*30,
                        child: Text("Order in transit",style: TextStyle(fontSize: 12)),

                      ),
                      Container(
                        height:10,
                        width: 10,
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blueGrey),

                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal*25,
                        child: Text("Order Delivered",style: TextStyle(fontSize: 12)),

                      ),
                    ],),
                    Container(
                      child: Card(
elevation: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)
                                ),
                                child: Image.network("http://admin.apnistationary.com/img/books/"+cartdata[0]['book_image'])),

                           SizedBox(width: 20,),
                            Column(
                              children: [
                                Container(child: Text(
                                    cartdata[0]['book_name']
                                ),),
                                Container(child: Text(
                                    rs+" "+ cartdata[0]['price'].toString()
                                ),),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      //generateInvoice();
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return BuyOrderdeatil();
                                          }));
                                      //getbookdetail(snapshot.data.date[index].order_id);

                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius
                                              .circular(10),
                                          color: (Colors.lightBlue)
                                      ),
                                      child: Text(
                                        "View All >>",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize:
                                            SizeConfig.blockSizeVertical *
                                                1.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                            // InkWell(
                            //     onTap: () {
                            //       Navigator.push(context,
                            //           MaterialPageRoute(builder: (context) {
                            //             return BuyOrderdeatil();
                            //           }));
                            //     },
                            //     child: Row(
                            //       children: [
                            //         Text("View All"),
                            //         Icon(Icons.double_arrow,
                            //             color: Color(colorBlue),
                            //             size: SizeConfig.blockSizeVertical * 2.5),
                            //       ],
                            //     ))
                          ],
                        ),
                      ),
                    ),
                  ],)
                ),
                Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05,
                        vertical: SizeConfig.blockSizeVertical),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Categories",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(black)),
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.2,
                                height: SizeConfig.blockSizeVertical * 0.2,
                                decoration: BoxDecoration(color: Color(colorBlue)),
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Categories();
                                }));
                              },
                              child: Icon(Icons.double_arrow,
                                  color: Color(colorBlue),
                                  size: SizeConfig.blockSizeVertical * 2.5))
                        ])),
                Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.16,

                    child:isLoading?Center(child: CircularProgressIndicator(),): ListView(
                      scrollDirection: Axis.horizontal,
                      children: getallcategory(),)),
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                      vertical: SizeConfig.blockSizeVertical),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nearby Products",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, color: Color(black)),
                          ),
                          Container(
                            width: 120,
                            height: SizeConfig.blockSizeVertical * 0.2,
                            decoration: BoxDecoration(color: Color(colorBlue)),
                          ),
                        ],
                      ),
                      // Icon(
                      //   Icons.double_arrow,
                      //   color: Color(colorBlue),
                      //   size: SizeConfig.blockSizeVertical * 2.5,
                      // ),
                    ],
                  ),
                ),
                _getBookList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSliders() {
    return FutureBuilder<List<SliderDataModel>>(
        future: _callSliderAPI(),
        builder: (context, AsyncSnapshot<List<SliderDataModel>> snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              options: CarouselOptions(height: 150,autoPlay: true),
              items: snapshot.data.map((slider) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.01,
                          vertical: SizeConfig.blockSizeVertical),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                          child: Image.network(slider.image,fit: BoxFit.fill,),
                          borderRadius: BorderRadius.circular(15)),
                    );
                  },
                );
              }).toList(),
            );
          } else {
            return Container();
          }
        });
  }




  /*
                  child: ListView.builder(
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SubCategory(
                            text: text[index],
                            img: assetImages[index],
                          );
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeHorizontal * 2,
                            vertical: SizeConfig.blockSizeVertical),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        spreadRadius: 1,
                                        blurRadius: 3)
                                  ]),
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical),
                              child: ImageIcon(
                                AssetImage(
                                  assetImages[index],
                                ),
                                size: SizeConfig.blockSizeVertical * 5,
                                color: Color(colorBlue),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.2,
                              alignment: Alignment.center,
                              child: Text(
                                text[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF06070D),
                                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: assetImages.length,
                  scrollDirection: Axis.horizontal,
                )),

  */

  Widget _getBookList() {
    return FutureBuilder<BookListModel>(
        future: ApiCall.callBookListAPI("",""),
        builder: (context, AsyncSnapshot<BookListModel> snapshot) {
          if (snapshot.hasData) {
            return

              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    vertical: SizeConfig.blockSizeVertical),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 4 / 4.5,
                      crossAxisCount: 2,
                      crossAxisSpacing: SizeConfig.blockSizeHorizontal * 0.5,
                      mainAxisSpacing: SizeConfig.blockSizeVertical * 2),
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BookDetail(
                              snapshot.data.date[index].id.toString());
                        }));
                      },
                      child: Container(
                        child:
                          Card(
                            child: Align(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15)),
                                        ),

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: SizeConfig.screenHeight*0.16,
                                          width: SizeConfig.blockSizeVertical * 50,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15)),
                                            child: Image.network(snapshot.data.image_url +
                                                "/" +
                                                snapshot.data.date[index].image1,fit: BoxFit.fill,),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: SizeConfig.blockSizeHorizontal * 2),
                                          child: Text(
                                            snapshot.data.date[index].name,maxLines: 1,
                                            style: TextStyle(
                                                color: Color(0XFF06070D),
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                SizeConfig.blockSizeVertical * 1.5),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: SizeConfig.blockSizeHorizontal * 2,
                                              right:
                                              SizeConfig.blockSizeHorizontal * 2),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data.date[index].auther_name,
                                                style: TextStyle(
                                                    color: Color(0XFF656565),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                    SizeConfig.blockSizeVertical *
                                                        1.25),
                                              ),
                                              Text(
                                                snapshot
                                                    .data.date[index].conditions,
                                                maxLines: 2,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                    SizeConfig.blockSizeVertical *
                                                        1.25),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal * 4,
                                            bottom: SizeConfig.blockSizeVertical),
                                        child: Text(
                                          "$rs ${snapshot.data.date[index].price.toString()}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right:
                                                SizeConfig.blockSizeHorizontal * 4,
                                            bottom: SizeConfig.blockSizeVertical),
                                        child: Text(
                                          "Buy Now",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              alignment: Alignment.bottomCenter,
                            ),
                            color: Color(colorBlue),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 5.0,
                          ),

                      ),
                    );
                  },
                  itemCount: snapshot.data.date.length,
                  shrinkWrap: true,
                  primary: false,
                ));
          } else {
            return Container();
          }
        });
  }

  Future<List<SliderDataModel>> _callSliderAPI() async {
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
    };

    var res = await ApiCall.post(sliderURL, body);

    var jsonResponse = json.decode(json.encode(res).toString());

    var data = new SliderModel.fromJson(jsonResponse);
    return data.SliderData;
  }
  _fieldFocusChange(BuildContext context) {
    if (_searchField.text != "") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SelectedBook(
              searchedWord: _searchField.text, catId: "",);
          },
        ),
      );
    } else {
      showAlert(context, "Search Item cannot be empty");
    }
  }
dynamic categorylist=new List();
  Future<void> getCategory() async {
    print("jh dhic ibcdofn");
    isLoading=true;
    try {
      final response = await post(Uri.parse("https://admin.apnistationary.com/api/category"),
          body: {
        "user_id":PreferenceManager.getUserId().toString(),
            "session_key":PreferenceManager.getSessionKey().toString(),

            "parent_id": "0"}
            );
print("responsestauus codee"+response.statusCode.toString());
      if (response.statusCode == 256) {
        final responseJson = json.decode(response.body);
        setState(() {
          isLoading=false;
          categorylist=responseJson['category_data'];
          print("category"+responseJson.toString());

      });} else {
        print("bjkb" + response.statusCode.toString());

        setState(() {
        // isError = true;
        // isLoading = false;
        });
        }
        } catch (e) {
      print("uhdfuhdfuh"+e.toString());
      setState(() {
        // isError = true;
        // isLoading = false;
      });
    }

  }
  dynamic userdetail=new List();
  Future<void> getprofile() async {
    isLoading=true;
    try {
      final response = await post(Uri.parse("https://admin.apnistationary.com/api/user-data"),
          body: {"user_id":PreferenceManager.getUserId().toString(),
            "session_key":PreferenceManager.getSessionKey().toString()});

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        setState(() async {
          isLoading=false;
          print(responseJson);
          userdetail=responseJson;
          print(userdetail['user']['dob']);
          await PreferenceManager.setImage(
              userdetail['user']['image']);
        });

      } else {
        print("bjkb" + response.statusCode.toString());

        setState(() {
          // isError = true;
          // isLoading = false;
        });
      }
    } catch (e) {
      print("uhdfuhdfuh"+e.toString());
      setState(() {
        // isError = true;
        // isLoading = false;
      });
    }
  }
  List<Widget>getallcategory() {
    List<Widget> newcatgorylist = new List();
    for (int index = 0; index < categorylist.length; index++) {
      newcatgorylist.add(
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return categorylist[index]['subcategory'] == "Yes"
                      ? SubCategory(
                      id: categorylist[index]['id'],
                      text: categorylist[index]['name'],
                      img: categorylist[index]['image'])
                      : SelectedBook(searchedWord: "",
                      catId: categorylist[index]['id'].toString());
                }));
              },
              child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: SizeConfig.blockSizeHorizontal*25,
                          height: SizeConfig.blockSizeVertical*9,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: NetworkImage(
                                  categorylist[index]['image']),),
                              //borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 3)
                              ]),
                          //  padding: EdgeInsets.all(15),
                          // margin: EdgeInsets.only(
                          //     bottom: SizeConfig.blockSizeVertical),


                        ),

                        SizedBox(height: 10,),
                        Container(
                            width: SizeConfig.screenWidth * 0.25,
                            alignment: Alignment.center,
                            child: Text(
                              categorylist[index]['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0XFF06070D),
                                  fontSize: 10),
                              textAlign: TextAlign.center,
                            ))
                      ])))
      );
    }
    return newcatgorylist;
  }
  dynamic cartdata = new List();
  dynamic bookdata = new List();
  void getOrderedbooks() async {

    setState(() {
      // Dialogs.showLoadingDialog(context, loginLoader);
      isLoading = true;
    });


    try {
      final response = await post(
          Uri.parse(
              "https://admin.apnistationary.com/api/myOrderList"),body: (
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
          // Navigator.of(loginLoader.currentContext,
          //     rootNavigator: true) .pop();


          isLoading = false;
          print('setstate'+cartdata.toString());
        });


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
  void getbooklist() async {
    setState(() {
      isLoading = true;
    });


    try {
      final response = await post(
          Uri.parse(
              "https://admin.apnistationary.com/api/book-list"),body: (
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
          bookdata=responseJson['date'];


for(int i=0;i<bookdata.length;i++){
  if(bookdata[i]["is_buy"]=="yes"&&bookdata[i]['user_id']==PreferenceManager.getUserId()){

    showAcceptAlert(context,bookdata[i]["name"],bookdata[i]['id'],i);
  }
}
          isLoading = false;
          print('setstate'+cartdata.toString());
        });


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
  void updatebook(id) async {
    setState(() {
      isLoading = true;
    });


    try {
      final response = await post(
          Uri.parse(
              "https://admin.apnistationary.com/api/updateBookStatus"),body: (
          {
            "user_id" : "${PreferenceManager.getUserId()}",
            "session_key": PreferenceManager.getSessionKey(),
            "book_id": id.toString(),
            "is_buy": "no",
          }
      ));
      print("ffvvvf");
      if (response.statusCode == 256) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        setState(() {



          isLoading = false;
          print('setstate');
        });


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
  dynamic notif=new List();
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
          notif=responseJson['data'];
          PreferenceManager.setNotificayioncount(notif.length.toString());
          notificationcoint=int.parse(notif.length.toString());
          if( PreferenceManager.getnotificationzero()==null){
            notificationremain=0;
          }
          else{
            notificationremain=int.parse(PreferenceManager.getnotificationzero());
          }
          notificationleft=notificationcoint-notificationremain;
          isLoading = false;
          print('setstate'+notif.toString());
        });


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

  speechButton() =>
      AvatarGlow(
    animate: _isListening,
    glowColor: Theme.of(context).primaryColor,
    endRadius: 30.0,
    duration: const Duration(milliseconds: 2000),
    repeatPauseDuration: const Duration(milliseconds: 100),
    repeat: true,
    showTwoGlows: true,
    child: Container(
height: 50,
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: (){
          print("klmfmvko");
          _speechRecognition = SpeechRecognition();

          _speechRecognition.setAvailabilityHandler(
                (bool result) => setState(() => _isAvailable = result),
          );

          _speechRecognition.setRecognitionStartedHandler(
                () => setState(() => _isListening = true),
          );

          _speechRecognition.setRecognitionResultHandler(
                (String speech) => setState((){
              resultText = speech;
              _searchField=TextEditingController(text:resultText);
              if(resultText==''){}
              else{
                Future.delayed(const Duration(milliseconds: 5000), () {
                  setState(() {
                    _isAvailable=false;
                    _isListening=false;
                  });
                  _fieldFocusChange(context);
// Here you can write your code

                  setState(() {
                    // Here you can write your code for open new view
                  });

                });

              }

            }),
          );

          _speechRecognition.setRecognitionCompleteHandler(
                () => setState(() {
              print("khatam"+resultText);
              _isListening = false;
              if(resultText==''||resultText.isEmpty){}
              else{
                //_fieldFocusChange(context);
              }
            }),
          );

          _speechRecognition.activate().then(
                (result) => setState(() {
              _isAvailable = result;
              print(_isAvailable.toString());
            }
            ),
          );
          print(_isAvailable);
          if (_isAvailable && !_isListening)
            _speechRecognition
                .listen(locale: "en_IN")
                .then((result) {
              setState(() {


              });
            });
        },
        child: CircleAvatar(
            radius: 15,
            backgroundColor:Colors.blue,child: Icon(Icons.mic,color: Colors.white,size: 12,)),
      ),


      ),
  )
  ;
  showAcceptAlert(BuildContext context,name,id,index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text("Your Book ${name} is ordered , You Want to delete this book"),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                print("-------"+id.toString());
                Navigator.pop(context);
                updatebook(id);
                ///AcceptOrder(orderid,firebaseid);
              },
            ),
            FlatButton(
              child: Text('Delete, My Post'),
              onPressed: () {
                //Navigator.pop(context);
                deleteBookAPI(id,index);

              },
            ),
          ],
        );
      },
    );
  }
  List<MyBooksModel> myBooksModel;
  deleteBookAPI(book_id,index) async {
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "id": "$book_id",
    };

    var res = await ApiCall.apiCall(bookDeleteURL, body);
    log("message $res");

    setState(() {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
    });
  }
  // Future<void> generateInvoice() async {
  //   //Create a PDF document.
  //   final PdfDocument document = PdfDocument();
  //   //Add page to the PDF
  //   final PdfPage page = document.pages.add();
  //   final PdfPage pagess = document.pages.add();
  //   //Get page client size
  //   final Size pageSize = page.getClientSize();
  //   final Size pageSizes = pagess.getClientSize();
  //   //Draw rectangle
  //
  //   page.graphics.drawRectangle(
  //       bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
  //       pen: PdfPen(PdfColor(142, 170, 219, 255)));
  //   //Generate PDF grid.
  //   final PdfGrid grid = getGrid();
  //   //Draw the header section by creating text element
  //   final PdfLayoutResult result = drawHeader(page, pageSize, grid);
  //   //Draw grid
  //   drawGrid(page, grid, result);
  //   //Add invoice footer
  //   drawFooter(page, pageSize);
  //   //Save the PDF document
  //   final List<int> bytes = document.save();
  //   await saveAndLaunchFile(bytes, 'Invoice.pdf');
  //   //Dispose the document.
  //
  //   //Save and launch the file.
  //
  //   pagess.graphics.drawRectangle(
  //       bounds: Rect.fromLTWH(0, 0, pageSizes.width, pageSizes.height),
  //       pen: PdfPen(PdfColor(142, 170, 219, 255)));
  //   //Generate PDF grid.
  //   final PdfGrid grids = getGrid();
  //   //Draw the header section by creating text element
  //
  //   //Draw grid
  //   drawGrid(pagess, grids, result);
  //   //Add invoice footer
  //   drawFooter(pagess, pageSize);
  //   //Save the PDF document
  //
  //   //Dispose the document.
  //   document.dispose();
  //
  //   //Save and launch the file.
  //
  // }

  //Draws the invoice header

}