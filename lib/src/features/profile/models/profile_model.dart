class ProfileModel {
  bool? success;
  String? message;
  Data? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? drivingExperience;
  Null? hourlyBudgetRange;
  String? address;
  String? selectedPostalCode;
  String? phone;
  String? image;
  String? activityStatus;
  String? lastLogin;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.drivingExperience,
      this.hourlyBudgetRange,
      this.address,
      this.selectedPostalCode,
      this.phone,
      this.image,
      this.activityStatus,
      this.lastLogin,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    drivingExperience = json['driving_experience'];
    hourlyBudgetRange = json['hourly_budget_range'];
    address = json['address'];
    selectedPostalCode = json['selected_postal_code'];
    phone = json['phone'];
    image = json['image'];
    activityStatus = json['activity_status'];
    lastLogin = json['last_login'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['driving_experience'] = this.drivingExperience;
    data['hourly_budget_range'] = this.hourlyBudgetRange;
    data['address'] = this.address;
    data['selected_postal_code'] = this.selectedPostalCode;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['activity_status'] = this.activityStatus;
    data['last_login'] = this.lastLogin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
