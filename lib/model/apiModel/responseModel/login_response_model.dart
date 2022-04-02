// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.message,
    this.user,
  });

  String status;
  String message;
  User user;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.number,
    this.image,
    this.userType,
    this.sessionKey,
    this.college_name,
    this.user_firebase_id
  });

  int id;
  String name;
  String email;
  String number;
  String image;
  String userType;
String college_name;
  String sessionKey;
  String user_firebase_id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
    college_name:json['college_name'],
        name: json["name"],
        email: json["email"],
        number: json["number"],
        image: json["image"],
        userType: json["user_type"],
        sessionKey: json["session_key"],
      user_firebase_id:json['user_firebase_id']
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "number": number,
        "image": image,
        "user_type": userType,
        "session_key": sessionKey,
    "college_name":college_name,
    'user_firebase_id':user_firebase_id
      };
}
