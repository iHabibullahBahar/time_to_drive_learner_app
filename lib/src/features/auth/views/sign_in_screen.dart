import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/services/custom_snackbar_service.dart';
import 'package:ttd_learner/src/common/widgets/custom_button_with_icon.dart';
import 'package:ttd_learner/src/common/widgets/custom_input_field.dart';
import 'package:ttd_learner/src/common/widgets/custom_shimmer_button.dart';
import 'package:ttd_learner/src/features/auth/controllers/auth_controller.dart';
import 'package:ttd_learner/src/features/auth/views/forgot_passsword_email_input_screen.dart';
import 'package:ttd_learner/src/features/auth/views/sign_up_screen.dart';
import 'package:ttd_learner/src/features/auth/widgets/auth_header_widget.dart';
import 'package:ttd_learner/src/features/auth/widgets/social_buttons_section_widget.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBar(
        backgroundColor: zBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: zPrimaryColor,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
          child: ListView(
            children: [
              Gap(50),
              AuthHeaderWidget(
                title: AppLocalizations.of(context)!.loginTitle,
                description: AppLocalizations.of(context)!.loginDescription,
              ),
              Gap(50),
              CustomInputField(
                hintText: AppLocalizations.of(context)!.email,
                controller: authController.emailController,
                icon: Icons.email,
                isIconRequired: true,
                onChanged: (value) {},
              ),
              CustomInputField(
                hintText: AppLocalizations.of(context)!.password,
                controller: authController.passwordController,
                icon: Icons.remove_red_eye,
                isIconRequired: true,
                isSecure: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: const TextStyle(
                      color: zTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  Gap(5),
                  InkWell(
                    onTap: () {
                      Get.to(() => ForgotPasswordEmailInputScreen());
                    },
                    child: Text(
                      AppLocalizations.of(context)!.buttonResetPassword,
                      style: const TextStyle(
                        color: zTextColorPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Gap(15),
                ],
              ),
              Gap(20),
              SocialButtonSectionWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(
          bottom: Dimensions.zDefaultPadding,
          left: Dimensions.zDefaultPadding,
          right: Dimensions.zDefaultPadding,
        ),
        child: Container(
          height: 95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dontHaveAccount,
                    style: TextStyle(
                      color: zTextColor,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                  Gap(5),
                  InkWell(
                    onTap: () {
                      Get.offAll(() => SignUpScreen());
                    },
                    child: Text(
                      AppLocalizations.of(context)!.buttonSignUp,
                      style: const TextStyle(
                        color: zPrimaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(16),
              Obx(() {
                print(authController.isSignInLoading.value);
                if (authController.isSignInLoading.value) {
                  return CustomShimmerButton();
                } else {
                  return CustomButtonWithIcon(
                    title: AppLocalizations.of(context)!.buttonLogin,
                    onPressed: () async {
                      if (authController.emailController.text.isEmpty ||
                          authController.passwordController.text.isEmpty) {
                        CustomSnackBarService().showWarningSnackBar(
                            message: "Please fill all the fields.");
                      } else {
                        if (authController.isSignInLoading.value == false) {
                          await authController.signInWithEmailAndPassword();
                        }
                      }
                    },
                    icon: Icons.arrow_forward_ios,
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
