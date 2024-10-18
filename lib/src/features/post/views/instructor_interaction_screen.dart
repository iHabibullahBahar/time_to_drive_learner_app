import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/features/post/controllers/message_controller.dart';
import 'package:ttd_learner/src/features/post/models/post_model.dart';
import 'package:ttd_learner/src/features/post/widgets/message_widget.dart';
import 'package:ttd_learner/src/features/post/widgets/review_widget.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';
import 'package:ttd_learner/src/utils/dynamic_components.dart';

class InstructorInteractionScreen extends StatefulWidget {
  final dynamic instructor;
  final Posts post;

  InstructorInteractionScreen(
      {Key? key, required this.instructor, required this.post})
      : super(key: key);

  @override
  State<InstructorInteractionScreen> createState() =>
      _InstructorInteractionScreenState();
}

class _InstructorInteractionScreenState
    extends State<InstructorInteractionScreen> {
  final MessageController messageController = Get.find<MessageController>();
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();

    messageController.getMessages(
        widget.post.id!, widget.instructor.messageRoom.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: zDefaultAppBar(),
      backgroundColor: zBackgroundColor,
      body: ListView(
        children: [
          // Existing content
          _buildInstructorInfo(),

          // Tabs
          _buildTabs(),

          // Tab content
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildInstructorInfo() {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.instructor.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            widget.instructor.totalReviews == 0
                ? AppLocalizations.of(context)!.noReviewsTitle
                : widget.instructor.totalReviews == 1
                    ? "1 review"
                    : "${widget.instructor.totalReviews} reviews",
            style: TextStyle(color: zTextColor),
          ),
          // Add more instructor information here
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 50,
      child: Row(
        children: [
          _buildTabButton(1, "Review"),
          _buildTabButton(2, "Message"),
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, String title) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? zPrimaryColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? zPrimaryColor : zTextColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return Container();
      case 1:
        return ReviewWidget(
          instructor: widget.instructor,
          postId: widget.post.id!,
        );
      case 2:
        return MessageWidget(
          instructor: widget.instructor,
          postId: widget.post.id!,
          messageRoomId: widget.instructor.messageRoom.id,
        );
      default:
        return SizedBox.shrink();
    }
  }
}
