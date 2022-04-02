import 'dart:developer';

import 'package:book_buy_and_sell/model/apiModel/requestModel/register_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/login_response_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/register_response_model.dart';
import 'package:book_buy_and_sell/model/services/api_service.dart';
import 'package:book_buy_and_sell/model/services/base_service.dart';

class RegisterRepo extends BaseService {
  Future<RegisterResponseModel> registerRepo(RegisterReq model) async {
    Map<String, dynamic> body =  model.toJson();
    print('Register Req :$body');
    var response = await ApiService().getResponse(
        apiType: APIType.aPost, url: registerURL, body: body, fileUpload: false);
    log("register res :${response.runtimeType}");
    RegisterResponseModel registerResponse =
        RegisterResponseModel.fromJson(response);
    return registerResponse;
  }
}
