import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  ///email
  static Future setEmailId(String value) async {
    await getStorage.write("email_id", value);
  }

  static String getEmailId() {
    return getStorage.read("email_id");
  }
  ///college
  static Future setcollge(String value) async {
    await getStorage.write("college", value);
  }

  static String getcollge() {
    return getStorage.read("college");
  }
  ///image
  static Future setImage(String value) async {
    await getStorage.write("image", value);
  }

  static String getImage() {
    return getStorage.read("image");
  }

  ///name
  static Future setName(String value) async {
    await getStorage.write("name", value);
  }

  static String getName() {
    return getStorage.read("name");
  }

  ///user id
  static Future setUserId(int value) async {
    await getStorage.write("user_id", value);
  }

  static int getUserId() {
    return getStorage.read("user_id");
  }

  ///session key
  static Future setSessionKey(String value) async {
    await getStorage.write("session_key", value);
  }

  static String getSessionKey() {
    return getStorage.read("session_key");
  }

  ///phone number
  static Future setPhoneNo(String value) async {
    await getStorage.write("phone", value);
  }

  static String getPhoneNo() {
    return getStorage.read("phone");
  }
}
