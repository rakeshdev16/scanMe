// To parse this JSON data, do
//
//     final vehiclesBrandResponseModel = vehiclesBrandResponseModelFromJson(jsonString);

import 'dart:convert';

AddVehicleResponseModel addVehiclesResponseModelFromJson(String str) =>
    AddVehicleResponseModel.fromJson(json.decode(str));

String addVehiclesResponseModelToJson(AddVehicleResponseModel data) =>
    json.encode(data.toJson());

class AddVehicleResponseModel {
  bool? success;
  String? message;
  AddVehicleData? data;

  AddVehicleResponseModel({this.success, this.message, this.data});

  AddVehicleResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? AddVehicleData.fromJson(json['data']) : null;
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

class AddVehicleData {
  String? user;
  String? vehicleBrand;
  String? vehicleModel;
  String? vehicleNumber;
  bool? isDeleted;
  String? sId;
  String? time;
  int? iV;

  AddVehicleData(
      {this.user,
        this.vehicleBrand,
        this.vehicleModel,
        this.vehicleNumber,
        this.isDeleted,
        this.sId,
        this.time,
        this.iV});

  AddVehicleData.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    vehicleBrand = json['vehicleBrand'];
    vehicleModel = json['vehicleModel'];
    vehicleNumber = json['vehicleNumber'];
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    time = json['time'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['vehicleBrand'] = vehicleBrand;
    data['vehicleModel'] = vehicleModel;
    data['vehicleNumber'] = vehicleNumber;
    data['isDeleted'] = isDeleted;
    data['_id'] = sId;
    data['time'] = time;
    data['__v'] = iV;
    return data;
  }
}
