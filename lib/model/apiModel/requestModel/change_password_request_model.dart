import 'package:flutter/material.dart';

class ChangePasswordReq {
  String userId;
  String oldPassword;
  String newPassword;
  String confirmPassword;
  String sessionKey;
  ChangePasswordReq(
      {this.userId,
      this.oldPassword,
      this.newPassword,
      this.confirmPassword,
      this.sessionKey});
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'oldpassword': oldPassword,
      'newpassword': newPassword,
      'confirmpassword': confirmPassword,
      'session_key': sessionKey
    };
  }
}
