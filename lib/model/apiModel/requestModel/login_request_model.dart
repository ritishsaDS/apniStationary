import 'package:flutter/material.dart';

class LoginReq {
  String email;
  String password;
  String deviceType;
  String deviceId;
  LoginReq({this.email, this.password, this.deviceType, this.deviceId});
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'deviceID': deviceId ?? '',
      'deviceType': deviceType ?? ''
    };
  }
}
