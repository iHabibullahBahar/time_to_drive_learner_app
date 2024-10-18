class ReviewModel {
  bool? success;
  String? message;
  Data? data;

  ReviewModel({this.success, this.message, this.data});

  ReviewModel.fromJson(Map<String, dynamic> json) {
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
  List<Reviews>? reviews;

  Data({this.reviews});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  int? id;
  int? userId;
  int? instructorId;
  int? postId;
  String? review;
  int? rating;
  String? createdAt;
  String? updatedAt;
  Post? post;
  User? user;

  Reviews(
      {this.id,
      this.userId,
      this.instructorId,
      this.postId,
      this.review,
      this.rating,
      this.createdAt,
      this.updatedAt,
      this.post,
      this.user});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    instructorId = json['instructor_id'];
    postId = json['post_id'];
    review = json['review'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['instructor_id'] = this.instructorId;
    data['post_id'] = this.postId;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Post {
  String? title;

  Post({this.title});

  Post.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}

class User {
  String? name;

  User({this.name});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
