import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/global.dart';
import 'package:ttd_learner/src/features/auth/controllers/auth_controller.dart';
import 'package:ttd_learner/src/features/auth/views/sign_in_screen.dart';
import 'package:ttd_learner/src/features/onboarding/views/onboarding_screen.dart';
import 'package:ttd_learner/src/utils/app_constants.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (GlobalStorage.instance.isNotFirstTime == false) {
        Get.offAll(() => OnboardingScreen());
      } else if (GlobalStorage.instance.isLoggedIn == false) {
        Get.offAll(() => SignInScreen());
      } else {
        Get.put(AuthController());
        AuthController.instance.validateUser();
      }
      // GlobalStorage.instance.isNotFirstTime == false
      //     ? Get.offAll(() => OnboardingScreen())
      //     : GlobalStorage.instance.isLogged == false
      //         ? Get.offAll(() => SignInScreen())
      //         : AuthController.instance.validateUser();
      // Get.offAll(() => GlobalStorage.instance.isNotFirstTime == false
      //     ? OnboardingScreen()
      //     : !GlobalStorage.instance.isLogged
      //         ? SignInScreen()
      //         : NavigationBarScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: zWhiteColor,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  zAppLogo,
                  height: 60,
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      zAppNameFirstPart,
                      style: TextStyle(
                        fontSize: 25,
                        color: zPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      zAppNameSecondPart,
                      style: TextStyle(
                        fontSize: 25,
                        color: zTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Positioned(
              bottom: 0,
              child: SafeArea(
                minimum: EdgeInsets.only(bottom: 20),
                child: CircularProgressIndicator(
                  color: zPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
