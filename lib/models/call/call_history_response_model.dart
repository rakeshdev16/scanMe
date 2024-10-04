// To parse this JSON data, do
//
//     final callHistoryResponseModel = callHistoryResponseModelFromJson(jsonString);

import 'package:scan_me_plus/export.dart';

CallHistoryResponseModel callHistoryResponseModelFromJson(String str) =>
    CallHistoryResponseModel.fromJson(json.decode(str));

String callHistoryResponseModelToJson(CallHistoryResponseModel data) =>
    json.encode(data.toJson());

class CallHistoryResponseModel {
  bool? success;
  String? message;
  List<CallHistoryData>? data;

  CallHistoryResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory CallHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      CallHistoryResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CallHistoryData>.from(
                json["data"]!.map((x) => CallHistoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CallHistoryData {
  String? id;
  Reciever? caller;
  Reciever? reciever;
  String? status;
  bool? isDeleted;
  DateTime? time;
  DateTime? startAt;
  int? v;
  DateTime? endedAt;

  CallHistoryData({
    this.id,
    this.caller,
    this.reciever,
    this.status,
    this.isDeleted,
    this.time,
    this.startAt,
    this.v,
    this.endedAt,
  });

  factory CallHistoryData.fromJson(Map<String, dynamic> json) =>
      CallHistoryData(
        id: json["_id"],
        caller:
            json["caller"] == null ? null : Reciever.fromJson(json["caller"]),
        reciever: json["reciever"] == null
            ? null
            : Reciever.fromJson(json["reciever"]),
        status: json["status"],
        isDeleted: json["isDeleted"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        v: json["__v"],
        endedAt:
            json["EndedAt"] == null ? null : DateTime.parse(json["EndedAt"]),
        startAt:
            json["startAt"] == null ? null : DateTime.parse(json["startAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "caller": caller?.toJson(),
        "reciever": reciever?.toJson(),
        "status": status,
        "isDeleted": isDeleted,
        "time": time?.toIso8601String(),
        "__v": v,
        "EndedAt": endedAt?.toIso8601String(),
        "startAt": startAt?.toIso8601String(),
      };
}
