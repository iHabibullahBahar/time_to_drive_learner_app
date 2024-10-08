import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CustomSnackBarService {
  void showSuccessSnackBar({
    required String message,
    String title = "",
    int duration = 2,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      titleText: title == ""
          ? const SizedBox(
              height: 0,
            )
          : Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
      margin: const EdgeInsets.all(10),
      messageText: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Gap(3)
        ],
      ),
      borderRadius: 10,
      duration: Duration(seconds: duration),
    );
  }

  void showErrorSnackBar({
    required String message,
    String title = "",
    int duration = 2,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      titleText: title == ""
          ? const SizedBox(
              height: 0,
            )
          : Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
      margin: const EdgeInsets.all(10),
      messageText: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Gap(3)
        ],
      ),
      borderRadius: 10,
      duration: Duration(seconds: duration),
    );
  }

  void showWarningSnackBar({
    required String message,
    String title = "",
    int duration = 2,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFFf25700),
      colorText: Colors.white,
      titleText: title == ""
          ? const SizedBox(
              height: 0,
            )
          : Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
      margin: const EdgeInsets.all(10),
      messageText: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Gap(3)
        ],
      ),
      borderRadius: 10,
      duration: Duration(seconds: duration),
    );
  }

  void showInfoSnackBar({
    required String message,
    String title = "",
    int duration = 2,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      titleText: title == ""
          ? const SizedBox(
              height: 0,
            )
          : Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
      margin: const EdgeInsets.all(10),
      messageText: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Gap(3)
        ],
      ),
      borderRadius: 10,
      duration: Duration(seconds: duration),
    );
  }
}
