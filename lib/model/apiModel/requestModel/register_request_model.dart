import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;
import 'dart:convert';

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

  RegisterReq(
      {this.email,
      this.password,
      this.name,
      this.number,
        this.profession,
      this.image,
      this.gender,
      this.dob,
      this.college_name});
  Map<String, dynamic> toJson() {
    File rawimage=File.fromRawPath(image);
    //       'image': dio.MultipartFile.fromFile(rawimage.path,
    //       filename: '${DateTime.now().microsecondsSinceEpoch}.jpg'),

var fileContent = rawimage.readAsBytesSync();
var fileContentBase64 = base64.encode(fileContent);
var image_ =  dio.MultipartFile.fromBytes(image,
          filename: '${DateTime.now().microsecondsSinceEpoch}.jpg');
    return {
      'email': email,
      'password': password,
      'name': name,
      "profession":profession,
      'number': number,
      'dob': dob,
      'image': image_,
      // 'image':,
      'gender': gender,
      'college_name': college_name
    };
  }
}
