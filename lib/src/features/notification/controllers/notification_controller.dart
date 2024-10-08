import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ttd_learner/src/features/notification/models/notification_model.dart';
import 'package:ttd_learner/src/helper/api_services.dart';
import 'package:ttd_learner/src/utils/api_urls.dart';
import 'package:ttd_learner/src/utils/colors.dart';

class NotificationController extends GetxController {
  static NotificationController instance = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  RxBool isNotificationFetching = false.obs;
  RxBool isMoreNotificationLoading = false.obs;
  int page = 1;
  int totalPages = 1;

  NotificationModel notificationModel = NotificationModel();
  fetchNotification({bool isRefresh = false}) async {
    if (isRefresh) {
      page = 1;
      totalPages = 1;
      isNotificationFetching.value = true;
    } else {
      page++;
      print(page);
      print(totalPages);
      if (page > totalPages) {
        page--;
        return;
      }
      isMoreNotificationLoading.value = true;
    }
    try {
      var response = await ApiServices.instance.getResponse(
        requestBody: {
          "page": page,
        },
        endpoint: zShowNotificationEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (isRefresh) {
          notificationModel = NotificationModel.fromJson(decoded);
        } else {
          isNotificationFetching.value = true;
          notificationModel.data!.notifications!
              .addAll(NotificationModel.fromJson(decoded).data!.notifications!);
          isMoreNotificationLoading.value = false;
        }
        for (int i = 0;
            i < notificationModel.data!.notifications!.length;
            i++) {
          try {
            notificationModel.data!.notifications![i].timeAgo = convertTime(
                DateTime.parse(
                    notificationModel.data!.notifications![i].timestamp!));
          } catch (e) {
            print(e);
          }
        }
        totalPages = notificationModel.data!.totalPages!;
        print(totalPages);
        print(page);
        print(notificationModel.data!.notifications!.length);
        isNotificationFetching.value = false;
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
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: zErrorSwatch,
        colorText: zWhiteColor,
        duration: const Duration(seconds: 2),
      );
    }
    isNotificationFetching.value = false;
  }

  String convertTime(DateTime time) {
    ///Change the time as x mins ago or x hours ago or date
    var now = DateTime.now();
    var difference = now.difference(time);
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        } else {
          return '${difference.inMinutes} mins ago';
        }
      } else {
        return '${difference.inHours} hours ago';
      }
    } else {
      return DateFormat('dd/MMM/yyyy').format(time);
    }
  }
}
