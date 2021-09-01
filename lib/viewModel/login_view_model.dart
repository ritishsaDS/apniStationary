import 'package:book_buy_and_sell/model/apiModel/requestModel/forgot_password_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/login_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/forgot_password_response_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/login_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/model/repo/forgot_password_repo.dart';
import 'package:book_buy_and_sell/model/repo/login_repo.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginViewModel extends GetxController {
  ApiResponse apiResponse = ApiResponse.initial('Initial');
  ApiResponse forgotPasswordApiResponse = ApiResponse.initial('Initial');

  ///login...
  Future<void> login(LoginReq model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      LoginResponseModel response = await LoginRepo().loginRepo(model.toJson());
      apiResponse = ApiResponse.complete(response);
      print("LOGIN RES:$response");
    } catch (e) {
      print('LOGIN error.....$e');
      apiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///forgot Password...
  Future<void> forgotPassword(ForgotPasswordReq model) async {
    forgotPasswordApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ForgotPasswordResponseModel response =
          await ForgotPasswordRepo().forgotPasswordRepo(model.toJson());
      forgotPasswordApiResponse = ApiResponse.complete(response);
      print("forgotPasswordApiResponse RES:$response");
    } catch (e) {
      print('forgotPasswordApiResponse error.....$e');
      forgotPasswordApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
