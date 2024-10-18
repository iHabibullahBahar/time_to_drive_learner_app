import 'dart:math';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ttd_learner/global.dart';
import 'package:ttd_learner/src/features/post/controllers/message_controller.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';
import 'package:ttd_learner/src/utils/dynamic_components.dart';

class MessageWidget extends StatefulWidget {
  final dynamic instructor;
  final int postId;
  final int messageRoomId;

  const MessageWidget({
    Key? key,
    required this.instructor,
    required this.postId,
    required this.messageRoomId,
  }) : super(key: key);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  final MessageController _messageController = Get.find<MessageController>();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messageController.getMessages(widget.postId, widget.messageRoomId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - 250,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
        child: Scaffold(
          body: Container(
            child: Obx(
              () => _messageController.isMessageFetching.value
                  ? const Center(child: CircularProgressIndicator())
                  : Chat(
                      // dateHeaderBuilder: (date) => Container(
                      //   margin: const EdgeInsets.symmetric(vertical: 20),
                      //   child: Center(
                      //     child: Text(
                      //       DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                      //       style: const TextStyle(
                      //         color: zTextColor,
                      //         fontSize: 12,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      systemMessageBuilder: (message) {
                        if (message.text == 'contact_shared') {
                          return _buildContactSharedMessage(widget.instructor);
                        }
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                              // border: DynamicComponents.zDefaultBorder,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Text(
                                message.text,
                                style: const TextStyle(
                                  color: zTextColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      customBottomWidget: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: messageController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 10,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Write a message',
                                    contentPadding: EdgeInsets.all(18),
                                    isDense: true,
                                    prefix: const SizedBox(width: 10),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              zPrimaryColor.withOpacity(0.5)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      borderSide: BorderSide(
                                          width: 1, color: zGraySwatch[100]!),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: zPrimarySwatch[100]!),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    _handleSendPressed(messageController.text),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: zPrimaryColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: Transform.translate(
                                        offset: const Offset(2.5, -2.5),
                                        child: Transform.rotate(
                                          angle: -45 * pi / 180,
                                          child: Icon(
                                            Icons.send,
                                            color: Colors.white,
                                            size: 32,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      showUserAvatars: true,
                      avatarBuilder: (user) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: FancyShimmerImage(
                              imageUrl: "",
                              errorWidget: Container(
                                decoration: BoxDecoration(
                                  color: zGraySwatch[400],
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    user.firstName![0],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      dateLocale: 'en',
                      timeFormat: DateFormat('HH:mm'),
                      inputOptions: InputOptions(
                        sendButtonVisibilityMode:
                            SendButtonVisibilityMode.always,
                        autocorrect: false,
                      ),
                      showUserNames: true,
                      dateHeaderThreshold: 300000,
                      dateIsUtc: false,
                      emptyState: const Center(
                        child: Text(
                          "No Message\n Send a message now!",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      theme: DefaultChatTheme(
                        receivedMessageBodyTextStyle: const TextStyle(
                          color: zTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                        sentMessageBodyTextStyle: const TextStyle(
                          color: zTextColorLight,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                        inputTextColor: zBlackColor,
                        inputContainerDecoration: BoxDecoration(
                          color: zPrimaryColor,
                        ),
                        primaryColor: zPrimaryColor,
                        userAvatarNameColors: [zGraySwatch[500] ?? zBlackColor],
                        userNameTextStyle:
                            TextStyle(fontWeight: FontWeight.bold),
                        secondaryColor: zGraySwatch[50] ?? zBlackColor,
                      ),
                      messages: _getMessages(),
                      user: _getUser(),
                      l10n: ChatL10nEn(
                        inputPlaceholder: 'Write Your Message',
                      ),
                      onSendPressed: (types.PartialText message) {
                        _handleSendPressed(message.text);
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }

  List<types.Message> _getMessages() {
    final currentUserId =
        getCurrentUserId(); // Replace with your method of getting the current user's ID

    return _messageController.messageModel.data?.messages?.where((message) {
          if (message.senderType == 'system') {
            // Show system message if forWhom is 0 or matches the current user's ID
            return message.forWhom == 0 ||
                message.forWhom.toString() == currentUserId;
          }
          return true; // Show all non-system messages
        }).map((message) {
          if (message.senderType == 'system') {
            return types.SystemMessage(
              id: message.id.toString(),
              text: message.text ?? '',
              createdAt:
                  DateTime.parse(message.createdAt!).millisecondsSinceEpoch,
              author: types.User(id: 'system'), // Add this line
            );
          }

          final isUserMessage = message.senderType != 'instructor';

          return types.TextMessage(
            author: types.User(
              id: isUserMessage ? _getUser().id : message.senderId.toString(),
              firstName: isUserMessage ? 'You' : widget.instructor.name,
            ),
            id: message.id.toString(),
            text: message.text ?? '',
            createdAt:
                DateTime.parse(message.createdAt!).millisecondsSinceEpoch,
          );
        }).toList() ??
        [];
  }

  // Placeholder function - replace with your actual method of getting the current user's ID
  String getCurrentUserId() {
    print('GlobalStorage.instance.userId: ${GlobalStorage.instance.userId}');
    // This should return the current user's ID as a string
    return GlobalStorage.instance.userId.toString();
  }

  types.User _getUser() {
    return types.User(
      id: GlobalStorage.instance.userId.toString(),
      firstName: 'You',
    );
  }

  Widget _buildContactSharedMessage(dynamic instructor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: DynamicComponents.zDefaultBorder),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Name: ${instructor.name}'),
            Text('Phone: ${instructor.phone}'),
            Text('Email: ${instructor.email}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement call functionality
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('Call'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: zPrimaryColor,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement email functionality
                  },
                  icon: const Icon(Icons.email),
                  label: const Text('Email'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: zPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleSendPressed(String message) async {
    if (message.trim().isEmpty) {
      return;
    }
    messageController.clear();
    await _messageController.sendMessage(
        widget.postId, widget.messageRoomId, message);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
