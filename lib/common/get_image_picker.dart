
import 'package:image_picker/image_picker.dart';

Future<XFile> getImageFromGallery() async {
  ImagePicker imagePicker = ImagePicker();
  XFile file = await imagePicker.pickImage(
      source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front);
  return file;
}

Future<XFile> getImageFromCamera() async {
  ImagePicker imagePicker = ImagePicker();
  XFile file = await imagePicker.pickImage(source: ImageSource.camera);
  return file;
}
