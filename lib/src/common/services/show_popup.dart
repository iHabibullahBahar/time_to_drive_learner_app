import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/widgets/custom_button.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class ShowPopup {
  //Take the context and View as input and show the dialog box
  void showPopUp(
      {required BuildContext context,
      required Widget view,
      required double height}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          ///This will close the dialog box when user taps outside the dialog box
          onTap: () {
            Get.back();
          },
          child: Container(
            color: Colors.transparent,
            child: GestureDetector(
              ///This will prevent the dialog box to close when user taps inside the dialog box
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Container(
                  height: height,
                  width: double.infinity,
                  child: Container(
                      height: height,
                      decoration: BoxDecoration(
                        color: zWhiteColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: view),
                ),
              ),
            ),
          ),
        );
      },
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void showBottomPopUp({
    required BuildContext context,
    required Widget view,
    required double height,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          ///This will close the dialog box when user taps outside the dialog box
          onTap: () {
            Get.back();
          },
          child: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.transparent,
            child: GestureDetector(
              ///This will prevent the dialog box to close when user taps inside the dialog box
              onTap: () {},
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 0,
                      child: SafeArea(
                        child: Container(
                          height: height,
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: view,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void showCenterPopUp({
    required BuildContext context,
    required Widget view,
    required double height,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          ///This will close the dialog box when user taps outside the dialog box
          onTap: () {
            Get.back();
          },
          child: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.transparent,
            child: GestureDetector(
              ///This will prevent the dialog box to close when user taps inside the dialog box
              onTap: () {},
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 0,
                      child: SafeArea(
                        child: Container(
                          height: height,
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: view,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void showMealGenerationPopup({
    required BuildContext context,
    Function? onContinue,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          ///This will close the dialog box when user taps outside the dialog box
          onTap: () {
            Get.back();
          },
          child: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.transparent,
            child: GestureDetector(
              ///This will prevent the dialog box to close when user taps inside the dialog box
              onTap: () {},
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
                  child: Container(
                    height: 250,
                    width: 320,
                    decoration: BoxDecoration(
                      color: zWhiteColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.zDefaultPadding,
                        bottom: Dimensions.zDefaultPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 10),
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: zGraySwatch[50]!,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: zTextColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
                          Container(
                            width: 320 - 2 * Dimensions.zDefaultPadding - 30,
                            child: Text(
                              "If you update the information, the meal plan will be generated based on the information.",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: zTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Gap(30),
                          Text(
                            "Do you want to continue?",
                            style: TextStyle(
                              color: zTextColor.withOpacity(0.8),
                              fontSize: 15,
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 45,
                            width: 320 - 2 * Dimensions.zDefaultPadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 135,
                                  child: CustomButton(
                                    title: AppLocalizations.of(context)!
                                        .buttonCancel,
                                    radius: 10,
                                    gradient: LinearGradient(
                                      colors: [
                                        zErrorSwatch,
                                        zErrorSwatch,
                                      ],
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                                Gap(10),
                                SizedBox(
                                  width: 135,
                                  child: CustomButton(
                                    radius: 10,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.green,
                                        Colors.green,
                                      ],
                                    ),
                                    title: AppLocalizations.of(context)!
                                        .buttonContinue,
                                    onPressed: () {
                                      onContinue!();
                                      Get.back();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
