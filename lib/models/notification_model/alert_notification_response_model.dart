// To parse this JSON data, do
//
//     final alertNotificationsResponseModel = alertNotificationsResponseModelFromJson(jsonString);


import 'package:scan_me_plus/export.dart';

AlertNotificationsResponseModel alertNotificationsResponseModelFromJson(String str) => AlertNotificationsResponseModel.fromJson(json.decode(str));

String alertNotificationsResponseModelToJson(AlertNotificationsResponseModel data) => json.encode(data.toJson());

class AlertNotificationsResponseModel {
  bool? success;
  String? message;
  List<AlertNotificationsData>? data;

  AlertNotificationsResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory AlertNotificationsResponseModel.fromJson(Map<String, dynamic> json) => AlertNotificationsResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<AlertNotificationsData>.from(json["data"]!.map((x) => AlertNotificationsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AlertNotificationsData {
  String? id;
  String? otherUserMobile;
  User? user;
  User? alertUser;
  EmergencyAlertData? emergencyAlert;
  Vehicle? vehicle;
  DateTime? time;
  int? v;

  AlertNotificationsData({
    this.id,
    this.otherUserMobile,
    this.user,
    this.alertUser,
    this.emergencyAlert,
    this.vehicle,
    this.time,
    this.v,
  });

  factory AlertNotificationsData.fromJson(Map<String, dynamic> json) => AlertNotificationsData(
    id: json["_id"],
    otherUserMobile: json["otherUserMobile"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    alertUser: json["alertUser"] == null ? null : User.fromJson(json["alertUser"]),
    emergencyAlert: json["emergencyAlert"] == null ? null : EmergencyAlertData.fromJson(json["emergencyAlert"]),
    vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "otherUserMobile": otherUserMobile,
    "user": user?.toJson(),
    "alertUser": alertUser?.toJson(),
    "emergencyAlert": emergencyAlert?.toJson(),
    "vehicle": vehicle?.toJson(),
    "time": time?.toIso8601String(),
    "__v": v,
  };
}


