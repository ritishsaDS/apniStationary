import 'package:book_buy_and_sell/model/apiModel/requestModel/BookAdd.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/BookEdit.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/login_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/register_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/login_response_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/register_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/model/repo/BookAddRepo.dart';
import 'package:book_buy_and_sell/model/repo/BookEditRepo.dart';
import 'package:book_buy_and_sell/model/repo/login_repo.dart';
import 'package:book_buy_and_sell/model/repo/register_repo.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BookAddViewModel extends GetxController {
  ApiResponse apiResponse = ApiResponse.initial('Initial');

  ///Book Add...
  Future<void> bookAdd(BookAdd model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      print("kjbwdjiidnai"+apiResponse.message);
      RegisterResponseModel response = await BookAddRepo().bookAddRepo(model);
      apiResponse = ApiResponse.complete(response);
      print("BookAdd RES:$response");
    } catch (e) {
      print('BookAdd error.....$e');
      apiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Book Edit...
  Future<void> bookEdit(BookEdit model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      RegisterResponseModel response = await BookEditRepo().bookEditRepo(model);
      apiResponse = ApiResponse.complete(response);
      print("BookEdit RES:$response");
    } catch (e) {
      print('BookEdit error.....$e');
      apiResponse = ApiResponse.error('error');
    }
    update();
  }
}
