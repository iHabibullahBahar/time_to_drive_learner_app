import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/utils/colors.dart';

class DynamicComponents {
  static int zCustomCircularButtonIndex = 0;

  static Border zDefaultBorder = Border.all(
    color: zBlackColor.withOpacity(0.3),
    width: 0.5,
  );

  static PreferredSize zZeroAppBar = PreferredSize(
    preferredSize: const Size.fromHeight(0),
    child: AppBar(
      backgroundColor: zBackgroundColor,
      elevation: 0,
    ),
  );
}

AppBar zDefaultAppBar({
  required String title,
  VoidCallback? onTapLeading,
  bool isShowLeading = true,
  Color backgroundColor = zBackgroundColor,
  IconData leadingIcon = Icons.arrow_back_ios,
  Color leadingIconColor = zTextColor,
  bool centerTitle = true,
  TextStyle? titleStyle = const TextStyle(
    color: zTextColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  ),
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: 0,
    leading: isShowLeading
        ? InkWell(
            onTap: onTapLeading ??
                () {
                  Get.back(); // Fallback to default action if no onTapLeading is provided
                },
            child: Icon(
              leadingIcon,
              color: leadingIconColor,
            ),
          )
        : null,
    title: Text(
      title,
      style: titleStyle,
    ),
    centerTitle: centerTitle,
  );
}
