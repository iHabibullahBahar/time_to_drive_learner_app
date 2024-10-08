class PostSettingsModel {
  bool? success;
  String? message;
  Data? data;

  PostSettingsModel({this.success, this.message, this.data});

  PostSettingsModel.fromJson(Map<String, dynamic> json) {
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
  PostSettings? postSettings;

  Data({this.postSettings});

  Data.fromJson(Map<String, dynamic> json) {
    postSettings = json['post_settings'] != null
        ? new PostSettings.fromJson(json['post_settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.postSettings != null) {
      data['post_settings'] = this.postSettings!.toJson();
    }
    return data;
  }
}

class PostSettings {
  List<String>? titleOptions;
  List<ExperienceOptions>? experienceOptions;
  List<BudgetOptions>? budgetOptions;

  PostSettings({this.titleOptions, this.experienceOptions, this.budgetOptions});

  PostSettings.fromJson(Map<String, dynamic> json) {
    titleOptions = json['title_options'].cast<String>();
    if (json['experience_options'] != null) {
      experienceOptions = <ExperienceOptions>[];
      json['experience_options'].forEach((v) {
        experienceOptions!.add(new ExperienceOptions.fromJson(v));
      });
    }
    if (json['budget_options'] != null) {
      budgetOptions = <BudgetOptions>[];
      json['budget_options'].forEach((v) {
        budgetOptions!.add(new BudgetOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title_options'] = this.titleOptions;
    if (this.experienceOptions != null) {
      data['experience_options'] =
          this.experienceOptions!.map((v) => v.toJson()).toList();
    }
    if (this.budgetOptions != null) {
      data['budget_options'] =
          this.budgetOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExperienceOptions {
  String? label;
  String? value;

  ExperienceOptions({this.label, this.value});

  ExperienceOptions.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}

class BudgetOptions {
  String? label;
  String? value;

  BudgetOptions({this.label, this.value});

  BudgetOptions.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}
