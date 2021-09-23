import 'package:book_buy_and_sell/model/apiModel/requestModel/Editprofile_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/login_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/register_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/Editprofileresponse_mode.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/login_response_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/register_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/model/repo/EditPtofile_repo.dart';
import 'package:book_buy_and_sell/model/repo/login_repo.dart';
import 'package:book_buy_and_sell/model/repo/register_repo.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class EditProfileViewModel extends GetxController {
  ApiResponse apiResponse = ApiResponse.initial('Initial');

  ///Register...
  Future<void> register(EditReq model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      EditprofileresponseModel response = await EditProfilerepo().editprofilerepo(model);
      apiResponse = ApiResponse.complete(response);
      print("Register RES:$response");
    } catch (e) {
      print('Register error.....$e');
      apiResponse = ApiResponse.error('error');
    }
    update();
  }
}
