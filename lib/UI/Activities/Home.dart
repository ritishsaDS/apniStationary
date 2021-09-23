import 'dart:convert';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/UI/Activities/Categories.dart';
import 'package:book_buy_and_sell/UI/Activities/SubCategory.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
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
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import 'Cart.dart';
import 'Login.dart';
import 'Offers.dart';
import 'Orders.dart';
import 'SelectedBook.dart';
import 'Transactions.dart';
import 'WalletTrans.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchField = new TextEditingController();
bool  isLoading=false;
  final logout=GetStorage();

  @override
  void initState() {
    getCategory();
    // TODO: implement initState
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
                height: SizeConfig.blockSizeVertical*10,
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
                            PreferenceManager.getName(),
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
                      onTap: (){
                        AuthService().signOut();
                        logout.remove("email_id");
                        logout.remove("name");
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

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

      body: SafeArea(
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
                    Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 5,
                         ),
                      child: Row(
                        children: [
                          Text(
                            Constants.userlocation.toString(),
                            style: TextStyle(color: Color(black)),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          // ImageIcon(
                          //   AssetImage('assets/icons/current.png'),
                          //   color: Color(colorBlue),
                          //   size: SizeConfig.blockSizeVertical * 3,
                          // )
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
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
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 1.5,
                                horizontal: SizeConfig.blockSizeHorizontal * 5),
                            hintText: "Search an item",
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
                          CommonSnackBar.snackBar(
                              message: "Search Item cannot be empty");
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
                            child: Icon(Icons.arrow_forward_ios_rounded,
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
                          "Book List",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Color(black)),
                        ),
                        Container(
                          width: 80,
                          height: SizeConfig.blockSizeVertical * 0.2,
                          decoration: BoxDecoration(color: Color(colorBlue)),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(colorBlue),
                      size: SizeConfig.blockSizeVertical * 2.5,
                    ),
                  ],
                ),
              ),
              _getBookList(),
            ],
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
            return Container(
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
                                          height: SizeConfig.screenHeight*0.177,
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
                                            snapshot.data.date[index].name,
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
                                                    .data.date[index].edition_detail,
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
                                          "$rs ${snapshot.data.date[index].price}",
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
      CommonSnackBar.snackBar(
          message: "Search Item cannot be empty");
    }
  }
dynamic categorylist=new List();
  Future<void> getCategory() async {
    print("jh dhic ibcdofn");
    isLoading=true;
    try {
      final response = await post(Uri.parse("https://buysell.powerdope.com/api/category"),
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
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(image: NetworkImage(
                                  categorylist[index]['image']),),
                              borderRadius: BorderRadius.circular(40),
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
}