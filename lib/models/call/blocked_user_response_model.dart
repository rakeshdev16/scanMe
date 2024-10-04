// To parse this JSON data, do
//
//     final blockedUserResponseModel = blockedUserResponseModelFromJson(jsonString);

import 'package:scan_me_plus/export.dart';

BlockedUserResponseModel blockedUserResponseModelFromJson(String str) => BlockedUserResponseModel.fromJson(json.decode(str));

String blockedUserResponseModelToJson(BlockedUserResponseModel data) => json.encode(data.toJson());

class BlockedUserResponseModel {
  bool? success;
  String? message;
  List<BlockedUserData>? data;

  BlockedUserResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory BlockedUserResponseModel.fromJson(Map<String, dynamic> json) => BlockedUserResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<BlockedUserData>.from(json["data"]!.map((x) => BlockedUserData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BlockedUserData {
  String? id;
  User? user;
  User? blockedUser;
  DateTime? time;
  int? v;

  BlockedUserData({
    this.id,
    this.user,
    this.blockedUser,
    this.time,
    this.v,
  });

  factory BlockedUserData.fromJson(Map<String, dynamic> json) => BlockedUserData(
    id: json["_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    blockedUser: json["blockedUser"] == null ? null : User.fromJson(json["blockedUser"]),
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "blockedUser": blockedUser?.toJson(),
    "time": time?.toIso8601String(),
    "__v": v,
  };
}

