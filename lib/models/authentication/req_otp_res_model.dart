// To parse this JSON data, do
//
//     final requestOtpResModel = requestOtpResModelFromJson(jsonString);

import 'dart:convert';

RequestOtpResModel requestOtpResModelFromJson(String str) =>
    RequestOtpResModel.fromJson(json.decode(str));

String requestOtpResModelToJson(RequestOtpResModel data) =>
    json.encode(data.toJson());

class RequestOtpResModel {
  final bool success;
  final String message;
  final RequestOtpData? data;

  RequestOtpResModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory RequestOtpResModel.fromJson(Map<String, dynamic> json) =>
      RequestOtpResModel(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null ? null : RequestOtpData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class RequestOtpData {
  String? otpCode;
  String? countryCode;
  String? mobile;
  bool? isRegistered;

  RequestOtpData(
      {this.otpCode, this.countryCode, this.mobile, this.isRegistered});

  RequestOtpData.fromJson(Map<String, dynamic> json) {
    otpCode = json['otpCode'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    isRegistered = json['isRegistered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otpCode'] = otpCode;
    data['countryCode'] = countryCode;
    data['mobile'] = mobile;
    data['isRegistered'] = isRegistered;
    return data;
  }
}
