// To parse this JSON data, do
//
//     final startCallResponseModel = startCallResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:scan_me_plus/export.dart';

StartCallResponseModel startCallResponseModelFromJson(String str) =>
    StartCallResponseModel.fromJson(json.decode(str));

String startCallResponseModelToJson(StartCallResponseModel data) =>
    json.encode(data.toJson());

class StartCallResponseModel {
  bool? success;
  String? message;
  StartCallData? data;

  StartCallResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory StartCallResponseModel.fromJson(Map<String, dynamic> json) =>
      StartCallResponseModel(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null ? null : StartCallData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class StartCallData {
  Reciever? reciever;
  Reciever? caller;
  String? channelName;
  String? token;
  bool? callBlocked;

  StartCallData({
    this.reciever,
    this.caller,
    this.channelName,
    this.token,
    this.callBlocked,
  });

  factory StartCallData.fromJson(Map<String, dynamic> json) => StartCallData(
        reciever: json["reciever"] == null
            ? null
            : Reciever.fromJson(json["reciever"]),
        caller: json["caller"] == null
            ? null
            : Reciever.fromJson(jsonDecode(json['caller'])),
        channelName: json["channelName"],
        token: json["token"],
    callBlocked: json["callBlocked"],
      );

  Map<String, dynamic> toJson() => {
        "reciever": reciever?.toJson(),
        "caller": caller?.toJson(),
        "channelName": channelName,
        "token": token,
        "callBlocked": callBlocked,
      };
}

class Reciever {
  String? id;
  String? userId;
  dynamic image;
  String? fcmToken;

  Reciever({
    this.id,
    this.userId,
    this.image,
    this.fcmToken,
  });

  factory Reciever.fromJson(Map<String, dynamic> json) => Reciever(
        id: json["_id"],
        userId: json["userId"],
        image: json["image"],
        fcmToken: json["fcmToken"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "image": image,
        "fcmToken": fcmToken,
      };
}
