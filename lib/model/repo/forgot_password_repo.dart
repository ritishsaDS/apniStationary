import 'dart:developer';

import 'package:book_buy_and_sell/model/apiModel/responseModel/change_password_response_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/forgot_password_response_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/login_response_model.dart';
import 'package:book_buy_and_sell/model/services/api_service.dart';
import 'package:book_buy_and_sell/model/services/base_service.dart';

class ForgotPasswordRepo extends BaseService {
  Future<ForgotPasswordResponseModel> forgotPasswordRepo(
      Map<String, dynamic> body) async {
    print('forgotPassword Req :$body');
    var response = await ApiService().getResponse(
        apiType: APIType.aPost, url: forgotPasswordURL, body: body);
    log("forgotPassword res :$response");
    ForgotPasswordResponseModel forgotPasswordResponseModel =
        ForgotPasswordResponseModel.fromJson(response);
    return forgotPasswordResponseModel;
  }
}
