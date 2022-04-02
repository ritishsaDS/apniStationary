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

  // 2nd image

  Uint8List _selectedImg2;

  Uint8List get selectedImg2 => _selectedImg2;

  void addSelectedImg2(Uint8List value) {
    _selectedImg2 = value;
    update();
  }
  //profile photo
  Uint8List _profilephoto;

  Uint8List get profilephoto => _profilephoto;

  void profileimage(Uint8List value) {
    _profilephoto = value;
    update();
  }

  // 3rd image

  Uint8List _selectedImg3;

  Uint8List get selectedImg3 => _selectedImg3;

  void addSelectedImg3(Uint8List value) {
    _selectedImg3 = value;
    update();
  }

  // 4th image

  Uint8List _selectedImg4;

  Uint8List get selectedImg4 => _selectedImg4;

  void addSelectedImg4(Uint8List value) {
    _selectedImg4 = value;
    update();
  }
}
