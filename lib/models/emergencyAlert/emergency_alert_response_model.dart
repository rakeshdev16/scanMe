// To parse this JSON data, do
//
//     final emergencyAlertResponseModel = emergencyAlertResponseModelFromJson(jsonString);

import 'dart:convert';

EmergencyAlertResponseModel emergencyAlertResponseModelFromJson(String str) => EmergencyAlertResponseModel.fromJson(json.decode(str));

String emergencyAlertResponseModelToJson(EmergencyAlertResponseModel data) => json.encode(data.toJson());

class EmergencyAlertResponseModel {
  bool? success;
  String? message;
  List<EmergencyAlertData>? data;

  EmergencyAlertResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory EmergencyAlertResponseModel.fromJson(Map<String, dynamic> json) => EmergencyAlertResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<EmergencyAlertData>.from(json["data"]!.map((x) => EmergencyAlertData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class EmergencyAlertData {
  String? id;
  String? name;
  DateTime? time;
  int? v;
  bool isSelected;

  EmergencyAlertData({
    this.id,
    this.name,
    this.time,
    this.v,
    this.isSelected = false,
  });

  factory EmergencyAlertData.fromJson(Map<String, dynamic> json) => EmergencyAlertData(
    id: json["_id"],
    name: json["name"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "time": time?.toIso8601String(),
    "__v": v,
  };
}
