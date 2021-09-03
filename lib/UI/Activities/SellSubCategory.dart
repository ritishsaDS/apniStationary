import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/SelectedBook.dart';
import 'package:book_buy_and_sell/UI/Activities/SelectedOther.dart';
import 'package:book_buy_and_sell/UI/Activities/SellBook.dart';
import 'package:book_buy_and_sell/UI/Activities/SellOther.dart';
import 'package:book_buy_and_sell/UI/Activities/SellSchoolSubCategory.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class SellSubCategory extends StatefulWidget {
  String id;
  dynamic text;
  dynamic img;

  SellSubCategory({this.id, this.text, this.img});

  @override
  _SellSubCategoryState createState() => _SellSubCategoryState();
}

class _SellSubCategoryState extends State<SellSubCategory> {
  int selectedIndex = -1;

  var text = [
    'Books',
    'Others',
  ];

  List<String> std = [
    '5th Standard',
    '6th Standard',
    '7th Standard',
    '8th Standard',
    '9th Standard',
    '10th Standard',
    '11th Standard',
    '12th Standard',
  ];

  @override
  void initState() {
    if (widget.text == "Entrance Exams") {
      text = ['JEE Main', 'NEET', 'NEET', 'JEE Main', 'NEET', 'NEET'];
    } else if (widget.text == "School") {
      text = [
        'CBSE Boards',
        'PSEB',
      ];
    } else {
      text = [
        'Books',
        'Others',
      ];
    }
    // TODO: implement initState
    super.initState();
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
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sub-Categories",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Color(black)),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.28,
                    height: SizeConfig.blockSizeVertical * 0.2,
                    decoration: BoxDecoration(color: Color(colorBlue)),
                  ),
                ],
              ),
            ),
            Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical * 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.9,
                      crossAxisCount: 3,
                      crossAxisSpacing: SizeConfig.blockSizeHorizontal * 3,
                      mainAxisSpacing: SizeConfig.blockSizeVertical * 2),
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        if (text[index] == "CBSE Boards" ||
                            text[index] == "PSEB") {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SellSchoolSubCategory(
                              text: std,
                            );
                          }));
                        } else if (text[index] == "Books") {
                          return Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SellBook();
                          }));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SellOther();
                          }));
                        }
                      },
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        spreadRadius: 1,
                                        blurRadius: 3)
                                  ]),
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical),
                              child: ImageIcon(
                                AssetImage(
                                  widget.img,
                                ),
                                size: SizeConfig.blockSizeVertical * 6,
                                color: Color(colorBlue),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.25,
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
                  itemCount: text.length,
                  shrinkWrap: true,
                  primary: false,
                  padding:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                )),
          ],
        ),
      ),
    ));
  }
}
