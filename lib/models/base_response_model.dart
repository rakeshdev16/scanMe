// To parse this JSON data, do
//
//     final baseResponseModel = baseResponseModelFromJson(jsonString);

import 'dart:convert';

BaseResponseModel baseResponseModelFromJson(String str) =>
    BaseResponseModel.fromJson(json.decode(str));

String baseResponseModelToJson(BaseResponseModel data) =>
    json.encode(data.toJson());

class BaseResponseModel {
  final bool success;
  final String message;

  BaseResponseModel({
    required this.success,
    required this.message,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      BaseResponseModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
