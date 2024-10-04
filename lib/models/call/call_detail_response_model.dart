// To parse this JSON data, do
//
//     final callDetailResponseModel = callDetailResponseModelFromJson(jsonString);

import 'package:scan_me_plus/export.dart';

CallDetailResponseModel callDetailResponseModelFromJson(String str) => CallDetailResponseModel.fromJson(json.decode(str));

String callDetailResponseModelToJson(CallDetailResponseModel data) => json.encode(data.toJson());

class CallDetailResponseModel {
  bool? success;
  String? message;
  CallDetailModel? data;

  CallDetailResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory CallDetailResponseModel.fromJson(Map<String, dynamic> json) => CallDetailResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : CallDetailModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class CallDetailModel {
  String? id;
  Caller? caller;
  Caller? reciever;
  Vehicle? vehicle;
  String? status;
  List<dynamic>? deletedBy;
  bool? isDeleted;
  DateTime? time;
  int? v;
  bool? isBlockedUser;

  CallDetailModel({
    this.id,
    this.caller,
    this.reciever,
    this.vehicle,
    this.status,
    this.deletedBy,
    this.isDeleted,
    this.time,
    this.v,
    this.isBlockedUser,
  });

  factory CallDetailModel.fromJson(Map<String, dynamic> json) => CallDetailModel(
    id: json["_id"],
    caller: json["caller"] == null ? null : Caller.fromJson(json["caller"]),
    reciever: json["reciever"] == null ? null : Caller.fromJson(json["reciever"]),
    vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
    status: json["status"],
    deletedBy: json["deletedBy"] == null ? [] : List<dynamic>.from(json["deletedBy"]!.map((x) => x)),
    isDeleted: json["isDeleted"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
    isBlockedUser: json["isBlockedUser"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "caller": caller?.toJson(),
    "reciever": reciever?.toJson(),
    "vehicle": vehicle?.toJson(),
    "status": status,
    "deletedBy": deletedBy == null ? [] : List<dynamic>.from(deletedBy!.map((x) => x)),
    "isDeleted": isDeleted,
    "time": time?.toIso8601String(),
    "__v": v,
    "isBlockedUser": isBlockedUser,
  };
}

class Caller {
  String? id;
  String? image;
  String? userId;

  Caller({
    this.id,
    this.image,
    this.userId,
  });

  factory Caller.fromJson(Map<String, dynamic> json) => Caller(
    id: json["_id"],
    image: json["image"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "userId": userId,
  };
}

class Vehicle {
  String? id;
  VehicleData? vehicleBrand;
  VehicleData? vehicleModel;
  String? vehicleNumber;

  Vehicle({
    this.id,
    this.vehicleBrand,
    this.vehicleModel,
    this.vehicleNumber,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json["_id"],
    vehicleBrand: json["vehicleBrand"] == null ? null : VehicleData.fromJson(json["vehicleBrand"]),
    vehicleModel: json["vehicleModel"] == null ? null : VehicleData.fromJson(json["vehicleModel"]),
    vehicleNumber: json["vehicleNumber"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "vehicleBrand": vehicleBrand?.toJson(),
    "vehicleModel": vehicleModel?.toJson(),
    "vehicleNumber": vehicleNumber,
  };
}
