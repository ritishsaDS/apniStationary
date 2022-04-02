import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;

import 'package:flutter/material.dart';

class RegisterReq {
  String email;
  String password;
  String name;
  String number;
  String dob;
  Uint8List image;
  // String image;
  String gender;
  String profession;
  String college_name;
  String user_firebase_id;

  RegisterReq(
      {this.email,
      this.password,
      this.name,
      this.number,
        this.profession,
      this.image,
        this.user_firebase_id,
      this.gender,
      this.dob,
      this.college_name});
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      "profession":profession,
      'number': number,
      'dob': dob,
      'user_firebase_id':user_firebase_id,
      // 'image': image,
      image==null?"":'image':image==null?"https://gnws.org/wp-content/uploads/2019/07/placeholder-1400x775.jpg": dio.MultipartFile.fromBytes(image,
          filename: '${DateTime.now().microsecondsSinceEpoch}.jpg'),
      'gender': gender,
      'college_name': college_name
    };
  }
}
