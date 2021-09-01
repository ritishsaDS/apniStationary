// To parse this JSON data, do
//
//     final changePasswordResponseModel = changePasswordResponseModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordResponseModel changePasswordResponseModelFromJson(String str) =>
    ChangePasswordResponseModel.fromJson(json.decode(str));

String changePasswordResponseModelToJson(ChangePasswordResponseModel data) =>
    json.encode(data.toJson());

class ChangePasswordResponseModel {
  ChangePasswordResponseModel({
    this.status,
    this.message,
    this.updatedInfo,
  });

  String status;
  String message;
  UpdatedInfo updatedInfo;

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponseModel(
        status: json["status"],
        message: json["message"],
        updatedInfo: json["UpdatedInfo"] != 'Password updated successfully'
            ? UpdatedInfo()
            : UpdatedInfo.fromJson(json["UpdatedInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "UpdatedInfo": updatedInfo.toJson(),
      };
}

class UpdatedInfo {
  UpdatedInfo({
    this.password,
    this.email,
  });

  String password;
  String email;

  factory UpdatedInfo.fromJson(Map<String, dynamic> json) => UpdatedInfo(
        password: json["password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "email": email,
      };
}
