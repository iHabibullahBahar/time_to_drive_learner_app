import 'package:get/get.dart';
import 'package:ttd_learner/src/common/contollers/local_storage_controller.dart';
import 'package:ttd_learner/src/features/auth/controllers/auth_controller.dart';
import 'package:ttd_learner/src/features/post/controllers/message_controller.dart';
import 'package:ttd_learner/src/features/post/controllers/review_controller.dart';
import 'package:ttd_learner/src/helper/api_services.dart';
import 'package:ttd_learner/src/helper/token_maker.dart';
import 'package:ttd_learner/src/utils/app_constants.dart';

class Global extends GetxService {
  static Global instance = Get.find();
  @override
  void onInit() {
    super.onInit();
    intiGlobal();
  }

  intiGlobal() async {
    Get.put(LocalStorageController());
    Get.put(GlobalStorage());
    Get.put(ApiServices());
    Get.put(TokenMaker());
    Get.put(() => AuthController());
    Get.put(MessageController());
    Get.put(ReviewController());
  }
}

class GlobalStorage extends GetxService {
  static GlobalStorage instance = Get.find();
  late bool isNotFirstTime;
  late bool isLoggedIn;
  late int userId;
  @override
  void onInit() {
    super.onInit();
    intiStorage();
  }

  void intiStorage() async {
    isNotFirstTime =
        await LocalStorageController.instance.getBool(zIsNotFirstTime) ?? true;
    isLoggedIn =
        await LocalStorageController.instance.getBool(zIsLoggedIn) ?? false;
    userId = await LocalStorageController.instance.getInt(zUserId) ?? 0;
  }
}
