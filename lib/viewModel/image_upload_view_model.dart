import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ImageUploadViewModel extends GetxController {
  Uint8List _selectedImg;

  Uint8List get selectedImg => _selectedImg;

  void addSelectedImg(Uint8List value) {
    _selectedImg = value;
    update();
  }
}
