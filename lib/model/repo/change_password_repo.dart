import 'dart:developer';

import 'package:book_buy_and_sell/model/apiModel/responseModel/change_password_response_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/login_response_model.dart';
import 'package:book_buy_and_sell/model/services/api_service.dart';
import 'package:book_buy_and_sell/model/services/base_service.dart';

class ChangePasswordRepo extends BaseService {
  Future<ChangePasswordResponseModel> changePasswordRepo(
      Map<String, dynamic> body) async {
    print('changePassword Req :$body');
    var response = await ApiService().getResponse(
        apiType: APIType.aPost, url: changePasswordURL, body: body);
    log("changePassword res :$response");
    ChangePasswordResponseModel changePasswordResponseModel =
        ChangePasswordResponseModel.fromJson(response);
    return changePasswordResponseModel;
  }
}
