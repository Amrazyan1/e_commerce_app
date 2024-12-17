// To parse this JSON data, do
//
//     final processOrderResponse = processOrderResponseFromJson(jsonString);

import 'dart:convert';

ProcessOrderResponse processOrderResponseFromJson(String str) =>
    ProcessOrderResponse.fromJson(json.decode(str));

String processOrderResponseToJson(ProcessOrderResponse data) =>
    json.encode(data.toJson());

class ProcessOrderResponse {
  Data? data;

  ProcessOrderResponse({
    this.data,
  });

  factory ProcessOrderResponse.fromJson(Map<String, dynamic> json) =>
      ProcessOrderResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  String? id;
  String? method;
  String? status;
  Address? address;
  String? date;
  String? availableBonuses;
  bool? isCancelable;
  bool? isReversable;
  dynamic receiptLink;
  String? start;
  String? end;
  String? subtotal;
  String? discount;
  String? total;
  String? deliveryPrice;
  String? totalWithDelivery;

  Data({
    this.id,
    this.method,
    this.status,
    this.address,
    this.date,
    this.availableBonuses,
    this.isCancelable,
    this.isReversable,
    this.receiptLink,
    this.start,
    this.end,
    this.subtotal,
    this.discount,
    this.total,
    this.deliveryPrice,
    this.totalWithDelivery,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        method: json["method"],
        status: json["status"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        date: json["date"],
        availableBonuses: json["availableBonuses"],
        isCancelable: json["isCancelable"],
        isReversable: json["isReversable"],
        receiptLink: json["receiptLink"],
        start: json["start"],
        end: json["end"],
        subtotal: json["subtotal"],
        discount: json["discount"],
        total: json["total"],
        deliveryPrice: json["deliveryPrice"],
        totalWithDelivery: json["totalWithDelivery"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method": method,
        "status": status,
        "address": address?.toJson(),
        "date": date,
        "availableBonuses": availableBonuses,
        "isCancelable": isCancelable,
        "isReversable": isReversable,
        "receiptLink": receiptLink,
        "start": start,
        "end": end,
        "subtotal": subtotal,
        "discount": discount,
        "total": total,
        "deliveryPrice": deliveryPrice,
        "totalWithDelivery": totalWithDelivery,
      };
}

class Address {
  int? id;
  String? name;
  String? address;
  String? details;
  bool? isDefault;
  String? latitude;
  String? longitude;
  String? distance;

  Address({
    this.id,
    this.name,
    this.address,
    this.details,
    this.isDefault,
    this.latitude,
    this.longitude,
    this.distance,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        details: json["details"],
        isDefault: json["isDefault"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "details": details,
        "isDefault": isDefault,
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
      };
}
