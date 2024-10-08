import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();

  RxInt selectedNavigationIndex = 1.obs;
}
