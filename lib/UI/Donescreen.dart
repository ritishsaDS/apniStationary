import 'package:book_buy_and_sell/UI/Activities/MainScreen.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:angles/angles.dart';
import 'dart:math';
import 'dart:core';

import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class CheckAnimation extends StatefulWidget {
  final double size;
  var text;
  final VoidCallback onComplete;

  CheckAnimation({this.size, this.onComplete,this.text});

  @override
  _CheckAnimationState createState() => _CheckAnimationState();
}

class _CheckAnimationState extends State<CheckAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> curve;

  @override
  void initState() {

    new Future.delayed(
        const Duration(seconds: 2),
            () {
              Vibration.vibrate(duration: 1000);
              HapticFeedback.vibrate();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            }
                );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.3
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/icons/circle bg.png'),
                        fit: BoxFit.cover
                    ),
                    shape: BoxShape.circle
                ),
                width: SizeConfig.screenWidth * 0.5,
                height: SizeConfig.screenHeight * 0.3,
                padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 3),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/icons/blue circle bg.png'),
                            fit: BoxFit.cover
                        ),
                        shape: BoxShape.circle
                    ),
                    child: Image.asset('assets/icons/done.png',
                      scale: SizeConfig.blockSizeVertical * 0.5,)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
              ),
              alignment: Alignment.center,
              child: Text("Successfully ${widget.text}", style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 3.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF77849C)
              ),),
            ),

          ],
        ),
      ),
    ));
  }
}