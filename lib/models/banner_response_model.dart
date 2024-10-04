// To parse this JSON data, do
//
//     final bannerResponseModel = bannerResponseModelFromJson(jsonString);

import 'dart:convert';

BannerResponseModel bannerResponseModelFromJson(String str) => BannerResponseModel.fromJson(json.decode(str));

String bannerResponseModelToJson(BannerResponseModel data) => json.encode(data.toJson());

class BannerResponseModel {
  bool? success;
  String? message;
  List<BannerData>? data;

  BannerResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) => BannerResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<BannerData>.from(json["data"]!.map((x) => BannerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BannerData {
  String? id;
  String? image;
  String? type;
  DateTime? time;
  int? v;

  BannerData({
    this.id,
    this.image,
    this.type,
    this.time,
    this.v,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    id: json["_id"],
    image: json["image"],
    type: json["type"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "type": type,
    "time": time?.toIso8601String(),
    "__v": v,
  };
}
