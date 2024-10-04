// To parse this JSON data, do
//
//     final addShippingAddressrResponseModel = addShippingAddressrResponseModelFromJson(jsonString);

import 'dart:convert';

AddShippingAddressResponseModel addShippingAddressResponseModelFromJson(String str) => AddShippingAddressResponseModel.fromJson(json.decode(str));

String addShippingAddressResponseModelToJson(AddShippingAddressResponseModel data) => json.encode(data.toJson());

class AddShippingAddressResponseModel {
  bool? success;
  String? message;
  AddShippingAddressdata? data;

  AddShippingAddressResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory AddShippingAddressResponseModel.fromJson(Map<String, dynamic> json) => AddShippingAddressResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : AddShippingAddressdata.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class AddShippingAddressdata {
  String? user;
  String? firstName;
  String? lastName;
  String? pinCode;
  String? state;
  String? city;
  String? address;
  String? id;
  DateTime? time;
  int? v;

  AddShippingAddressdata({
    this.user,
    this.firstName,
    this.lastName,
    this.pinCode,
    this.state,
    this.city,
    this.address,
    this.id,
    this.time,
    this.v,
  });

  factory AddShippingAddressdata.fromJson(Map<String, dynamic> json) => AddShippingAddressdata(
    user: json["user"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    pinCode: json["pinCode"],
    state: json["state"],
    city: json["city"],
    address: json["address"],
    id: json["_id"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "firstName": firstName,
    "lastName": lastName,
    "pinCode": pinCode,
    "state": state,
    "city": city,
    "address": address,
    "_id": id,
    "time": time?.toIso8601String(),
    "__v": v,
  };
}
