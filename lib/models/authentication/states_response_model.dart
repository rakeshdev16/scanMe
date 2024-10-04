// To parse this JSON data, do
//
//     final statesResModel = statesResModelFromJson(jsonString);

import 'dart:convert';

StatesResponseModel statesResModelFromJson(String str) =>
    StatesResponseModel.fromJson(json.decode(str));

String statesResModelToJson(StatesResponseModel data) =>
    json.encode(data.toJson());

class StatesResponseModel {
  bool? success;
  String? message;
  StatesDataModel? data;

  StatesResponseModel({this.success, this.message, this.data});

  StatesResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? StatesDataModel.fromJson(json['data']) : null;
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

class StatesDataModel {
  List<States>? states;

  StatesDataModel({this.states});

  StatesDataModel.fromJson(Map<String, dynamic> json) {
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (states != null) {
      data['states'] = states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  String? name;
  List<Cities>? cities;

  States({this.name, this.cities});

  States.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  String? name;

  Cities({this.name});

  Cities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
