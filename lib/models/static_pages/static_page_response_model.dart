// To parse this JSON data, do
//
//     final staticPagesResponseModel = staticPagesResponseModelFromJson(jsonString);

import 'dart:convert';

StaticPagesResponseModel staticPagesResponseModelFromJson(String str) => StaticPagesResponseModel.fromJson(json.decode(str));

String staticPagesResponseModelToJson(StaticPagesResponseModel data) => json.encode(data.toJson());

class StaticPagesResponseModel {
  bool? success;
  String? message;
  StaticPagesData? data;

  StaticPagesResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory StaticPagesResponseModel.fromJson(Map<String, dynamic> json) => StaticPagesResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : StaticPagesData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class StaticPagesData {
  String? id;
  String? title;
  String? content;
  DateTime? time;
  int? v;

  StaticPagesData({
    this.id,
    this.title,
    this.content,
    this.time,
    this.v,
  });

  factory StaticPagesData.fromJson(Map<String, dynamic> json) => StaticPagesData(
    id: json["_id"],
    title: json["title"],
    content: json["content"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "content": content,
    "time": time?.toIso8601String(),
    "__v": v,
  };
}
