import 'dart:convert';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/Dialog.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/services/AppNotification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Donescreen.dart';
import 'MainScreen.dart';
import 'Order_summary.dart';

class CheckoutScreen extends StatefulWidget {
  dynamic id;
  dynamic orderid;
  String type;
  var price;
  String firebaseid;
  CheckoutScreen(
      {this.firebaseid, this.id, this.orderid, this.type, this.price});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  TextEditingController firstNameController =
      TextEditingController(text: PreferenceManager.getName().toString());
  TextEditingController lastNameController = TextEditingController(
      text: PreferenceManager.getName().toString().contains(" ")
          ? PreferenceManager.getName().toString().split(" ")[1]
          : " ");
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController clgController =
      TextEditingController(text: PreferenceManager.getcollge().toString());
  bool isLoading = false;
  bool gstCheck = false;

  FocusNode fullNameFn;
  FocusNode emailFn;
  FocusNode phnFn;
  FocusNode dobFn;
  FocusNode genderFn;
  FocusNode clgNameFn;
  FocusNode cityFn;
  FocusNode gstFn;
  Razorpay _razorpay;
  double totalprice = 0.0;
  @override
  void initState() {
    getbookdetail();
    if (widget.firebaseid.isNotEmpty)
      print(widget.firebaseid.toString().split(',')[0]);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    addressController = TextEditingController(
        text: Constants.userlocation +
            "," +
            Constants.usercity +
            "," +
            Constants.userstate +
            "" +
            Constants.userpostal);
    cityController = TextEditingController(text: Constants.usercity);
    pinController = TextEditingController(text: Constants.userpostal);
    stateController = TextEditingController(text: Constants.userstate);
    phnController = TextEditingController(text: PreferenceManager.getPhoneNo());
    // clgController=TextEditingController(text:PreferenceManager.g());
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    fullNameFn.dispose();
    emailFn.dispose();
    phnFn.dispose();
    dobFn.dispose();
    genderFn.dispose();
    clgNameFn.dispose();
    cityFn.dispose();
    gstFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(backgroundColor),
      body: SingleChildScrollView(
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                  ),
                  Center(child: CircularProgressIndicator())
                ],
              )
            : Column(
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
                      ],
                    ),
                  ),
                  Form(
                    key: signUpFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _generalTextField("First Name", firstNameController, 1),
                        //_generalTextField("Last Name", lastNameController,1),
                        _generalTextField("Phone Number", phnController, 1),
                        _generalTextField("Address", addressController, 4),
                        _generalTextField("College Name", clgController, 1),
                        // _generalTextField("City", cityController),
                        // _generalTextField("State", stateController),
                        // _generalTextField("Pincode", pinController),
                        Center(
                          child: Container(
                            width: SizeConfig.screenWidth * 0.5,
                            height: SizeConfig.blockSizeVertical * 5,
                            margin: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.05,
                                right: SizeConfig.screenWidth * 0.05,
                                top: SizeConfig.blockSizeVertical * 3,
                                bottom: SizeConfig.blockSizeVertical),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(gradientColor1),
                                  Color(gradientColor2).withOpacity(0.95),
                                ],
                                begin: Alignment(1.0, -3.0),
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (widget.type == "Buy") {
                                  //callCheckoutAPI();
                                  openCheckout();
                                } else {
                                  showordersummary(context);
                                }
                                //checkValidation();
                              },
                              child: Text(
                                "Checkout",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
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

  Widget _generalTextField(
      String hint, TextEditingController controller, maxlines) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.07,
              right: SizeConfig.screenWidth * 0.05,
              top: SizeConfig.blockSizeVertical * 2,
            ),
            child: Text(hint)),
        Container(
          width: SizeConfig.screenWidth,
          margin: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.05,
            right: SizeConfig.screenWidth * 0.05,
            top: SizeConfig.blockSizeVertical * 2,
            bottom: SizeConfig.blockSizeVertical,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    spreadRadius: 2.0,
                    blurRadius: 4.0),
              ]),
          child: TextFormField(
            controller: controller,
            maxLines: maxlines,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.5,
                  horizontal: SizeConfig.blockSizeHorizontal * 5),
              hintText: hint,
              hintStyle: TextStyle(
                color: Color(hintGrey),
                fontWeight: FontWeight.w500,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  checkValidation() {
    if (firstNameController.text.length < 2) {
      showAlert(context, "Please enter a valid First Name.");
    } else if (addressController.text.length < 10) {
      showAlert(context, "Please enter a valid Address.");
    } else if (cityController.text.length < 2) {
      showAlert(context, "Please enter a valid City.");
    } else if (stateController.text.length < 2) {
      showAlert(context, "Please enter a valid State.");
    } else if (pinController.text.length < 4) {
      showAlert(context, "Please enter a valid Pincode.");
    } else {
      callCheckoutAPI();
    }
  }

  callCheckoutAPI() async {
    print(widget.type);
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "first_name": firstNameController.text,
      "last_name": "",
      "type": widget.type == "Buy" ? widget.type : "Cart",
      "address": addressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "zip": pinController.text,
      'book_id': widget.type == 'Buy'
          ? widget.id.toString()
          : widget.orderid.toString().replaceAll('[', "").replaceAll(']', "")
    };
    print("callCheckoutAPI ${body.toString()}");
    print("----------------" + PreferenceManager.getfirebasenotif().toString());
    var res = await ApiCall.post(checkoutURL, body);
    print("------------" + res.toString());
    if (res["status"] == "200") {
      if (widget.type == 'Buy') {
        Map<String, dynamic> body = {
          'senderId': PreferenceManager.getfirebaseid(),
          'receiverId': widget.firebaseid.toString().split(",")[0],
          'img': "widget.img",
          'userName': PreferenceManager.getName(),
        };

        final split = widget.firebaseid.split(',');
        List<String> splitdata = [];
        for (int i = 0; i < split.length; i++) {
          splitdata.add(split[i]);
        }
        AppNotificationHandler.sendMessage(
            msg: PreferenceManager.getName() + " Requested to buy your book",
            data: body,
            token:
                splitdata.isEmpty && splitdata.length == 2 ? splitdata[1] : "");

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CheckAnimation(text: "Order Place")));
      } else {
        // Map<String, dynamic>   body = {
        //   'senderId': PreferenceManager.getfirebaseid(),
        //   'receiverId': widget.firebaseid.toString().split(",")[0],
        //   'img': "widget.img",
        //   'userName': PreferenceManager.getName(),
        // };
        // AppNotificationHandler.sendMessage(
        //     msg: PreferenceManager.getName()+" Requested to buy your book", data: body, token:widget.firebaseid.toString().split(",")[1]);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CheckAnimation(text: "Order Place")));
      }

      //showPopUp(context, res["message"]);
    } else {
      showAlert(context, res["message"]);
    }
  }

  getNotification() async {
    print(widget.type);
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "first_name": firstNameController.text,
      "last_name": "",
      "type": widget.type,
      "address": addressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "zip": pinController.text,
      'book_id': widget.type == 'Buy'
          ? widget.id.toString()
          : widget.orderid.toString().replaceAll('[', "").replaceAll(']', "")
    };
    print("----------------" + PreferenceManager.getfirebasenotif().toString());
    var res = await ApiCall.post(checkoutURL, body);
    print("------------" + res.toString());
    if (res["status"] == "200") {
      if (widget.type == 'Buy') {
        Map<String, dynamic> body = {
          'senderId': PreferenceManager.getfirebaseid(),
          'receiverId': widget.firebaseid.toString().split(",")[0],
          'img': "widget.img",
          'userName': PreferenceManager.getName(),
        };
        AppNotificationHandler.sendMessage(
            msg: PreferenceManager.getName() + " Requested to buy your book",
            data: body,
            token: widget.firebaseid.toString().split(",")[1]);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CheckAnimation(text: "Order Place ")));
      } else {
        // Map<String, dynamic>   body = {
        //   'senderId': PreferenceManager.getfirebaseid(),
        //   'receiverId': widget.firebaseid.toString().split(",")[0],
        //   'img': "widget.img",
        //   'userName': PreferenceManager.getName(),
        // };
        // AppNotificationHandler.sendMessage(
        //     msg: PreferenceManager.getName()+" Requested to buy your book", data: body, token:widget.firebaseid.toString().split(",")[1]);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CheckAnimation(text: "Order Place ")));
      }

      //showPopUp(context, res["message"]);
    } else {
      showAlert(context, res["message"],);
    }
  }

  showPopUp(BuildContext context, String msg, bool stayOnSameScreen) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context).pop();

                if (!stayOnSameScreen) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MainScreen();
                  }));
                }
              },
            ),
          ],
        );
      },
    );
  }

  void openCheckout() {
    // print(totalprice);
    double rawAmount;
    if (widget.type == 'Buy')
      rawAmount = ((widget.price) * 100);
    else
      rawAmount = (totalprice) * 100;

    // double.parse((12.5668).toStringAsFixed(2));
    var options = {
      'key': 'rzp_live_b5Jmla6DpICdpO',  //actual
      // 'key': 'rzp_test_23633fjMEgS0IE', // testing
      'amount': rawAmount.round().toString(),
      'name': 'Apni Stationary',
      'description':
          'Buy  used or unused stationary,books,notes and study materials',
      'external': {
        'wallets': ['paytm']
      }
    };

    print("options Map ${options}");
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    callCheckoutAPI();

    //  showPopUp(context, "Order Place Successfully");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showPopUp(
      context,
      "Your Last Payment Failed !!! ",
      true
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showPopUp(
      context,
      "EXTERNAL_WALLET: " + response.walletName,
      true
    );
  }

  showordersummary(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text("Your Order Summary ")),
          contentPadding: EdgeInsets.all(0),
          content: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView(
                        children: orderdetail(),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      RaisedButton(
                        onPressed: () {
                          //openCheckout();
                          //  widget.firebaseid=
                          print(widget.orderid);
                          //  callCheckoutAPI();
                          openCheckout();
                        },
                        color: Colors.lightBlue,
                        child: Text(
                          "Confirm Order",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel Order"),
                      ),
                    ],
                  )
                ],
              )),
        );
      },
    );
  }

  dynamic bookdetail = new List();
  void getbookdetail() async {
    setState(() {
      isLoading = true;
      //Dialogs.showLoadingDialog(context, loginLoader);
    });
    Map<String, dynamic> data = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
    };

    try {
      final response = await post(
          Uri.parse(ApiCall.baseURL + "order_details_check"),
          body: data);
      print(response.statusCode.toString());

      if (response.statusCode == 256) {
        final responseJson = json.decode(response.body);

        print(responseJson);
        setState(() {
          isLoading = false;
          bookdetail = responseJson['date'];
        });
        for (int i = 0; i < bookdetail.length; i++) {
          totalprice += (bookdetail[i]['price']);
        }
        print(totalprice.toString() + "pricrrrrrr");
        print(totalprice.toString() + "0" + "pricrrrrrr");
      } else {}
    } catch (e) {
      print(e);
      setState(() {
        Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();
      });
    }
  }

  List<Widget> orderdetail() {
    List<Widget> orders = new List();
    for (int i = 0; i < bookdetail.length; i++) {
      orders.add(Container(
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(width: 120, child: Text("Book Name: ")),
                Text(bookdetail[i]['name']),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  width: 120,
                  child: Text("Author Name : "),
                ),
                Text(bookdetail[i]['auther_name']),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  width: 120,
                  child: Text("Category : "),
                ),
                Text(bookdetail[i]['category_name']),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  width: 120,
                  child: Text("College : "),
                ),
                Container(
                    width: 120,
                    child: Text(
                      bookdetail[i]['college_name'],
                      maxLines: 2,
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  width: 120,
                  child: Text("Price : "),
                ),
                Text(bookdetail[i]['price'].toString()),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1.5,
              height: 10,
            )
          ],
        ),
      ));
    }
    return orders;
  }
}
