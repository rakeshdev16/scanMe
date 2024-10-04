// To parse this JSON data, do
//
//     final uploadFileResModel = uploadFileResModelFromJson(jsonString);

import 'dart:convert';

UploadFileResponseModel uploadFileResModelFromJson(String str) =>
    UploadFileResponseModel.fromJson(json.decode(str));

String uploadFileResModelToJson(UploadFileResponseModel data) =>
    json.encode(data.toJson());

class UploadFileResponseModel {
  bool? success;
  String? message;
  UploadFileData? data;

  UploadFileResponseModel({this.success, this.message, this.data});

  UploadFileResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UploadFileData.fromJson(json['data']) : null;
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

class UploadFileData {
  String? path;

  UploadFileData({this.path});

  UploadFileData.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    return data;
  }
}
