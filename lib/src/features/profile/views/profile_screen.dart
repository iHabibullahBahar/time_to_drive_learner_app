import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/features/auth/controllers/auth_controller.dart';
import 'package:ttd_learner/src/features/profile/controllers/profile_controller.dart';
import 'package:ttd_learner/src/features/profile/widgets/profile_custom_button.dart';
import 'package:ttd_learner/src/features/profile/widgets/profile_summery_widget.dart';
import 'package:ttd_learner/src/features/profile/widgets/support_section_widget.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

import 'profile_info_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: zBackgroundColor,
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
        child: ListView(
          children: [
            Obx(() {
              if (ProfileController.instance.isProfileFetching.value) {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: zPrimaryColor,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfileSummeryWidget(),
                      ],
                    ),

                    ///Account Section Widget
                    ProfileSectionWidget(
                      title: "Account",
                      buttons: [
                        ProfileCustomButton(
                          icon: Icons.person,
                          title: "Edit Profile",
                          onPressed: () {
                            Get.to(
                              () => ProfileInfoScreen(),
                            );
                          },
                        ),
                        ProfileCustomButton(
                          icon: Icons.lock,
                          title: "Change Password",
                          onPressed: () {},
                        ),
                        ProfileCustomButton(
                          icon: Icons.notifications,
                          title: "Notification",
                          onPressed: () {},
                          isHorizontalDivider: false,
                        ),
                      ],
                    ),
                    Gap(10),

                    ///Information Section Widget
                    ProfileSectionWidget(
                      title: "Information",
                      buttons: [
                        ProfileCustomButton(
                          icon: Icons.help_center,
                          title: "About us",
                          onPressed: () {},
                        ),
                        ProfileCustomButton(
                          icon: Icons.contact_support_outlined,
                          title: "Terms & Conditions",
                          onPressed: () {},
                        ),
                        ProfileCustomButton(
                          icon: Icons.privacy_tip_sharp,
                          title: "Privacy & Policy",
                          onPressed: () {},
                          isHorizontalDivider: false,
                        ),
                      ],
                    ),
                    Gap(20),

                    /// Logout Button
                    InkWell(
                      onTap: () async {
                        await AuthController.instance.signOut();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.buttonLogout,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: zPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
