import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/services/custom_snackbar_service.dart';
import 'package:ttd_learner/src/common/widgets/custom_button_with_icon.dart';
import 'package:ttd_learner/src/common/widgets/custom_shimmer_button.dart';
import 'package:ttd_learner/src/features/profile/controllers/profile_image_update_controller.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class ProfileImageEditScreen extends StatefulWidget {
  const ProfileImageEditScreen({super.key});

  @override
  State<ProfileImageEditScreen> createState() => _ProfileImageEditScreenState();
}

class _ProfileImageEditScreenState extends State<ProfileImageEditScreen> {
  ProfilePictureUploadController profilePictureUploadController =
      Get.put(ProfilePictureUploadController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBar(
        backgroundColor: zBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: zPrimaryColor,
        ),
        centerTitle: true,
        title: const Text(
          'Edit Profile Picture',
          style: TextStyle(
            color: zTextColor,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                        ),

                        ///Uploaded profile picture will be shown here
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: zPrimaryColor.withOpacity(0.8),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: zBackgroundColor,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Obx(
                                () {
                                  if (ProfilePictureUploadController
                                          .instance.imagePath.value ==
                                      "") {
                                    return Icon(
                                      Icons.person,
                                      size: 60,
                                      color: zPrimaryColor,
                                    );
                                  } else {
                                    return Image(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(
                                          ProfilePictureUploadController
                                              .instance.imagePath.value
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            ProfilePictureUploadController.instance.getImage();
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: zPrimaryColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: zWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(
          bottom: Dimensions.zDefaultPadding,
          left: Dimensions.zDefaultPadding,
          right: Dimensions.zDefaultPadding,
        ),
        child: Obx(
          () {
            if (ProfilePictureUploadController
                .instance.isImageUploading.value) {
              return CustomShimmerButton();
            } else {
              return CustomButtonWithIcon(
                title: "Update",
                onPressed: () async {
                  if (await ProfilePictureUploadController.instance
                      .updatePhoto()) {
                    CustomSnackBarService().showSuccessSnackBar(
                        message: "Profile picture updated successfully");
                    Navigator.pop(context);
                  }
                },
                icon: Icons.arrow_forward_ios,
              );
            }
          },
        ),
      ),
    );
  }
}
