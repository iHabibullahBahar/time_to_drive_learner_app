import 'dart:convert';

import 'package:get/get.dart';
import 'package:ttd_learner/src/features/post/models/message_model.dart';
import 'package:ttd_learner/src/helper/api_services.dart';
import 'package:ttd_learner/src/utils/api_urls.dart';

class MessageController extends GetxController {
  static MessageController instance = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  ///Message Fetching Functionality
  RxBool isMessageFetching = false.obs;
  MessageModel messageModel = MessageModel();
  @override
  getMessages(int postId, int messageRoomId) async {
    try {
      isMessageFetching.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: {
          "post_id": postId,
          "message_room_id": messageRoomId,
        },
        endpoint: zShowMessagesEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        messageModel = MessageModel.fromJson(decoded);
        isMessageFetching.value = false;
      } else {
        print("Error in fetching message data");
      }
    } catch (e) {
      print(
          "Error in fetching message: $e ------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>");
    }
  }

  RxBool isMessageSending = false.obs;
  sendMessage(int postId, int messageRoomId, String message) async {
    try {
      isMessageSending.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: {
          "post_id": postId,
          "message_room_id": messageRoomId,
          "text": message,
          "sender_type": "user",
        },
        endpoint: zSendMessageEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Message sent successfully");
        // Add the new message to the existing messages
        messageModel.data?.messages
            ?.insert(0, Messages.fromJson(decoded['data']['message']));
        update();
      } else {
        print("Error in sending message");
      }
    } catch (e) {
      print("Error in sending message: $e");
    }
    isMessageSending.value = false;
  }

  // Add a method to handle real-time updates (you'll need to implement WebSocket or other real-time solution)
  void handleNewMessage(dynamic messageData) {
    Messages newMessage = Messages.fromJson(messageData);
    messageModel.data?.messages?.insert(0, newMessage);
    update();
  }
}
