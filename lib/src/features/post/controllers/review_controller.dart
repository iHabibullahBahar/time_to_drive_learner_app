import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/features/post/models/review_model.dart';
import 'package:ttd_learner/src/helper/api_services.dart';
import 'package:ttd_learner/src/utils/api_urls.dart';

class ReviewController extends GetxController {
  static ReviewController instance = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  ///Review Fetching Functionality
  RxBool isReviewFetching = false.obs;
  ReviewModel reviewModel = ReviewModel();
  @override
  getReviews(int instructorId) async {
    try {
      isReviewFetching.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: {
          "instructor_id": instructorId,
        },
        endpoint: zShowReviewsEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        reviewModel = ReviewModel.fromJson(decoded);
        isReviewFetching.value = false;
      } else {
        print("Error in fetching Review data");
      }
    } catch (e) {
      print(
          "Error in fetching Review: $e ------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>");
    }
  }

  TextEditingController reviewTextController = TextEditingController();

  RxBool isReviewSending = false.obs;
  sendReview(int postId, int instructorId, int rating, String review) async {
    try {
      isReviewSending.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: {
          "post_id": postId,
          "instructor_id": instructorId,
          "rating": rating,
          "review": review,
        },
        endpoint: zCreateReviewEndpoint,
        isAuthToken: true,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        getReviews(instructorId);
      } else {
        print("Error in sending Review");
      }
    } catch (e) {
      print("Error in sending Review: $e");
    }
    isReviewSending.value = false;
  }
}
