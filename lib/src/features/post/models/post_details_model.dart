class PostDetailsModel {
  bool? success;
  String? message;
  Data? data;

  PostDetailsModel({this.success, this.message, this.data});

  PostDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? title;
  String? description;
  String? location;
  String? selectedPostalCode;
  int? shortlistingFee;
  int? totalInterested;
  int? totalShortlisted;
  String? details;
  String? images;
  String? status;
  List<ShortlistedInstructors>? shortlistedInstructors;
  int? hourlyRate;
  String? createdAt;
  String? updatedAt;
  List<InterestedInstructors>? interestedInstructors;

  Data(
      {this.id,
      this.userId,
      this.title,
      this.description,
      this.location,
      this.selectedPostalCode,
      this.shortlistingFee,
      this.totalInterested,
      this.totalShortlisted,
      this.details,
      this.images,
      this.status,
      this.shortlistedInstructors,
      this.hourlyRate,
      this.createdAt,
      this.updatedAt,
      this.interestedInstructors});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    location = json['location'];
    selectedPostalCode = json['selected_postal_code'];
    shortlistingFee = json['shortlisting_fee'];
    totalInterested = json['total_interested'];
    totalShortlisted = json['total_shortlisted'];
    details = json['details'];
    images = json['images'];
    status = json['status'];
    if (json['shortlisted_instructors'] != null) {
      shortlistedInstructors = <ShortlistedInstructors>[];
      json['shortlisted_instructors'].forEach((v) {
        shortlistedInstructors!.add(new ShortlistedInstructors.fromJson(v));
      });
    }
    hourlyRate = json['hourly_rate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['interested_instructors'] != null) {
      interestedInstructors = <InterestedInstructors>[];
      json['interested_instructors'].forEach((v) {
        interestedInstructors!.add(new InterestedInstructors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['location'] = this.location;
    data['selected_postal_code'] = this.selectedPostalCode;
    data['shortlisting_fee'] = this.shortlistingFee;
    data['total_interested'] = this.totalInterested;
    data['total_shortlisted'] = this.totalShortlisted;
    data['details'] = this.details;
    data['images'] = this.images;
    data['status'] = this.status;
    if (this.shortlistedInstructors != null) {
      data['shortlisted_instructors'] =
          this.shortlistedInstructors!.map((v) => v.toJson()).toList();
    }
    data['hourly_rate'] = this.hourlyRate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.interestedInstructors != null) {
      data['interested_instructors'] =
          this.interestedInstructors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShortlistedInstructors {
  int? id;
  String? name;
  int? totalReviews;
  String? email;
  String? phone;
  String? image;
  int? messageRoomId;
  bool? isShortlisted;
  MessageRoom? messageRoom;

  ShortlistedInstructors(
      {this.id,
      this.name,
      this.totalReviews,
      this.email,
      this.phone,
      this.image,
      this.messageRoomId,
      this.isShortlisted,
      this.messageRoom});

  ShortlistedInstructors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalReviews = json['total_reviews'];
    email = json['email'];
    image = json['image'] ?? '';
    phone = json['phone'] ?? '';
    messageRoomId = json['message_room_id'];
    isShortlisted = json['isShortlisted'];
    messageRoom = json['messageRoom'] != null
        ? new MessageRoom.fromJson(json['messageRoom'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['total_reviews'] = this.totalReviews;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['message_room_id'] = this.messageRoomId;
    data['isShortlisted'] = this.isShortlisted;
    if (this.messageRoom != null) {
      data['messageRoom'] = this.messageRoom!.toJson();
    }
    return data;
  }
}

class InterestedInstructors {
  int? id;
  String? name;
  int? totalReviews;
  String? email;
  String? phone;
  int? messageRoomId;
  bool? isShortlisted;
  MessageRoom? messageRoom;

  InterestedInstructors(
      {this.id,
      this.name,
      this.totalReviews,
      this.email,
      this.phone,
      this.messageRoomId,
      this.isShortlisted,
      this.messageRoom});

  InterestedInstructors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalReviews = json['total_reviews'];
    email = json['email'];
    phone = json['phone'];
    messageRoomId = json['message_room_id'];
    isShortlisted = json['isShortlisted'];
    messageRoom = json['messageRoom'] != null
        ? new MessageRoom.fromJson(json['messageRoom'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['total_reviews'] = this.totalReviews;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['message_room_id'] = this.messageRoomId;
    data['isShortlisted'] = this.isShortlisted;
    if (this.messageRoom != null) {
      data['messageRoom'] = this.messageRoom!.toJson();
    }
    return data;
  }
}

class MessageRoom {
  int? id;
  int? postId;
  int? instructorId;
  String? roomStatus;
  int? isShortlisted;
  int? isHired;
  String? location;
  String? createdAt;

  MessageRoom(
      {this.id,
      this.postId,
      this.instructorId,
      this.roomStatus,
      this.isShortlisted,
      this.isHired,
      this.location,
      this.createdAt});

  MessageRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    instructorId = json['instructor_id'];
    roomStatus = json['room_status'];
    isShortlisted = json['is_shortlisted'];
    isHired = json['is_hired'];
    location = json['location'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['instructor_id'] = this.instructorId;
    data['room_status'] = this.roomStatus;
    data['is_shortlisted'] = this.isShortlisted;
    data['is_hired'] = this.isHired;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    return data;
  }
}
