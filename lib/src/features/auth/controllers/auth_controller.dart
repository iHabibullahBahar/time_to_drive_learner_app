import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ttd_learner/global.dart';
import 'package:ttd_learner/src/common/contollers/common_controller.dart';
import 'package:ttd_learner/src/common/contollers/local_storage_controller.dart';
import 'package:ttd_learner/src/common/services/custom_snackbar_service.dart';
import 'package:ttd_learner/src/features/auth/views/sign_in_screen.dart';
import 'package:ttd_learner/src/features/navigation_bar/views/navigation_bar_screen.dart';
import 'package:ttd_learner/src/features/profile/controllers/profile_controller.dart';
import 'package:ttd_learner/src/helper/api_services.dart';
import 'package:ttd_learner/src/helper/token_maker.dart';
import 'package:ttd_learner/src/utils/api_urls.dart';
import 'package:ttd_learner/src/utils/app_constants.dart';
import 'package:ttd_learner/src/utils/colors.dart';
//import 'package:onesignal_flutter/onesignal_flutter.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RxBool isTermsAndConditionsAccepted = false.obs;

  ///Sign Up With Email and Password
  RxBool isSignUpLoading = false.obs;
  Future<bool> signUpWithEmailAndPassword() async {
    try {
      var requestBody = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "phone": phoneController.text
      };
      isSignUpLoading.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zSignUpEndpoint,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        LocalStorageController.instance
            .setString(zEmail, decoded['data']['email']);
        LocalStorageController.instance.setInt(zUserId, decoded['data']['uid']);
        LocalStorageController.instance
            .setString(zAuthToken, decoded['data']['auth_token']);
        // bool isOTPSent =
        //     await sendOTP(decoded['data']['uid'], decoded['data']['email']);
        isSignUpLoading.value = false;

        ///Set OneSignal user id
        ///Here the employee id will saved as Onesignal external user id
        // if (!kIsWeb) {
        //   OneSignal.login(decoded['data']['uid'].toString());
        // }

        // if (isOTPSent) {
        //   return true;
        // }
        return true;
      } else {
        if (decoded['success'] == false) {
          if (decoded['message'] == 'The email has already been taken.') {
            CustomSnackBarService()
                .showErrorSnackBar(message: "Email already exists");
          } else {
            CustomSnackBarService()
                .showErrorSnackBar(message: "Something went wrong");
          }
          isSignUpLoading.value = false;
          return false;
        }
      }
    } catch (e) {
      isSignUpLoading.value = false;
      return false;
    }
    isSignUpLoading.value = false;
    return false;
  }

  ///Sign In With Email and Password
  RxBool isSignInLoading = false.obs;
  Future<bool> signInWithEmailAndPassword() async {
    isSignInLoading.value = true;
    var requestBody = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    var response = await ApiServices.instance.getResponse(
      requestBody: requestBody,
      endpoint: zSignInEndpoint,
    );
    try {
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        await LocalStorageController.instance
            .setString(zAuthToken, decoded['data']['auth_token']);
        LocalStorageController.instance.setBool(zIsLoggedIn, true);
        LocalStorageController.instance.setInt(zUserId, decoded['data']['uid']);
        GlobalStorage.instance.userId = decoded['data']['uid'];
        GlobalStorage.instance.isLoggedIn = true;
        emailController.clear();
        passwordController.clear();
        await validateUser();
        isSignInLoading.value = false;
        return true;
      } else {
        if (decoded['success'] == false) {
          CustomSnackBarService()
              .showErrorSnackBar(message: "Invalid email or password");
        }
      }
    } catch (e) {
      print('Error signing in with email and password: $e');
    }
    isSignInLoading.value = false;
    return false;
  }

  ///Google Sign In
  Future<bool> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Get the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential using the Google Sign-In authentication
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Sign in to Firebase with the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the Firebase user
      final User? user = userCredential.user;

      // Print Firebase ID
      print('Firebase ID: ${user!.uid}');

      // Print other user details
      print('Email: ${user.email}');
      print('Display Name: ${user.displayName}');
      print('Photo URL: ${user.photoURL}');

      await LocalStorageController.instance
          .setString(zUserFullName, user.displayName!);

      var token = await TokenMaker.instance.secureAPI(user.email!);

      var certainty = token['certainty'];
      var security = token['security'];

      await signInWithSSO(
          email: user.email!,
          firebaseId: user.uid,
          certainty: certainty,
          security: security);

      ///TODO: Need to add the functionality to save the user details in the database

      return true;
    } catch (e) {
      print('Error signing in with Google: $e');
      return false;
    }
  }

  Future<bool> signInWithSSO(
      {required String email,
      required String firebaseId,
      required String certainty,
      required String security}) async {
    try {
      var requestBody = {
        "email": email,
        "firebase_id": firebaseId,
        "certainty": certainty,
        "security": security,
      };
      isSignInLoading.value = true;
      ApiServices.instance
          .getResponse(
        requestBody: requestBody,
        endpoint: zSocialSignInEndpoint,
      )
          .then((response) async {
        var decoded = jsonDecode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          await LocalStorageController.instance
              .setString(zAuthToken, decoded['data']['auth_token']);
          await LocalStorageController.instance
              .setString(zAuthTokenValidTill, decoded['data']['validity']);
          LocalStorageController.instance.setBool(zIsLoggedIn, true);
          GlobalStorage.instance.isLoggedIn = true;
          emailController.clear();
          passwordController.clear();
          isSignInLoading.value = false;
          await validateUser();
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
          isSignInLoading = false.obs;
          return false;
        }
      });
    } catch (e) {
      isSignInLoading.value = false;
      return false;
    }
    isSignInLoading.value = false;
    return false;
  }

  ///Apple Sign In
  Future<bool> signInWithApple() async {
    ///TODO: Implement Apple Sign In after getting the Apple Developer Account
    return true;
  }

  ///Validate User
  Future<dynamic> validateUser() async {
    try {
      var response = await ApiServices.instance.getResponse(
        requestBody: {},
        isAuthToken: true,
        endpoint: zValidateUserEndpoint,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Get.put(ProfileController());
        await ProfileController.instance.fetchProfile();

        ///Set OneSignal user id
        ///Here the employee id will saved as Onesignal external user id
        // if (!kIsWeb) {
        //   OneSignal.login(
        //       ProfileController.instance.profileModel.data!.id!.toString());
        // }

        var redirect = decoded['data']['redirect'];
        if (redirect == 'dashboard') {
          Get.offAll(() => NavigationBarScreen());
        }
        return true;
      } else {
        if (decoded['success'] == false) {
          if (decoded['message'] == 'Access token expired!') {
            CustomSnackBarService().showErrorSnackBar(
                message: "Session expired. Please login again");
            await signOut();
            Get.offAll(() => SignInScreen());
          } else {
            CustomSnackBarService().showErrorSnackBar(
                message: "Something went wrong. Please login again");
            await signOut();
            Get.offAll(() => SignInScreen());
          }
        }
        return false;
      }
    } catch (e) {
      print('Error validating user: $e');
      return false;
    }
  }

  ///Send OTP
  Future<bool> sendOTP(int userId, String email) async {
    try {
      var requestBody = {
        "uid": userId,
        "email": email,
      };
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zSendOtpEndpoint,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
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
        return false;
      }
    } catch (e) {
      print('Error sending OTP: $e');
      return false;
    }
  }

  ///Verify OTP
  Future<bool> verifyOTP(String otp) async {
    try {
      var requestBody = {
        "uid": await LocalStorageController.instance.getInt(zUserId),
        "email": await LocalStorageController.instance.getString(zEmail),
        "otp": int.parse(otp),
      };
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zVerifyOtpEndpoint,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        LocalStorageController.instance
            .setString(zAuthToken, decoded['data']['auth_token']);
        LocalStorageController.instance
            .setString(zAuthTokenValidTill, decoded['data']['validity']);
        AuthController.instance.otpController.clear();
        LocalStorageController.instance.setBool(zIsLoggedIn, true);
        validateUser();
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
        AuthController.instance.otpController.clear();
        return false;
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      AuthController.instance.otpController.clear();
      return false;
    }
  }

  ///Forgot Password

  Future<bool> forgotPassword({required String email}) async {
    try {
      var requestBody = {
        "email": email,
      };
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zForgotPasswordEndpoint,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        emailController.clear();
        Get.snackbar(
          'Success',
          "We've sent you an email with a link to reset your password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: zSuccessSwatch,
          colorText: zWhiteColor,
          duration: const Duration(seconds: 3),
        );
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
        return false;
      }
    } catch (e) {
      print('Error sending OTP: $e');
      return false;
    }
  }

  ///Sign Out
  Future<void> signOut() async {
    try {
      await LocalStorageController.instance.clearInstance(zAuthToken);
      await LocalStorageController.instance.clearInstance(zAuthTokenValidTill);
      await LocalStorageController.instance.clearInstance(zIsLoggedIn);
      await LocalStorageController.instance.clearInstance(zUserId);
      //OneSignal.logout();
      Get.delete<CommonController>();
      Get.offAll(() => const SignInScreen());
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
