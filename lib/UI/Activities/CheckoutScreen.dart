import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'MainScreen.dart';

class CheckoutScreen extends StatefulWidget {
  dynamic id;
   CheckoutScreen({this.id}) ;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController(text: PreferenceManager.getName().toString());
  TextEditingController lastNameController = TextEditingController(text: PreferenceManager.getName().toString().contains(" ")?PreferenceManager.getName().toString().split(" ")[1]:" " );
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController clgController = TextEditingController(text:PreferenceManager.getcollge().toString() );

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


  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    addressController=TextEditingController(text:Constants.userlocation+","+Constants.usercity+","+Constants.userstate+""+Constants.userpostal);
    cityController=TextEditingController(text:Constants.usercity);
    pinController=TextEditingController(text: Constants.userpostal);
    stateController=TextEditingController(text: Constants.userstate);
    phnController=TextEditingController(text:PreferenceManager.getPhoneNo());
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
                ],
              ),
            ),
            Form(
              key: signUpFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  _generalTextField("First Name", firstNameController,1),
                  //_generalTextField("Last Name", lastNameController,1),
                  _generalTextField("Phone Number", phnController,1),
                  _generalTextField("Address", addressController,4),
                  _generalTextField("College Name", clgController,1),
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
                          checkValidation();
                        },
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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

  Widget _generalTextField(String hint, TextEditingController controller,maxlines) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.07,
          right: SizeConfig.screenWidth * 0.05,
          top: SizeConfig.blockSizeVertical * 2,

        ),child: Text(hint)),
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
                    color: Colors.grey[200], spreadRadius: 2.0, blurRadius: 4.0),
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
    } 
    // else if (cityController.text.length < 2) {
    //   showAlert(context, "Please enter a valid City.");
    // } else if (stateController.text.length < 2) {
    //   showAlert(context, "Please enter a valid State.");
    // } else if (pinController.text.length < 4) {
    //   showAlert(context, "Please enter a valid Pincode.");
    // } 
    else {
      callCheckoutAPI();
    }
  }

  callCheckoutAPI() async {
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "first_name": firstNameController.text,
      "last_name": "",
      "address": addressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "zip": pinController.text,
      'book_id':widget.id.toString().replaceAll('[', "").replaceAll(']', "")
    };
print(body.toString());
    var res = await ApiCall.post(checkoutURL, body);

    if (res["status"] == "200") {
      openCheckout();
      //showPopUp(context, res["message"]);
    } else {
      showAlert(context, res["message"]);
    }
  }

  showPopUp(BuildContext context, String msg) {
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

                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return MainScreen();
                }));
              },
            ),
          ],
        );
      },
    );
  }

  void openCheckout() {
    var options = {
      // 'key': 'rzp_test_RLmD6p88YpUTkU', actual
      'key':'rzp_test_23633fjMEgS0IE',
      'amount':'100',
      'name': 'Buy And Sell',
      'description': 'Books for you',

      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showPopUp(context, "Order Place Successfully");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showPopUp(context,
        "ERROR: " + response.code.toString() + " - " + response.message,
        );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showPopUp(context, "EXTERNAL_WALLET: " + response.walletName, );
  }
}
