import 'package:book_buy_and_sell/model/apiModel/requestModel/login_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/register_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/login_response_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/register_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/model/repo/login_repo.dart';
import 'package:book_buy_and_sell/model/repo/register_repo.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RegisterViewModel extends GetxController {
  ApiResponse apiResponse = ApiResponse.initial('Initial');

  ///Register...
  Future<void> register(RegisterReq model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      RegisterResponseModel response = await RegisterRepo().registerRepo(model);
      apiResponse = ApiResponse.complete(response);
      print("Register RES:$response");
    } catch (e) {
      print('Register error.....$e');
      apiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Register...
  Future<void> registerapi(RegisterReq model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      RegisterResponseModel response = await RegisterRepo().registerRepo(model);
      apiResponse = ApiResponse.complete(response);
      print("Register RES:$response");
    } catch (e) {
      print('Register error.....$e');
      apiResponse = ApiResponse.error('error');
    }
    update();
  }
}
