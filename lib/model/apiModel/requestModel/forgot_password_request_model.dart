import 'package:flutter/material.dart';

class ForgotPasswordReq {
  String email;

  ForgotPasswordReq({
    this.email,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
