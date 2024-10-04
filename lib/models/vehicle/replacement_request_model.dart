// To parse this JSON data, do
//
//     final replacementRequestResponseModel = replacementRequestResponseModelFromJson(jsonString);

import 'dart:convert';

ReplacementRequestResponseModel replacementRequestResponseModelFromJson(String str) => ReplacementRequestResponseModel.fromJson(json.decode(str));

String replacementRequestResponseModelToJson(ReplacementRequestResponseModel data) => json.encode(data.toJson());

class ReplacementRequestResponseModel {
  bool? success;
  String? message;
  ReplacementRequestData? data;

  ReplacementRequestResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory ReplacementRequestResponseModel.fromJson(Map<String, dynamic> json) => ReplacementRequestResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : ReplacementRequestData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class ReplacementRequestData {
  String? user;
  String? reason;
  String? comments;
  String? shippingAddress;
  String? id;
  DateTime? time;
  int? v;

  ReplacementRequestData({
    this.user,
    this.reason,
    this.comments,
    this.shippingAddress,
    this.id,
    this.time,
    this.v,
  });

  factory ReplacementRequestData.fromJson(Map<String, dynamic> json) => ReplacementRequestData(
    user: json["user"],
    reason: json["reason"],
    comments: json["comments"],
    shippingAddress: json["shippingAddress"],
    id: json["_id"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "reason": reason,
    "comments": comments,
    "shippingAddress": shippingAddress,
    "_id": id,
    "time": time?.toIso8601String(),
    "__v": v,
  };
}
