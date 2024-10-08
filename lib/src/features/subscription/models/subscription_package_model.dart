class SubscriptionPackageModel {
  bool? success;
  String? message;
  Data? data;

  SubscriptionPackageModel({this.success, this.message, this.data});

  SubscriptionPackageModel.fromJson(Map<String, dynamic> json) {
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
  String? slug;
  int? duration;
  int? freeTrialDuration;
  int? level;
  bool? published;
  double? cost;
  String? unit;
  List<String>? features;
  String? stripeProductId;
  String? stripePriceId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.name,
      this.slug,
      this.duration,
      this.freeTrialDuration,
      this.level,
      this.published,
      this.cost,
      this.unit,
      this.features,
      this.stripeProductId,
      this.stripePriceId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    duration = json['duration'];
    freeTrialDuration = json['free_trial_duration'];
    level = json['level'];
    published = json['published'];
    cost = json['cost']?.toDouble();
    unit = json['unit'];
    features = json['features'].cast<String>();
    stripeProductId = json['stripe_product_id'];
    stripePriceId = json['stripe_price_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['duration'] = this.duration;
    data['free_trial_duration'] = this.freeTrialDuration;
    data['level'] = this.level;
    data['published'] = this.published;
    data['cost'] = this.cost;
    data['unit'] = this.unit;
    data['features'] = this.features;
    data['stripe_product_id'] = this.stripeProductId;
    data['stripe_price_id'] = this.stripePriceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
