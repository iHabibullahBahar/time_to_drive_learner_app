import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/features/subscription/models/subscription_package_model.dart';
import 'package:ttd_learner/src/helper/api_services.dart';
import 'package:ttd_learner/src/utils/api_urls.dart';
import 'package:ttd_learner/src/utils/colors.dart';

class SubscriptionController extends GetxController {
  static SubscriptionController get instance => Get.find();
  String? htmlData;
  String? testHtmlData;
  TextEditingController referralController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Duration duration = Duration(seconds: 2);
    Future.delayed(duration, () {
      showPackage();
    });
  }

  SubscriptionPackageModel subscriptionPackageModel =
      SubscriptionPackageModel();
  RxBool isPackageFetching = true.obs;
  Future<bool> showPackage() async {
    try {
      isPackageFetching.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: {},
        endpoint: zShowPaymentPackageEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        subscriptionPackageModel = SubscriptionPackageModel.fromJson(decoded);
        print(subscriptionPackageModel.data!.name!);
        isPackageFetching.value = false;
        return true;
      } else {
        if (decoded['success'] == false) {
          Get.snackbar(
            'Error',
            decoded['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: zErrorSwatch,
            colorText: zWhiteColor,
            duration: const Duration(seconds: 2),
          );
        }
        isPackageFetching.value = false;
        return false;
      }
    } catch (e) {
      isPackageFetching.value = false;
      return false;
    }
  }

  RxBool isPaymentScreenLoading = false.obs;
  Future<bool> makePayment() async {
    try {
      isPaymentScreenLoading.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: {},
        endpoint: zPaymentEndpoint,
        isAuthToken: true,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {}
      return true;
    } catch (e) {
      isPaymentScreenLoading.value = false;
      return false;
    }
    isPaymentScreenLoading.value = false;
  }
}
