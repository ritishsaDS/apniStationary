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
  static Future setNotificayioncount(String value) async {
    await getStorage.write("notification_count", value);
  }

  static String getNotificayioncount() {
    return getStorage.read("notification_count");
  }
  static Future setnotificationzero(String value) async {
    await getStorage.write("notification_zero", value);
  }

  static String getnotificationzero() {
    return getStorage.read("notification_zero");
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
  static Future setfirebaseid(String value) async {
    await getStorage.write("userfirebaseid", value);
  }
  static Future setfirebasetoken(String value) async {
    await getStorage.write("userfirebasetoken", value);
  }
  static Future setfirebasetokennotif(String value) async {
    await getStorage.write("userfirebasetokens", value);
  }

  static String getImage() {
    return getStorage.read("image");
  }
  static String getfirebasetoken() {
    return getStorage.read("image");
  }

  static String getfirebaseid() {
    return getStorage.read("userfirebaseid");
  }
  static String getfirebasenotif() {
    return getStorage.read("userfirebasetokens");
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
  static Future<void> clearData() async {

    await getStorage.write('email_id', null);
    await getStorage.write("username", null);
    await getStorage.write("id", null);
    await getStorage.write("session_key", null);
    await getStorage.write("image", null);
    await getStorage.write("phone", null);
    await getStorage.write("name", null);
    await getStorage.write("lastName", null);
    await getStorage.write("userfirebasetoken", null);
    await getStorage.write("userfirebaseid", null);
    await getStorage.write("userfirebasetokens", null);
    await getStorage.write("status", null);
    await getStorage.write("college", null);
    await getStorage.write("puch_notification", null);
    await getStorage.write("push_sound", null);
    await getStorage.write("location_update", null);
    await getStorage.write("background_location", null);
    await getStorage.write("on_map", null);
    await getStorage.write("hide_age", null);
    await getStorage.write("message", null);
    await getStorage.write("appear", null);
    await getStorage.write("match", null);


  }
}