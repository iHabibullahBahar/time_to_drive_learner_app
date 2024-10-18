import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/services/common_converter.dart';
import 'package:ttd_learner/src/common/services/custom_snackbar_service.dart';
import 'package:ttd_learner/src/features/post/controllers/review_controller.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class ReviewWidget extends StatefulWidget {
  final dynamic instructor;
  final int postId;

  const ReviewWidget({
    Key? key,
    required this.instructor,
    required this.postId,
  }) : super(key: key);

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  final ReviewController _reviewController = Get.find<ReviewController>();
  final TextEditingController _reviewTextController = TextEditingController();
  int _rating = 0;
  bool _showReviewForm = false;

  @override
  void initState() {
    super.initState();
    _reviewController.getReviews(widget.instructor.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - 300,
      padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reviews',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildReviewForm(),
            SizedBox(height: 16),
            _buildReviewsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewForm() {
    if (!widget.instructor.isShortlisted) {
      return SizedBox.shrink();
    }

    return (_reviewController.reviewModel.data?.reviews
                ?.any((review) => review.postId == widget.postId) ??
            false)
        ? Text('You have already submitted a review for this post.')
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How was your experience?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: zPrimaryColor,
                      size: 32,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                        _showReviewForm = true;
                      });
                    },
                  );
                }),
              ),
              if (_showReviewForm) ...[
                SizedBox(height: 16),
                TextField(
                  controller: _reviewTextController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Write your review here...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitReview,
                  child: Text('Submit Review'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: zPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
              ],
            ],
          );
  }

  Widget _buildReviewsList() {
    return Obx(() {
      if (_reviewController.isReviewFetching.value) {
        return Center(child: CircularProgressIndicator());
      }

      final reviews = _reviewController.reviewModel.data?.reviews ?? [];

      if (reviews.isEmpty) {
        return Text('No reviews available for this instructor.');
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: zPrimaryColor,
                        child: Text(
                          review.user?.name?[0].toUpperCase() ?? 'U',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.user?.name ?? 'Unknown User',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Review left on ${getTimeAgo(DateTime.parse(review.createdAt ?? ''))}',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < (review.rating ?? 0)
                            ? Icons.star
                            : Icons.star_border,
                        color: zPrimaryColor,
                        size: 20,
                      );
                    }),
                  ),
                  SizedBox(height: 8),
                  if (review.post?.title! != null)
                    Text(
                      review.post!.title ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  SizedBox(height: 8),
                  Text(review.review ?? ''),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  void _submitReview() async {
    if (_rating == 0 || _reviewTextController.text.isEmpty) {
      Get.snackbar('Error', 'Please provide both a rating and a review.');
      return;
    }

    try {
      await _reviewController.sendReview(
        widget.postId,
        widget.instructor.id,
        _rating,
        _reviewTextController.text,
      );

      setState(() {
        _showReviewForm = false;
        _rating = 0;
        _reviewTextController.clear();
      });

      CustomSnackBarService()
          .showSuccessSnackBar(message: "Review submitted successfully.");
    } catch (e) {
      CustomSnackBarService()
          .showErrorSnackBar(message: "Opps! Something went wrong.");
    }
  }

  @override
  void dispose() {
    _reviewTextController.dispose();
    super.dispose();
  }
}
