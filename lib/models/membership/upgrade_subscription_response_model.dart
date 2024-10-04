// To parse this JSON data, do
//
//     final upgradeSubscriptionResponseModel = upgradeSubscriptionResponseModelFromJson(jsonString);

import 'dart:convert';

UpgradeSubscriptionResponseModel upgradeSubscriptionResponseModelFromJson(String str) => UpgradeSubscriptionResponseModel.fromJson(json.decode(str));

String upgradeSubscriptionResponseModelToJson(UpgradeSubscriptionResponseModel data) => json.encode(data.toJson());

class UpgradeSubscriptionResponseModel {
  bool? success;
  String? message;
  UpgradeSubscriptionData? data;

  UpgradeSubscriptionResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory UpgradeSubscriptionResponseModel.fromJson(Map<String, dynamic> json) => UpgradeSubscriptionResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : UpgradeSubscriptionData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class UpgradeSubscriptionData {
  String? id;
  String? entity;
  String? planId;
  String? status;
  dynamic currentStart;
  dynamic currentEnd;
  dynamic endedAt;
  int? quantity;
  Notes? notes;
  int? chargeAt;
  int? startAt;
  int? endAt;
  int? authAttempts;
  int? totalCount;
  int? paidCount;
  bool? customerNotify;
  int? createdAt;
  dynamic expireBy;
  String? shortUrl;
  bool? hasScheduledChanges;
  dynamic changeScheduledAt;
  String? source;
  int? remainingCount;

  UpgradeSubscriptionData({
    this.id,
    this.entity,
    this.planId,
    this.status,
    this.currentStart,
    this.currentEnd,
    this.endedAt,
    this.quantity,
    this.notes,
    this.chargeAt,
    this.startAt,
    this.endAt,
    this.authAttempts,
    this.totalCount,
    this.paidCount,
    this.customerNotify,
    this.createdAt,
    this.expireBy,
    this.shortUrl,
    this.hasScheduledChanges,
    this.changeScheduledAt,
    this.source,
    this.remainingCount,
  });

  factory UpgradeSubscriptionData.fromJson(Map<String, dynamic> json) => UpgradeSubscriptionData(
    id: json["id"],
    entity: json["entity"],
    planId: json["plan_id"],
    status: json["status"],
    currentStart: json["current_start"],
    currentEnd: json["current_end"],
    endedAt: json["ended_at"],
    quantity: json["quantity"],
    notes: json["notes"] == null ? null : Notes.fromJson(json["notes"]),
    chargeAt: json["charge_at"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    authAttempts: json["auth_attempts"],
    totalCount: json["total_count"],
    paidCount: json["paid_count"],
    customerNotify: json["customer_notify"],
    createdAt: json["created_at"],
    expireBy: json["expire_by"],
    shortUrl: json["short_url"],
    hasScheduledChanges: json["has_scheduled_changes"],
    changeScheduledAt: json["change_scheduled_at"],
    source: json["source"],
    remainingCount: json["remaining_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entity": entity,
    "plan_id": planId,
    "status": status,
    "current_start": currentStart,
    "current_end": currentEnd,
    "ended_at": endedAt,
    "quantity": quantity,
    "notes": notes?.toJson(),
    "charge_at": chargeAt,
    "start_at": startAt,
    "end_at": endAt,
    "auth_attempts": authAttempts,
    "total_count": totalCount,
    "paid_count": paidCount,
    "customer_notify": customerNotify,
    "created_at": createdAt,
    "expire_by": expireBy,
    "short_url": shortUrl,
    "has_scheduled_changes": hasScheduledChanges,
    "change_scheduled_at": changeScheduledAt,
    "source": source,
    "remaining_count": remainingCount,
  };
}

class Notes {
  String? vehicleId;
  String? userId;
  String? cancelSubscriptionId;

  Notes({
    this.vehicleId,
    this.userId,
    this.cancelSubscriptionId,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    vehicleId: json["vehicleId"],
    userId: json["userId"],
    cancelSubscriptionId: json["cancelSubscriptionId"],
  );

  Map<String, dynamic> toJson() => {
    "vehicleId": vehicleId,
    "userId": userId,
    "cancelSubscriptionId": cancelSubscriptionId,
  };
}
