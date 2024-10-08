import 'package:get/get.dart';

class DataValidator extends GetxController {
  static DataValidator instance = Get.find();
  static bool validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    const pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    final RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }
}
