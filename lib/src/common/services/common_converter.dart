String getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.isNegative) {
    // Handle future dates like Laravel's "diffForHumans"
    final futureDifference = dateTime.difference(now);

    if (futureDifference.inDays >= 365) {
      return "${(futureDifference.inDays / 365).floor()} ${futureDifference.inDays ~/ 365 == 1 ? "year" : "years"} from now";
    } else if (futureDifference.inDays >= 30) {
      return "${(futureDifference.inDays / 30).floor()} ${futureDifference.inDays ~/ 30 == 1 ? "month" : "months"} from now";
    } else if (futureDifference.inDays > 0) {
      return "In ${futureDifference.inDays} ${futureDifference.inDays == 1 ? "day" : "days"}";
    } else if (futureDifference.inHours > 0) {
      return "In ${futureDifference.inHours} ${futureDifference.inHours == 1 ? "hour" : "hours"}";
    } else if (futureDifference.inMinutes > 0) {
      return "In ${futureDifference.inMinutes} ${futureDifference.inMinutes == 1 ? "minute" : "minutes"}";
    } else {
      return "In a few seconds";
    }
  }

  // Handle past dates like Laravel's "diffForHumans"
  if (difference.inDays >= 365) {
    return "${(difference.inDays / 365).floor()} ${difference.inDays ~/ 365 == 1 ? "year" : "years"} ago";
  } else if (difference.inDays >= 30) {
    return "${(difference.inDays / 30).floor()} ${difference.inDays ~/ 30 == 1 ? "month" : "months"} ago";
  } else if (difference.inDays > 0) {
    return "${difference.inDays} ${difference.inDays == 1 ? "day" : "days"} ago";
  } else if (difference.inHours > 0) {
    return "${difference.inHours} ${difference.inHours == 1 ? "hour" : "hours"} ago";
  } else if (difference.inMinutes > 0) {
    return "${difference.inMinutes} ${difference.inMinutes == 1 ? "minute" : "minutes"} ago";
  } else if (difference.inSeconds > 0) {
    return "${difference.inSeconds} ${difference.inSeconds == 1 ? "second" : "seconds"} ago";
  } else {
    return "Just now";
  }
}
