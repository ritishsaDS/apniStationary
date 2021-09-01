import 'package:book_buy_and_sell/model/apiModel/requestModel/change_password_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/login_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/change_password_response_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/login_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/model/repo/change_password_repo.dart';
import 'package:book_buy_and_sell/model/repo/login_repo.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AccountViewModel extends GetxController {
  ApiResponse changePasswordApiResponse = ApiResponse.initial('Initial');

  ///login...
  Future<void> changePassword(ChangePasswordReq model) async {
    changePasswordApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ChangePasswordResponseModel response =
          await ChangePasswordRepo().changePasswordRepo(model.toJson());
      changePasswordApiResponse = ApiResponse.complete(response);
      print("changePasswordApiResponse RES:$response");
    } catch (e) {
      print('changePasswordApiResponse error.....$e');
      changePasswordApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
