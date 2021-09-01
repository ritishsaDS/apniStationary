import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List> compressFile(File file) async {
  Uint8List uint8list = await file.readAsBytesSync();
  print('before Compress Size file :${file.lengthSync()}');
  print('before Compress Size :${uint8list.length}');
  var result = await FlutterImageCompress.compressWithFile(file.absolute.path,
      minWidth: 720, minHeight: 1024, quality: 50, format: CompressFormat.png);
/*  print(file.lengthSync());
  print(result.length);*/
  print('after Compress Size :${result.length}');
  return result;
}
