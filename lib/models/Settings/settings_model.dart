// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromJson(jsonString);

import 'dart:convert';

SettingsModel settingsModelFromJson(String str) =>
    SettingsModel.fromJson(json.decode(str));

String settingsModelToJson(SettingsModel data) => json.encode(data.toJson());

class SettingsModel {
  Data? data;

  SettingsModel({
    this.data,
  });

  SettingsModel copyWith({
    Data? data,
  }) =>
      SettingsModel(
        data: data ?? this.data,
      );

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
  String? email;
  String? phone;
  String? birthday;
  bool? isPartner;
  DiscountDetails? discountDetails;

  Data({
    this.fullName,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.birthday,
    this.isPartner,
    this.discountDetails,
  });

  Data copyWith({
    String? fullName,
    String? firstName,
    String? lastName,
    String? email,
    String? birthday,
    String? phone,
    bool? isPartner,
    DiscountDetails? discountDetails,
  }) =>
      Data(
        fullName: fullName ?? this.fullName,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        birthday: birthday ?? this.birthday,
        isPartner: isPartner ?? this.isPartner,
        discountDetails: discountDetails ?? this.discountDetails,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fullName: json["fullName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        birthday: json["birthday"],
        isPartner: json["isPartner"],
        discountDetails: json["discountDetails"] == null
            ? null
            : DiscountDetails.fromJson(json["discountDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "birthday": birthday,
        "isPartner": isPartner,
        "discountDetails": discountDetails?.toJson(),
      };
}

class DiscountDetails {
  int? level;
  int? discountPercent;
  bool? isFreeDelivery;
  bool? isFreeWorkerService;

  DiscountDetails({
    this.level,
    this.discountPercent,
    this.isFreeDelivery,
    this.isFreeWorkerService,
  });

  DiscountDetails copyWith({
    int? level,
    int? discountPercent,
    bool? isFreeDelivery,
    bool? isFreeWorkerService,
  }) =>
      DiscountDetails(
        level: level ?? this.level,
        discountPercent: discountPercent ?? this.discountPercent,
        isFreeDelivery: isFreeDelivery ?? this.isFreeDelivery,
        isFreeWorkerService: isFreeWorkerService ?? this.isFreeWorkerService,
      );

  factory DiscountDetails.fromJson(Map<String, dynamic> json) =>
      DiscountDetails(
        level: json["level"],
        discountPercent: json["discountPercent"],
        isFreeDelivery: json["isFreeDelivery"],
        isFreeWorkerService: json["isFreeWorkerService"],
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "discountPercent": discountPercent,
        "isFreeDelivery": isFreeDelivery,
        "isFreeWorkerService": isFreeWorkerService,
      };
}
