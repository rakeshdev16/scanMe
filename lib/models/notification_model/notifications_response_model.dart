// To parse this JSON data, do
//
//     final notificationsResponseModel = notificationsResponseModelFromJson(jsonString);

import 'package:scan_me_plus/export.dart';

NotificationsResponseModel notificationsResponseModelFromJson(String str) => NotificationsResponseModel.fromJson(json.decode(str));

String notificationsResponseModelToJson(NotificationsResponseModel data) => json.encode(data.toJson());

class NotificationsResponseModel {
  bool? success;
  String? message;
  List<NotificationsData>? data;

  NotificationsResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) => NotificationsResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<NotificationsData>.from(json["data"]!.map((x) => NotificationsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationsData {
  String? id;
  User? user;
  String? text;
  String? type;
  DateTime? time;
  int? v;

  NotificationsData({
    this.id,
    this.user,
    this.text,
    this.type,
    this.time,
    this.v,
  });

  factory NotificationsData.fromJson(Map<String, dynamic> json) => NotificationsData(
    id: json["_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    text: json["text"],
    type: json["type"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "text": text,
    "type": type,
    "time": time?.toIso8601String(),
    "__v": v,
  };
}