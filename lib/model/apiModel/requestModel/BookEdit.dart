import 'dart:core';
import 'dart:core';
import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;

import 'package:flutter/material.dart';

class BookEdit {
  String user_id;
  String session_key;
  String category_id;
  String name;
  String auther_name;
  String edition_detail;
  String semester;
  String conditions;
  String description;
  String price;
  String id;
  Uint8List image1;
  Uint8List image2;
  Uint8List image3;
  Uint8List image4;


  BookEdit(
      {
        this.user_id,
        this.session_key,
        this.category_id,
        this.name,
        this.auther_name,
        this.edition_detail,
        this.semester,
        this.conditions,
        this.description,
        this.price,
        this.id,
        this.image1,
        this.image2,
        this.image3,
        this.image4});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'session_key': session_key,
      'category_id': category_id,
      'name': name,
      'auther_name': auther_name,
      'edition_detail': edition_detail,
      'semester': semester,
      'conditions': conditions,
      'description': description,
      'price': price,
      'image1': dio.MultipartFile.fromBytes(image1,
          filename: '${DateTime.now().microsecondsSinceEpoch}.jpg'),
      'image2': dio.MultipartFile.fromBytes(image2,
          filename: '${DateTime.now().microsecondsSinceEpoch}.jpg'),
      'image3': dio.MultipartFile.fromBytes(image3,
          filename: '${DateTime.now().microsecondsSinceEpoch}.jpg'),
      'image4': dio.MultipartFile.fromBytes(image4,
          filename: '${DateTime.now().microsecondsSinceEpoch}.jpg')
    };
  }
}
