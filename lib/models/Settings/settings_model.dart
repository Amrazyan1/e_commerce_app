// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromJson(jsonString);

import 'dart:convert';

SettingsModel settingsModelFromJson(String str) => SettingsModel.fromJson(json.decode(str));

String settingsModelToJson(SettingsModel data) => json.encode(data.toJson());

class SettingsModel {
  Data? data;

  SettingsModel({
    this.data,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  String? fullName;
  String? firstName;
  String? lastName;
  String? birthday;
  String? sex;
  String? email;
  String? phone;
  bool? isPartner;
  String? bonus;
  String? bonusCode;
  StoreAddress? storeAddress;

  Data({
    this.fullName,
    this.firstName,
    this.lastName,
    this.birthday,
    this.sex,
    this.email,
    this.phone,
    this.isPartner,
    this.bonus,
    this.bonusCode,
    this.storeAddress,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fullName: json["fullName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        birthday: json["birthday"],
        sex: json["sex"],
        email: json["email"],
        phone: json["phone"],
        isPartner: json["isPartner"],
        bonus: json["bonus"],
        bonusCode: json["bonus_code"],
        storeAddress:
            json["storeAddress"] == null ? null : StoreAddress.fromJson(json["storeAddress"]),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "firstName": firstName,
        "lastName": lastName,
        "birthday": birthday,
        "sex": sex,
        "email": email,
        "phone": phone,
        "isPartner": isPartner,
        "bonus": bonus,
        "bonus_code": bonusCode,
        "storeAddress": storeAddress?.toJson(),
      };
}

class StoreAddress {
  String? lat;
  String? long;

  StoreAddress({
    this.lat,
    this.long,
  });

  factory StoreAddress.fromJson(Map<String, dynamic> json) => StoreAddress(
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };
}
