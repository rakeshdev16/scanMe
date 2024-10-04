// To parse this JSON data, do
//
//     final searchedVehiclesResponseModel = vehiclesBrandResponseModelFromJson(jsonString);

import 'package:scan_me_plus/export.dart';

SearchedVehicleResponseModel searchedVehiclesResponseModelFromJson(
        String str) =>
    SearchedVehicleResponseModel.fromJson(json.decode(str));

String searchedVehiclesResponseModelToJson(SearchedVehicleResponseModel data) =>
    json.encode(data.toJson());

class SearchedVehicleResponseModel {
  bool? success;
  String? message;
  SearchedVehicleDataModel? data;

  SearchedVehicleResponseModel({this.success, this.message, this.data});

  SearchedVehicleResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? SearchedVehicleDataModel.fromJson(json['data'])
        : null;
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

class SearchedVehicleDataModel {
  String? sId;
  User? user;
  VehicleData? vehicleBrand;
  VehicleData? vehicleModel;
  String? vehicleNumber;

  SearchedVehicleDataModel(
      {this.sId,
      this.user,
      this.vehicleBrand,
      this.vehicleModel,
      this.vehicleNumber});

  SearchedVehicleDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    vehicleBrand = json['vehicleBrand'] != null
        ? VehicleData.fromJson(json['vehicleBrand'])
        : null;
    vehicleModel = json['vehicleModel'] != null
        ? VehicleData.fromJson(json['vehicleModel'])
        : null;
    vehicleNumber = json['vehicleNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (vehicleBrand != null) {
      data['vehicleBrand'] = vehicleBrand!.toJson();
    }
    if (vehicleModel != null) {
      data['vehicleModel'] = vehicleModel!.toJson();
    }
    data['vehicleNumber'] = vehicleNumber;
    return data;
  }
}
