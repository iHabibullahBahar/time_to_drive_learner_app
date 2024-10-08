import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttd_learner/src/common/services/custom_snackbar_service.dart';
import 'package:ttd_learner/src/features/profile/controllers/profile_controller.dart';
import 'package:ttd_learner/src/utils/api_urls.dart';
import 'package:mime/mime.dart';

import '../../../common/contollers/local_storage_controller.dart';
import '../../../utils/app_constants.dart';

class ProfilePictureUploadController extends GetxController {
  static ProfilePictureUploadController instance = Get.find();
  @override
  RxString imagePath = ''.obs;
  RxBool isImageUploading = false.obs;
  //int userId = GlobalStorage.to.userId;
  int uploadStatus = 0;
  List<String> imageExtensions = [
    "png",
    "jpg",
    "jpeg",
    "gif",
    "bmp",
    "webp",
    "tiff",
    "heic",
    "heif"
  ];
  RxString extension = ''.obs;
  Future getImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage;
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    extension.value = pickedImage!.path.split('.').last;
    print(extension.value);
    print(imageExtensions.contains(extension.value));
    print(pickedImage.path.toString());
    if (pickedImage != null) {
      if (imageExtensions.contains(extension.value)) {
        imagePath.value = pickedImage.path.toString();
      } else {
        imagePath.value = '';
        CustomSnackBarService().showWarningSnackBar(
            message: "Valid image formats are png, jpg, jpeg and heic");
      }
    }
  }

  Future<bool> updatePhoto() async {
    try {
      http.MultipartRequest request = http.MultipartRequest(
          'POST', Uri.parse(zApiDomain + zUpdatePhotoEndpoint));
      var authToken =
          await LocalStorageController.instance.getString(zAuthToken);
      var headers = {'Accept': '*/*', 'Authorization': 'Bearer $authToken'};
      request.headers.addAll(headers);

      File file = File(imagePath.value);

      print("MIME: ${lookupMimeType(imagePath.value)}");
      var mimeType = lookupMimeType(imagePath.value) ?? 'image/jpeg';
      var mediaType = MediaType.parse(mimeType);
      request.files.add(await http.MultipartFile.fromPath('image', file.path,
          contentType: mediaType));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        print(responseString);
        print("Image uploaded successfully");
        ProfileController.instance.fetchProfile();
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
