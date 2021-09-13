import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/UI/Activities/Cart.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/model/ClassModel/BookListModel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class SelectedBook extends StatefulWidget {
  final String searchedWord, catId;

  SelectedBook({this.searchedWord, this.catId});

  @override
  _SelectedBookState createState() => _SelectedBookState();
}

class _SelectedBookState extends State<SelectedBook> {
  final kGoogleApiKey = "AIzaSyDYt1WEbSBM1rji0tN69hz9nM4P833FMco";

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
    return addresses[0].name + ", " + addresses[0].subLocality;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _determinePosition().then((value) {});
  }

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
              padding: EdgeInsets.only(right: 10),
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
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        FutureBuilder(
                            future: _determinePosition(),
                            builder: (context, snapshot) {
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
                                          new Component(Component.country, "in")
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
                  ImageIcon(
                    AssetImage('assets/icons/notification.png'),
                    color: Color(colorBlue),
                    size: SizeConfig.blockSizeVertical * 4,
                  )
                ],
              ),
            ),
          /*  Container(
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
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 1.5,
                              horizontal: SizeConfig.blockSizeHorizontal * 5),
                          hintText: "Search an item",
                          hintStyle: TextStyle(
                            color: Color(0XFF787878),
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Color(colorBlue),
                  ),
                ],
              ),
            ), */
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
                        width: SizeConfig.screenWidth * 0.3,
                        height: SizeConfig.blockSizeVertical * 0.2,
                        decoration: BoxDecoration(color: Color(colorBlue)),
                      ),
                    ],
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.4,
                    height: SizeConfig.blockSizeVertical * 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Color(colorBlue),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.25,
                          height: SizeConfig.blockSizeVertical * 4,
                          alignment: Alignment.center,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Nearby Products",
                                hintStyle: TextStyle(
                                  color: Color(hintGrey),
                                  fontSize: SizeConfig.blockSizeVertical * 1.25,
                                ),
                                contentPadding: EdgeInsets.only(
                                    bottom:
                                        SizeConfig.blockSizeVertical * 2.5)),
                            textAlign: TextAlign.center,
                            readOnly: true,
                          ),
                        ),
                        Container(
                          width: SizeConfig.screenWidth * 0.1,
                          height: SizeConfig.blockSizeVertical * 4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(25),
                                  topRight: Radius.circular(25)),
                              color: Color(colorBlue)),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: SizeConfig.blockSizeVertical * 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _getBookList(),
          ],
        ),
      ),
    ));
  }

  Widget _getBookList() {
    return FutureBuilder<BookListModel>(
      future:
          ApiCall.callBookListAPI(widget.searchedWord, widget.catId.toString()),
      builder: (context, AsyncSnapshot<BookListModel> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            return Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              child: ListView.builder(
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
                      width: SizeConfig.screenWidth,
                      margin:
                          EdgeInsets.only(bottom: SizeConfig.blockSizeVertical),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                spreadRadius: 3.0,
                                blurRadius: 2.0),
                          ]),
                      child: Row(
                        children: [
                          Container(
                            width: SizeConfig.screenWidth * 0.2,
                            height: SizeConfig.screenHeight * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(snapshot.data.image_url +
                                  "/" +
                                  snapshot.data.date[index].image1),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data.date[index].name,
                                  style: TextStyle(
                                      color: Color(0XFF06070D),
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "$rs ${snapshot.data.date[index].price}",
                                  style: TextStyle(
                                      color: Color(colorBlue),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth * 0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Author :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0XFF656565),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    1.5),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    0.5,
                                          ),
                                          Text(
                                            "Edition :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0XFF656565),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    1.5),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    0.5,
                                          ),
                                          Text(
                                            "College :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0XFF656565),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    1.5),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    0.5,
                                          ),
                                          Text(
                                            "Condition :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0XFF656565),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    1.5),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data.date[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF656565),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    1.5),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    0.5,
                                          ),
                                          Text(
                                            snapshot.data.date[index]
                                                .edition_detail,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF656565),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    1.5),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    0.5,
                                          ),
                                          Text(
                                            "College Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF656565),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    1.5),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    0.5,
                                          ),
                                          Text(
                                            snapshot
                                                .data.date[index].conditions,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF656565),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    1.5),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * 0.6,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "More Info",
                                    style: TextStyle(
                                        color: Color(colorBlue),
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeConfig.blockSizeVertical *
                                            1.35),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: snapshot.data.date.length,
                primary: false,
              ),
            );
          } else {
            return getNodDataWidget();
          }
        }
      },
    );
  }
}
