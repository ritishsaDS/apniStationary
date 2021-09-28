import 'dart:convert';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/SelectedBook.dart';
import 'package:book_buy_and_sell/UI/Activities/SubCategory.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/commonLV.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/CategoriesResponseModel.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<Widget> getCategories() async {
    // CommonVM commonVM = Get.find();

    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "parent_id": "0"
    };
    var res = await ApiCall.apiCall(categoryURL, body);
    if (res.statusCode == 256) {
      var jsonDecoded = jsonDecode(res.body);
      if (jsonDecoded["status"] == "200") {
        List<CategoriesModel> categoriesModel =
            (jsonDecoded["category_data"] as List)
                .map((e) => CategoriesModel.fromJson(e))
                .toList();
        if (categoriesModel.length > 0) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisCount: 3,
                crossAxisSpacing: SizeConfig.blockSizeHorizontal * 3,
                mainAxisSpacing: SizeConfig.blockSizeVertical * 2),
            itemBuilder: (context, int index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return categoriesModel[index].subcategory == "Yes"
                          ? SubCategory(
                              id: categoriesModel[index].id,
                              text: categoriesModel[index].name,
                              img: categoriesModel[index].image)
                          : SelectedBook(
                              searchedWord: "",
                              catId: categoriesModel[index].id.toString());
                    }));
                  },
                  child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Container(
                          height:  SizeConfig.blockSizeVertical * 10,
                          width:SizeConfig.blockSizeVertical * 12 ,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              image: DecorationImage(image:  NetworkImage(categoriesModel[index].image),),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[400],
                                    spreadRadius: 1,
                                    blurRadius: 4)
                              ]),
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(
                              bottom: SizeConfig.blockSizeVertical),





                        ),
                        Container(
                            width: SizeConfig.screenWidth * 0.25,
                            alignment: Alignment.center,
                            child: Text(
                              categoriesModel[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF06070D),
                                  fontSize: SizeConfig.blockSizeVertical * 1.5),
                              textAlign: TextAlign.center,
                            ))
                      ])));
            },
            itemCount: categoriesModel.length,
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
          );
        } else {
          return Text("No Data found");
        }
      } else {
        return Text(jsonDecoded['message']);
      }
    } else {
      return Text("No Data found");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: Row(children: [
                  ImageIcon(
                    AssetImage('assets/icons/back.png'),
                    color: Color(colorBlue),
                    size: SizeConfig.blockSizeVertical * 4,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 5,
                    ),
                    child: Row(
                      children: [
                        Text(
                          Constants.userlocation,
                          style: TextStyle(color: Color(black)),
                        ),
                        // SizedBox(
                        //   width: SizeConfig.blockSizeHorizontal * 2,
                        // ),
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
                ])),
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
                      Text("Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(black))),
                      Container(
                          width: SizeConfig.screenWidth * 0.2,
                          height: SizeConfig.blockSizeVertical * 0.2,
                          decoration: BoxDecoration(color: Color(colorBlue)))
                    ])),
            Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical * 2),
                decoration: BoxDecoration(color: Colors.white),
                child: CommonLV(dataCallingMethod: getCategories())),
          ],
        ),
      ),
    ));
  }
}
