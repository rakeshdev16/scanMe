// To parse this JSON data, do
//
//     final vehiclesBrandResponseModel = vehiclesBrandResponseModelFromJson(jsonString);

import 'dart:convert';

VehiclesBrandResponseModel vehiclesBrandResponseModelFromJson(String str) =>
    VehiclesBrandResponseModel.fromJson(json.decode(str));

String vehiclesBrandResponseModelToJson(VehiclesBrandResponseModel data) =>
    json.encode(data.toJson());

class VehiclesBrandResponseModel {
  bool? success;
  String? message;
  List<VehiclesBrandDataModel>? data;

  VehiclesBrandResponseModel({this.success, this.message, this.data});

  VehiclesBrandResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VehiclesBrandDataModel>[];
      json['data'].forEach((v) {
        data!.add(VehiclesBrandDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehiclesBrandDataModel {
  String? sId;
  String? name;
  String? image;
  String? vehicleType;
  List<VehicleModels>? vehicleModels;

  VehiclesBrandDataModel(
      {this.sId, this.name, this.image, this.vehicleType, this.vehicleModels});

  VehiclesBrandDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    vehicleType = json['vehicleType'];
    if (json['vehicleModels'] != null) {
      vehicleModels = <VehicleModels>[];
      json['vehicleModels'].forEach((v) {
        vehicleModels!.add(VehicleModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['vehicleType'] = vehicleType;
    if (vehicleModels != null) {
      data['vehicleModels'] = vehicleModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleModels {
  String? sId;
  String? name;
  String? image;

  VehicleModels({this.sId, this.name, this.image});

  VehicleModels.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
