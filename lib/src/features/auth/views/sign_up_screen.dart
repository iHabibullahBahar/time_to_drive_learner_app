import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/contollers/local_storage_controller.dart';
import 'package:ttd_learner/src/common/services/custom_snackbar_service.dart';
import 'package:ttd_learner/src/common/widgets/custom_button_with_icon.dart';
import 'package:ttd_learner/src/common/widgets/custom_input_field.dart';
import 'package:ttd_learner/src/common/widgets/custom_shimmer_button.dart';
import 'package:ttd_learner/src/common/widgets/web_view_page.dart';
import 'package:ttd_learner/src/features/auth/controllers/auth_controller.dart';
import 'package:ttd_learner/src/features/auth/views/sign_in_screen.dart';
import 'package:ttd_learner/src/features/auth/widgets/auth_header_widget.dart';
import 'package:ttd_learner/src/features/navigation_bar/views/navigation_bar_screen.dart';
import 'package:ttd_learner/src/helper/data_validator.dart';
import 'package:ttd_learner/src/utils/api_urls.dart';
import 'package:ttd_learner/src/utils/app_constants.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthController authController = Get.put(AuthController());

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
              Gap(20),
              AuthHeaderWidget(
                title: AppLocalizations.of(context)!.signUpTitle,
                description: AppLocalizations.of(context)!.signUpDescription,
              ),
              Gap(30),
              CustomInputField(
                hintText: AppLocalizations.of(context)!.fullName,
                controller: authController.nameController,
              ),
              CustomInputField(
                hintText: AppLocalizations.of(context)!.email,
                controller: authController.emailController,
                icon: Icons.mail,
                isIconRequired: true,
              ),
              CustomInputField(
                hintText: AppLocalizations.of(context)!.password,
                controller: authController.passwordController,
                icon: Icons.remove_red_eye,
                isIconRequired: true,
                isSecure: true,
              ),
              CustomInputField(
                hintText: AppLocalizations.of(context)!.phoneNumber,
                controller: authController.phoneController,
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      side: const BorderSide(
                        color: zPrimaryColor,
                      ),
                      value: authController.isTermsAndConditionsAccepted.value,
                      activeColor: zPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          authController.isTermsAndConditionsAccepted.value =
                              value!;
                        });
                      },
                    ),
                  ),
                  const Gap(10),
                  SizedBox(
                    height: 60,
                    width: Get.width - 2 * Dimensions.zDefaultPadding - 35,
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "I’ve read and agree with the ",
                            style: const TextStyle(
                              color: zTextColor,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                          TextSpan(
                            text: "Terms & Conditions",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                var authToken = await LocalStorageController
                                    .instance
                                    .getString(zAuthToken);
                                Get.to(
                                  () => WebViewPage(
                                      url: zTermsAndConditionsEndpoint,
                                      authToken: authToken!,
                                      pageName: "",
                                      method: "GET",
                                      title: "Terms and Conditions"),
                                );
                              },
                          ),
                          TextSpan(
                            text: " and ",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                var authToken = await LocalStorageController
                                    .instance
                                    .getString(zAuthToken);
                                Get.to(
                                  () => WebViewPage(
                                      url: zWebDomain + zPrivacyPolicyEndpoint,
                                      authToken: authToken!,
                                      pageName: "",
                                      method: "GET",
                                      title: "Privacy Policy"),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                    AppLocalizations.of(context)!.alreadyHaveAccount,
                    style: TextStyle(
                      color: zTextColor,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                  Gap(5),
                  InkWell(
                    onTap: () {
                      Get.offAll(() => SignInScreen());
                    },
                    child: Text(
                      AppLocalizations.of(context)!.buttonLogin,
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
                if (authController.isSignUpLoading.value) {
                  return CustomShimmerButton();
                } else {
                  return CustomButtonWithIcon(
                    title: AppLocalizations.of(context)!.buttonSignUp,
                    onPressed: () async {
                      if (await validateData()) {
                        if (await authController.signUpWithEmailAndPassword()) {
                          //Get.to(() => OtpInputScreen());
                          Get.offAll(() => NavigationBarScreen());
                        }
                      }
                    },
                    icon: Icons.arrow_forward_ios,
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> validateData() async {
    if (authController.nameController.text.isEmpty) {
      CustomSnackBarService()
          .showWarningSnackBar(message: "Please enter your full name");
      return false;
    } else if (authController.emailController.text.isEmpty) {
      CustomSnackBarService()
          .showWarningSnackBar(message: "Please enter your email");
      return false;
    } else if (!DataValidator.validateEmail(
        authController.emailController.text)) {
      CustomSnackBarService()
          .showErrorSnackBar(message: "Please enter a valid email");
      return false;
    } else if (authController.passwordController.text.length < 6) {
      CustomSnackBarService().showWarningSnackBar(
          message: "Password must be at least 6 characters");
      return false;
    } else if (authController.phoneController.text.isEmpty) {
      CustomSnackBarService()
          .showWarningSnackBar(message: "Please enter your phone number");
      return false;
    } else if (!authController.isTermsAndConditionsAccepted.value) {
      CustomSnackBarService()
          .showWarningSnackBar(message: "Please accept terms and conditions");
      return false;
    }
    return true;
  }
}
