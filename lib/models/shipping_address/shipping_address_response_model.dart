// To parse this JSON data, do
//
//     final shippingAddressResponseModel = shippingAddressResponseModelFromJson(jsonString);

import 'package:scan_me_plus/export.dart';

ShippingAddressResponseModel shippingAddressResponseModelFromJson(String str) => ShippingAddressResponseModel.fromJson(json.decode(str));

String shippingAddressResponseModelToJson(ShippingAddressResponseModel data) => json.encode(data.toJson());

class ShippingAddressResponseModel {
  bool? success;
  String? message;
  List<ShippingAddressData>? data;

  ShippingAddressResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory ShippingAddressResponseModel.fromJson(Map<String, dynamic> json) => ShippingAddressResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ShippingAddressData>.from(json["data"]!.map((x) => ShippingAddressData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ShippingAddressData {
  String? id;
  User? user;
  String? firstName;
  String? lastName;
  String? pinCode;
  String? state;
  String? city;
  String? address;
  DateTime? time;
  int? v;
  bool isSelected;

  ShippingAddressData({
    this.id,
    this.user,
    this.firstName,
    this.lastName,
    this.pinCode,
    this.state,
    this.city,
    this.address,
    this.time,
    this.v,
    this.isSelected = false,
  });

  factory ShippingAddressData.fromJson(Map<String, dynamic> json) => ShippingAddressData(
    id: json["_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    firstName: json["firstName"],
    lastName: json["lastName"],
    pinCode: json["pinCode"],
    state: json["state"],
    city: json["city"],
    address: json["address"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "firstName": firstName,
    "lastName": lastName,
    "pinCode": pinCode,
    "state": state,
    "city": city,
    "address": address,
    "time": time?.toIso8601String(),
    "__v": v,
  };
}
