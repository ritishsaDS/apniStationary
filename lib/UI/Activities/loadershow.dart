import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class loadershow extends StatefulWidget{
  @override
  _loadershowState createState() => _loadershowState();
}

class _loadershowState extends State<loadershow> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return     Scaffold(
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      ),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          height: 220,
padding: EdgeInsets.symmetric(vertical: 10),

          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding:EdgeInsets.all(10),
                  child: Text("Enter OTP",style: TextStyle(fontSize: 20),)),
              OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 40,

              fieldStyle: FieldStyle.underline,
              outlineBorderRadius: 30,

              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
              onChanged: (pin) {
              print("Changed: " + pin);
              },
              onCompleted: (pin) {
              print("Completed: " + pin);
              },
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  color: Colors.blue,

                  onPressed: (){},
                  child: Text("Done",style: TextStyle(color: Colors.white),),),
              )
            ],
          ),
          
        ),

      ],
    );
  }}