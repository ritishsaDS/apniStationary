// To parse this JSON data, do
//
//     final EditprofileresponseModel = EditprofileresponseModelFromJson(jsonString);

import 'dart:convert';

EditprofileresponseModel EditprofileresponseModelFromJson(String str) =>
    EditprofileresponseModel.fromJson(json.decode(str));

String EditprofileresponseModelToJson(EditprofileresponseModel data) =>
    json.encode(data.toJson());

class EditprofileresponseModel {
  EditprofileresponseModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory EditprofileresponseModel.fromJson(Map<String, dynamic> json) =>
      EditprofileresponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
