import 'dart:developer';

import 'package:book_buy_and_sell/model/apiModel/requestModel/Editprofile_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/register_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/Editprofileresponse_mode.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/login_response_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/register_response_model.dart';
import 'package:book_buy_and_sell/model/services/api_service.dart';
import 'package:book_buy_and_sell/model/services/base_service.dart';

class EditProfilerepo extends BaseService {
  Future<EditprofileresponseModel> editprofilerepo(EditReq model) async {
    Map<String, dynamic> body = model.toJson();
    print('Register Req :$body');
    var response = await ApiService().getResponse(
        apiType: APIType.aPost, url: profileEdit, body: body, fileUpload: true);
    log("register res :${response.runtimeType}");
    EditprofileresponseModel editprofileresponseModel =
    EditprofileresponseModel.fromJson(response);
    return editprofileresponseModel;
  }
}
