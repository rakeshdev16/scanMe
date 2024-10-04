// To parse this JSON data, do
//
//     final loginResModel = loginResModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  bool? success;
  String? message;
  User? data;

  LoginResponseModel({this.success, this.message, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
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

class User {
  String? sId;
  String? token;
  bool? isNewUser;
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? mobile;
  String? userId;
  String? image;
  String? pincode;
  String? city;
  String? state;
  String? address;

  User(
      {this.token,
      this.sId,
      this.firstName,
      this.isNewUser,
      this.lastName,
      this.email,
      this.countryCode,
      this.mobile,
      this.userId,
      this.image,
      this.pincode,
      this.city,
      this.state,
      this.address});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    token = json['token'];
    isNewUser = json['isNewUser'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    userId = json['userId'];
    image = json['image'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['token'] = token;
    data['isNewUser'] = isNewUser;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['countryCode'] = countryCode;
    data['mobile'] = mobile;
    data['userId'] = userId;
    data['image'] = image;
    data['pincode'] = pincode;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    return data;
  }
}
