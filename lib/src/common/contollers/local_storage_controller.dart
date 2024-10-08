import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageController extends GetxController {
  static LocalStorageController instance = Get.find();
  late SharedPreferences _prefs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> setString(String key, String value) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key, value);
  }

  Future<dynamic> getString(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key) ?? '';
  }

  Future<void> setBool(String key, bool value) async {
    await SharedPreferences.getInstance();
    _prefs.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(key) ?? false;
  }

  Future<void> setInt(String key, int value) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setInt(key, value);
  }

  Future<dynamic> getInt(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt(key) ?? 0;
  }

  Future<void> clearInstance(String key) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove(key);
  }
}
