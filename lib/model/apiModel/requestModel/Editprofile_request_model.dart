import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;


class EditReq {
  String email;
  String session_key;
  String name;
  String number;
  String dob;
  Uint8List image;
  String user_id;
  // String image;
  String gender;
  String college_name;

  EditReq(
      {this.email,
        this.session_key,
        this.user_id,
        this.name,
        this.number,
        this.image,
        this.gender,
        this.dob,
        this.college_name});
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'session_key': session_key,
      'name': name,
      "user_id":user_id,
      'number': number,
      'dob': dob,
      // 'image': image,
      'image': dio.MultipartFile.fromBytes(image,
          filename: '${DateTime.now().microsecondsSinceEpoch}.jpg'),
      'gender': gender,
      'college_name': college_name
    };
  }
}
