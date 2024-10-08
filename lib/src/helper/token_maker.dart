import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';

class TokenMaker extends GetxController {
  static TokenMaker instance = Get.find();
  String generateRandomString(int length) {
    const charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(
        length, (index) => charset[random.nextInt(charset.length)]).join();
  }

  Future<dynamic> secureAPI(String email) async {
    final secureRandom = generateRandomString(32);
    final constantSalt = sha512.convert(utf8.encode("incheck")).toString();
    // Step 1: Concatenate email and (constant value)
    final concatenatedData = email + "incheck" + secureRandom;

    // Step 2: Calculate SHA-512 hash of concatenated data
    final sha512Hash = sha512.convert(utf8.encode(concatenatedData)).toString();

    final code = sha512Hash;

    return {
      "certainty": code,
      "security": constantSalt + secureRandom,
    };
  }
}
