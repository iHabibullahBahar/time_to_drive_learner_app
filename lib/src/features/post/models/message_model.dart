class MessageModel {
  bool? success;
  String? message;
  Data? data;

  MessageModel({this.success, this.message, this.data});

  MessageModel.fromJson(Map<String, dynamic> json) {
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
  List<Messages>? messages;

  Data({this.messages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  int? id;
  int? messageRoomId;
  String? text;
  String? image;
  int? isImage;
  int? isRead;
  String? senderType;
  int? senderId;
  int? forWhom;
  String? createdAt;
  String? updatedAt;

  Messages(
      {this.id,
      this.messageRoomId,
      this.text,
      this.image,
      this.isImage,
      this.isRead,
      this.senderType,
      this.senderId,
      this.forWhom,
      this.createdAt,
      this.updatedAt});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageRoomId = json['message_room_id'];
    text = json['text'];
    image = json['image'];
    isImage = json['is_image'];
    isRead = json['is_read'];
    senderType = json['sender_type'];
    senderId = json['sender_id'];
    forWhom = json['for_whom'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message_room_id'] = this.messageRoomId;
    data['text'] = this.text;
    data['image'] = this.image;
    data['is_image'] = this.isImage;
    data['is_read'] = this.isRead;
    data['sender_type'] = this.senderType;
    data['sender_id'] = this.senderId;
    data['for_whom'] = this.forWhom;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
