import 'dart:developer';

import 'package:book_buy_and_sell/model/apiModel/responseModel/login_response_model.dart';
import 'package:book_buy_and_sell/model/services/api_service.dart';
import 'package:book_buy_and_sell/model/services/base_service.dart';

class CategoriesRepo extends BaseService {
  Future<LoginResponseModel> loginRepo(Map<String, dynamic> body) async {
    print('Login Req :$body');
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, url: loginURL, body: body);
    log("login res :$response");
    LoginResponseModel registerResponse = LoginResponseModel.fromJson(response);
    return registerResponse;
  }
}
