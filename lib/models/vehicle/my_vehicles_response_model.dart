// To parse this JSON data, do
//
//     final myVehiclesResponseModel = myVehiclesResponseModelFromJson(jsonString);

import 'dart:convert';

MyVehiclesResponseModel myVehiclesResponseModelFromJson(String str) => MyVehiclesResponseModel.fromJson(json.decode(str));

String myVehiclesResponseModelToJson(MyVehiclesResponseModel data) => json.encode(data.toJson());

class MyVehiclesResponseModel {
  bool? success;
  String? message;
  List<MyVehiclesDataModel>? data;

  MyVehiclesResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory MyVehiclesResponseModel.fromJson(Map<String, dynamic> json) => MyVehiclesResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<MyVehiclesDataModel>.from(json["data"]!.map((x) => MyVehiclesDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MyVehiclesDataModel {
  String? id;
  VehicleData? vehicleBrand;
  VehicleData? vehicleModel;
  String? vehicleNumber;
  bool? isDeleted;
  Subscription? subscription;
  bool? isSubscribed;
  bool? isExpired;
  String? isShipment;
  String? qr;
  String? srNo;

  MyVehiclesDataModel({
    this.id,
    this.vehicleBrand,
    this.vehicleModel,
    this.vehicleNumber,
    this.isDeleted,
    this.subscription,
    this.isSubscribed,
    this.isExpired,
    this.isShipment,
    this.qr,
    this.srNo,
  });

  factory MyVehiclesDataModel.fromJson(Map<String, dynamic> json) => MyVehiclesDataModel(
    id: json["_id"],
    vehicleBrand: json["vehicleBrand"] == null ? null : VehicleData.fromJson(json["vehicleBrand"]),
    vehicleModel: json["vehicleModel"] == null ? null : VehicleData.fromJson(json["vehicleModel"]),
    vehicleNumber: json["vehicleNumber"],
    isDeleted: json["isDeleted"],
    subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
    isSubscribed: json["isSubscribed"],
    isExpired: json["isExpired"],
    isShipment: json["isShipment"],
    qr: json["qr"],
    srNo: json["srNo"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "vehicleBrand": vehicleBrand?.toJson(),
    "vehicleModel": vehicleModel?.toJson(),
    "vehicleNumber": vehicleNumber,
    "isDeleted": isDeleted,
    "subscription": subscription?.toJson(),
    "isSubscribed": isSubscribed,
    "isExpired": isExpired,
    "isShipment": isShipment,
    "qr": qr,
    "srNo": srNo,
  };
}

class Subscription {
  String? id;
  String? user;
  String? vehicle;
  String? subscriptionId;
  String? planId;
  String? status;
  DateTime? currentStart;
  DateTime? currentEnd;
  DateTime? chargeAt;
  DateTime? startAt;
  DateTime? endAt;
  DateTime? endedAt;
  DateTime? time;
  int? v;
  Plan? plan;

  Subscription({
    this.id,
    this.user,
    this.vehicle,
    this.subscriptionId,
    this.planId,
    this.status,
    this.currentStart,
    this.currentEnd,
    this.chargeAt,
    this.startAt,
    this.endAt,
    this.endedAt,
    this.time,
    this.v,
    this.plan,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: json["_id"],
    user: json["user"],
    vehicle: json["vehicle"],
    subscriptionId: json["subscriptionId"],
    planId: json["planId"],
    status: json["status"],
    currentStart: json["currentStart"] == null ? null : DateTime.parse(json["currentStart"]),
    currentEnd: json["currentEnd"] == null ? null : DateTime.parse(json["currentEnd"]),
    chargeAt: json["chargeAt"] == null ? null : DateTime.parse(json["chargeAt"]),
    startAt: json["startAt"] == null ? null : DateTime.parse(json["startAt"]),
    endAt: json["endAt"] == null ? null : DateTime.parse(json["endAt"]),
    endedAt: json["endedAt"] == null ? null : DateTime.parse(json["endedAt"]),
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
    plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "vehicle": vehicle,
    "subscriptionId": subscriptionId,
    "planId": planId,
    "status": status,
    "currentStart": currentStart?.toIso8601String(),
    "currentEnd": currentEnd?.toIso8601String(),
    "chargeAt": chargeAt?.toIso8601String(),
    "startAt": startAt?.toIso8601String(),
    "endAt": endAt?.toIso8601String(),
    "endedAt": endedAt?.toIso8601String(),
    "time": time?.toIso8601String(),
    "__v": v,
    "plan": plan?.toJson(),
  };
}

class Plan {
  String? id;
  String? name;
  int? amount;
  String? currency;
  String? period;

  Plan({
    this.id,
    this.name,
    this.amount,
    this.currency,
    this.period,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["_id"],
    name: json["name"],
    amount: json["amount"],
    currency: json["currency"],
    period: json["period"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "amount": amount,
    "currency": currency,
    "period": period,
  };
}

class VehicleData {
  String? sId;
  String? name;
  String? image;
  String? vehicleType;

  VehicleData({this.sId, this.name, this.image, this.vehicleType,});

  VehicleData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    vehicleType = json['vehicleType'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['vehicleType'] = vehicleType;
    return data;
  }
}
