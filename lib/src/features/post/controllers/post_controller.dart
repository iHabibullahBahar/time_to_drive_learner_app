import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/services/custom_snackbar_service.dart';
import 'package:ttd_learner/src/features/post/models/post_model.dart';
import 'package:ttd_learner/src/features/post/models/post_settings_model.dart';
import 'package:ttd_learner/src/helper/api_services.dart';
import 'package:ttd_learner/src/utils/api_urls.dart';
import 'package:ttd_learner/src/utils/app_constants.dart';

class PostController extends GetxController {
  static PostController instance = Get.find();
  List<String> allDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  void onInit() {
    super.onInit();
    clearCreatePostData();
    fetchPosts();
    fetchCreatePostOptions();
  }

  RxBool isPostFetching = false.obs;
  PostModel postModel = PostModel();

  fetchPosts() async {
    try {
      isPostFetching.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: {
          "per_page": 50,
          "page": 1,
        },
        endpoint: zShowPostsEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        postModel = PostModel.fromJson(decoded);
        isPostFetching.value = false;
      } else {
        print("Error in fetching post data");
      }
    } catch (e) {
      print(
          "Error in fetching post: $e ------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>");
    }
  }

  RxBool isCreatePostOptionFetching = false.obs;
  PostSettingsModel postSettingsModel = PostSettingsModel();
  fetchCreatePostOptions() async {
    try {
      isCreatePostOptionFetching.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: {},
        endpoint: zShowCreatePostOperationEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        postSettingsModel = PostSettingsModel.fromJson(decoded);
        isCreatePostOptionFetching.value = false;
      } else {
        print("Error in fetching post data");
      }
    } catch (e) {
      print(
          "Error in fetching post options: $e ------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>");
    }
  }

  RxBool isPostCodeValidating = false.obs;
  Future<bool> isPostCodeValid(String postalCode) async {
    try {
      isPostCodeValidating.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: {"postcode": postalCode},
        endpoint: zValidatePostCodeEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        selectedArea = decoded['data']['area'];
        selectedPostalCode = decoded['data']['postcode'];
        isPostCodeValidating.value = false;
        return true;
      }
    } catch (e) {
      print(zErrorMessage + e.toString());
      isPostCodeValidating.value = false;
      return false;
    }
    isPostCodeValidating.value = false;
    return false;
  }

  // availability:["Monday","Friday","Saturday","Sunday"]
  // title:Test Title from app api 3
  // description:
  // driving_experience:intermediate
  // hourly_budget_range:24-30
  // area:Westminster
  // postcode:SW1W 0NY

  RxBool isPostCreating = false.obs;
  Future<bool> createPost() async {
    selectedTitle =
        selectedTitle == "Custom" ? customTitleController.text : selectedTitle;
    selectedAvailableDays
        .sort((a, b) => allDays.indexOf(a).compareTo(allDays.indexOf(b)));

    try {
      isPostCreating.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: {
          "title": selectedTitle,
          "description": description ?? "",
          "driving_experience": selectedExperience,
          "hourly_budget_range": selectedBudget,
          "area": selectedArea,
          "postcode": selectedPostalCode,
          "availability": jsonEncode(selectedAvailableDays),
        },
        endpoint: zCreatePostEndpoint,
        isAuthToken: true,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        clearCreatePostData();
        isPostCreating.value = false;
        CustomSnackBarService()
            .showSuccessSnackBar(message: zPostCreatedSuccessMessage);
        fetchPosts();
        return true;
      } else {
        print("Error in creating post");
      }
    } catch (e) {
      print(zErrorMessage + e.toString());
    }
    return false;
  }

  int currentIndex = 0;
  double spaceBetweenInput = 30;
  String selectedTitle = '';
  String description = '';
  String selectedBudget = '';
  String selectedExperience = '';
  String selectedPostalCode = '';
  String selectedArea = '';
  List<String> selectedAvailableDays = [];
  TextEditingController customTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  clearCreatePostData() {
    selectedTitle = '';
    description = '';
    selectedBudget = '';
    selectedExperience = '';
    selectedPostalCode = '';
    selectedArea = '';
    customTitleController.clear();
    descriptionController.clear();
    postalCodeController.clear();
    currentIndex = 0;
    selectedAvailableDays = [];
    selectedAvailableDays = List.from(allDays);
    update();
    print(selectedAvailableDays);
  }

  bool validatePostcode() {
    if (selectedPostalCode.isEmpty || selectedArea.isEmpty) {
      CustomSnackBarService()
          .showWarningSnackBar(message: "Please enter a valid postcode");
      return false;
    }
    return true;
  }

  bool validateCurrentStep() {
    switch (currentIndex) {
      case 0:
        if (selectedTitle.isEmpty) {
          CustomSnackBarService()
              .showWarningSnackBar(message: "Please select a title");
          return false;
        }
        break;
      case 2:
        if (selectedExperience.isEmpty) {
          CustomSnackBarService().showWarningSnackBar(
              message: "Please select your driving experience");
          return false;
        }
        break;
      case 3:
        if (selectedBudget.isEmpty) {
          CustomSnackBarService()
              .showWarningSnackBar(message: "Please select your hourly budget");
          return false;
        }
        break;
      case 4:
        if (selectedAvailableDays.isEmpty) {
          CustomSnackBarService().showWarningSnackBar(
              message: "Please select at least one day of availability");
          return false;
        }
        break;
      case 5:
        return validatePostcode();
    }
    return true;
  }
}
