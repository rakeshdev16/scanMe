// To parse this JSON data, do
//
//     final checkMailExistsResModel = checkMailExistsResModelFromJson(jsonString);

import 'dart:convert';

CheckMailExistsResModel checkMailExistsResModelFromJson(String str) =>
    CheckMailExistsResModel.fromJson(json.decode(str));

String checkMailExistsResModelToJson(CheckMailExistsResModel data) =>
    json.encode(data.toJson());

class CheckMailExistsResModel {
  final bool success;
  final String message;
  final CheckMailExistsData? data;

  CheckMailExistsResModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory CheckMailExistsResModel.fromJson(Map<String, dynamic> json) =>
      CheckMailExistsResModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : CheckMailExistsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class CheckMailExistsData {
  CheckMailExistsData();

  factory CheckMailExistsData.fromJson(Map<String, dynamic> json) =>
      CheckMailExistsData();

  Map<String, dynamic> toJson() => {};
}
