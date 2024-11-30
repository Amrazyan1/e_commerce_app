// To parse this JSON data, do
//
//     final deliveryAddressesResponse = deliveryAddressesResponseFromJson(jsonString);

import 'dart:convert';

DeliveryAddressesResponse deliveryAddressesResponseFromJson(String str) =>
    DeliveryAddressesResponse.fromJson(json.decode(str));

String deliveryAddressesResponseToJson(DeliveryAddressesResponse data) =>
    json.encode(data.toJson());

class DeliveryAddressesResponse {
  List<Address>? data;

  DeliveryAddressesResponse({
    this.data,
  });

  DeliveryAddressesResponse copyWith({
    List<Address>? data,
  }) =>
      DeliveryAddressesResponse(
        data: data ?? this.data,
      );

  factory DeliveryAddressesResponse.fromJson(Map<String, dynamic> json) =>
      DeliveryAddressesResponse(
        data: json["data"] == null
            ? []
            : List<Address>.from(json["data"]!.map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Address {
  int? id;
  String? address;
  String? details;
  bool? isDefault;

  Address({
    this.id,
    this.address,
    this.details,
    this.isDefault,
  });

  Address copyWith({
    int? id,
    String? address,
    String? details,
    bool? isDefault,
  }) =>
      Address(
        id: id ?? this.id,
        address: address ?? this.address,
        details: details ?? this.details,
        isDefault: isDefault ?? this.isDefault,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        address: json["address"],
        details: json["details"],
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "details": details,
        "isDefault": isDefault,
      };
}
