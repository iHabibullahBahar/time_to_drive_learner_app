import 'dart:convert';

import 'package:get/get.dart';
import 'package:ttd_learner/src/features/profile/models/profile_model.dart';
import 'package:ttd_learner/src/helper/api_services.dart';
import 'package:ttd_learner/src/utils/api_urls.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProfile();
  }

  ProfileModel profileModel = ProfileModel();

  RxBool isProfileFetching = false.obs;
  fetchProfile() async {
    try {
      isProfileFetching.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: {},
        endpoint: zUserInfoEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        profileModel = ProfileModel.fromJson(decoded);
        try {} catch (e) {
          print("Error in calculating age: $e");
        }
        isProfileFetching.value = false;
      } else {}
    } catch (e) {}
    isProfileFetching.value = false;
  }
}
