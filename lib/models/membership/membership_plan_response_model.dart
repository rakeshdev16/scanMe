// To parse this JSON data, do
//
//     final membershipPlansResponseModel = membershipPlansResponseModelFromJson(jsonString);

import 'dart:convert';

MembershipPlansResponseModel membershipPlansResponseModelFromJson(String str) => MembershipPlansResponseModel.fromJson(json.decode(str));

String membershipPlansResponseModelToJson(MembershipPlansResponseModel data) => json.encode(data.toJson());

class MembershipPlansResponseModel {
  bool? success;
  String? message;
  List<MembershipPlansData>? data;

  MembershipPlansResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory MembershipPlansResponseModel.fromJson(Map<String, dynamic> json) => MembershipPlansResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<MembershipPlansData>.from(json["data"]!.map((x) => MembershipPlansData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MembershipPlansData {
  String? id;
  String? name;
  int? amount;
  String? description;
  String? currency;
  int? interval;
  String? period;
  List<String>? features;
  String? razorpayPlanId;
  bool? isDeleted;
  DateTime? sortOrder;
  DateTime? time;
  int? v;
  UserSubscription? userSubscription;
  bool? isSelected;

  MembershipPlansData({
    this.id,
    this.name,
    this.amount,
    this.description,
    this.currency,
    this.interval,
    this.period,
    this.features,
    this.razorpayPlanId,
    this.isDeleted,
    this.sortOrder,
    this.time,
    this.v,
    this.userSubscription,
    this.isSelected = false,
  });

  factory MembershipPlansData.fromJson(Map<String, dynamic> json) => MembershipPlansData(
    id: json["_id"],
    name: json["name"],
    amount: json["amount"],
    description: json["description"],
    currency: json["currency"],
    interval: json["interval"],
    period: json["period"],
    features: json["features"] == null ? [] : List<String>.from(json["features"]!.map((x) => x)),
    razorpayPlanId: json["razorpayPlanId"],
    isDeleted: json["isDeleted"],
    sortOrder: json["sortOrder"] == null ? null : DateTime.parse(json["sortOrder"]),
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
    userSubscription: json["userSubscription"] == null ? null : UserSubscription.fromJson(json["userSubscription"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "amount": amount,
    "description": description,
    "currency": currency,
    "interval": interval,
    "period": period,
    "features": features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
    "razorpayPlanId": razorpayPlanId,
    "isDeleted": isDeleted,
    "sortOrder": sortOrder?.toIso8601String(),
    "time": time?.toIso8601String(),
    "__v": v,
    "userSubscription": userSubscription?.toJson(),
  };
}

class UserSubscription {
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
  String? amountPaid;
  DateTime? amountPaidAt;
  String? currency;
  String? invoiceId;
  String? paymentMethod;
  CardData? card;
  String? vpa;

  UserSubscription({
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
    this.amountPaid,
    this.amountPaidAt,
    this.currency,
    this.invoiceId,
    this.paymentMethod,
    this.card,
    this.vpa,
  });

  factory UserSubscription.fromJson(Map<String, dynamic> json) => UserSubscription(
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
    amountPaid: json["amountPaid"],
    amountPaidAt: json["amountPaidAt"] == null ? null : DateTime.parse(json["amountPaidAt"]),
    currency: json["currency"],
    invoiceId: json["invoiceId"],
    paymentMethod: json["paymentMethod"],
    card: json["card"] == null ? null : CardData.fromJson(json["card"]),
    vpa: json["vpa"],
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
    "amountPaid": amountPaid,
    "amountPaidAt": amountPaidAt?.toIso8601String(),
    "currency": currency,
    "invoiceId": invoiceId,
    "paymentMethod": paymentMethod,
    "card": card?.toJson(),
    "vpa": vpa,
  };
}

class CardData {
  String? id;
  String? entity;
  String? name;
  String? last4;
  String? network;
  String? type;
  String? issuer;
  bool? international;
  bool? emi;
  int? expiryMonth;
  int? expiryYear;

  CardData({
    this.id,
    this.entity,
    this.name,
    this.last4,
    this.network,
    this.type,
    this.issuer,
    this.international,
    this.emi,
    this.expiryMonth,
    this.expiryYear,
  });

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
    id: json["id"],
    entity: json["entity"],
    name: json["name"],
    last4: json["last4"],
    network: json["network"],
    type: json["type"],
    issuer: json["issuer"],
    international: json["international"],
    emi: json["emi"],
    expiryMonth: json["expiry_month"],
    expiryYear: json["expiry_year"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entity": entity,
    "name": name,
    "last4": last4,
    "network": network,
    "type": type,
    "issuer": issuer,
    "international": international,
    "emi": emi,
    "expiry_month": expiryMonth,
    "expiry_year": expiryYear,
  };
}
