// To parse this JSON data, do
//
//     final newNotificationStatusResponseModel = newNotificationStatusResponseModelFromJson(jsonString);

import 'dart:convert';

NewNotificationStatusResponseModel newNotificationStatusResponseModelFromJson(String str) => NewNotificationStatusResponseModel.fromJson(json.decode(str));

String newNotificationStatusResponseModelToJson(NewNotificationStatusResponseModel data) => json.encode(data.toJson());

class NewNotificationStatusResponseModel {
  bool? success;
  String? message;
  bool? data;

  NewNotificationStatusResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory NewNotificationStatusResponseModel.fromJson(Map<String, dynamic> json) => NewNotificationStatusResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
  };
}
