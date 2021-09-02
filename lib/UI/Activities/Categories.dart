import 'dart:convert';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/SubCategory.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/CategoriesResponseModel.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/viewModel/CommonVM.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories extends StatefulWidget {
  const Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<List<CategoriesModel>> getCategories(String parentId) async {
    CommonVM commonVM = Get.find();

    Map<String, dynamic> body = {
      "user_id": PreferenceManager.getUserId(),
      "session_key": PreferenceManager.getSessionKey(),
      "parent_id": parentId ?? "0"
    };

    await commonVM.getData(categoryURL, body);
    if (commonVM.apiResponse.status == Status.COMPLETE) {
      Response response = commonVM.apiResponse.data;
      var jsonDecoded = jsonDecode(response.body);
      if (jsonDecoded["status"] == "200") {
        List<CategoriesModel> categoriesModel =
            (jsonDecoded["category_data"] as List)
                .map((e) => CategoriesModel.fromJson(e))
                .toList();
        return categoriesModel;
      } else {
        CommonSnackBar.snackBar(message: jsonDecoded['message']);
        return [];
      }
    } else {
      CommonSnackBar.snackBar(message: 'No Data Available');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    var parentId = ModalRoute.of(context).settings.arguments as String;

    getCategories(parentId);
  }

  /*
  List<String> assetImages = [
    'assets/icons/eng.png',
    'assets/icons/med.png',
    'assets/icons/music.png',
    'assets/icons/mgt.png',
    'assets/icons/notes.png',
    'assets/icons/exam.png',
    'assets/bg/logo.png',
    'assets/icons/notes.png',
    'assets/icons/notes.png',
    'assets/icons/notes.png',
    'assets/icons/mgt.png',
    'assets/icons/school.png'
  ];

  List<String> text = [
    'Engineering',
    'Medical',
    'Music',
    'Management',
    'Notes',
    'Competitive Exams',
    'Arts',
    'Accessories',
    'Novels',
    'Comics',
    'Entrance Exams',
    'School'
  ];*/

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
                  ImageIcon(
                    AssetImage('assets/icons/back.png'),
                    color: Color(colorBlue),
                    size: SizeConfig.blockSizeVertical * 4,
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
                    "Categories",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Color(black)),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.2,
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SubCategory(
                            text: text[index],
                            img: assetImages[index],
                          );
                        }));
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
                                  assetImages[index],
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
                  itemCount: assetImages.length,
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
