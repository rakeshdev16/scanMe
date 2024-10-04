// To parse this JSON data, do
//
//     final subscriptionLinkResponseModel = subscriptionLinkResponseModelFromJson(jsonString);

import 'package:scan_me_plus/export.dart';

SubscriptionPaymentLinkResponseModel subscriptionLinkResponseModelFromJson(
    String str) =>
    SubscriptionPaymentLinkResponseModel.fromJson(json.decode(str));

String subscriptionLinkResponseModelToJson(SubscriptionPaymentLinkResponseModel data) =>
    json.encode(data.toJson());

class SubscriptionPaymentLinkResponseModel {
  bool? success;
  String? message;
  SubscriptionPaymentLinkData? data;

  SubscriptionPaymentLinkResponseModel({this.success, this.message, this.data});

  SubscriptionPaymentLinkResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? SubscriptionPaymentLinkData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SubscriptionPaymentLinkData {
  String? id;
  String? entity;
  String? planId;
  String? status;
  String? currentStart;
  String? currentEnd;
  String? endedAt;
  int? quantity;
  Notes? notes;
  String? chargeAt;
  String? startAt;
  String? endAt;
  int? authAttempts;
  int? totalCount;
  int? paidCount;
  bool? customerNotify;
  int? createdAt;
  String? expireBy;
  String? shortUrl;
  bool? hasScheduledChanges;
  String? changeScheduledAt;
  String? source;
  int? remainingCount;

  SubscriptionPaymentLinkData(
      {this.id,
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
        this.remainingCount});

  SubscriptionPaymentLinkData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entity = json['entity'];
    planId = json['plan_id'];
    status = json['status'];
    currentStart = json['current_start'];
    currentEnd = json['current_end'];
    endedAt = json['ended_at'];
    quantity = json['quantity'];
    notes = json['notes'] != null ? Notes.fromJson(json['notes']) : null;
    chargeAt = json['charge_at'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    authAttempts = json['auth_attempts'];
    totalCount = json['total_count'];
    paidCount = json['paid_count'];
    customerNotify = json['customer_notify'];
    createdAt = json['created_at'];
    expireBy = json['expire_by'];
    shortUrl = json['short_url'];
    hasScheduledChanges = json['has_scheduled_changes'];
    changeScheduledAt = json['change_scheduled_at'];
    source = json['source'];
    remainingCount = json['remaining_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['entity'] = entity;
    data['plan_id'] = planId;
    data['status'] = status;
    data['current_start'] = currentStart;
    data['current_end'] = currentEnd;
    data['ended_at'] = endedAt;
    data['quantity'] = quantity;
    if (notes != null) {
      data['notes'] = notes!.toJson();
    }
    data['charge_at'] = chargeAt;
    data['start_at'] = startAt;
    data['end_at'] = endAt;
    data['auth_attempts'] = authAttempts;
    data['total_count'] = totalCount;
    data['paid_count'] = paidCount;
    data['customer_notify'] = customerNotify;
    data['created_at'] = createdAt;
    data['expire_by'] = expireBy;
    data['short_url'] = shortUrl;
    data['has_scheduled_changes'] = hasScheduledChanges;
    data['change_scheduled_at'] = changeScheduledAt;
    data['source'] = source;
    data['remaining_count'] = remainingCount;
    return data;
  }
}
