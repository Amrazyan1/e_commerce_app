// To parse this JSON data, do
//
//     final couponResponse = couponResponseFromJson(jsonString);

import 'dart:convert';

CouponResponse couponResponseFromJson(String str) =>
    CouponResponse.fromJson(json.decode(str));

String couponResponseToJson(CouponResponse data) => json.encode(data.toJson());

class CouponResponse {
  List<CouponData>? data;

  CouponResponse({
    this.data,
  });

  CouponResponse copyWith({
    List<CouponData>? data,
  }) =>
      CouponResponse(
        data: data ?? this.data,
      );

  factory CouponResponse.fromJson(Map<String, dynamic> json) => CouponResponse(
        data: json["data"] == null
            ? []
            : List<CouponData>.from(
                json["data"]!.map((x) => CouponData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CouponData {
  int? id;
  String? name;
  String? discount;
  String? description;
  String? expiresIn;
  bool? isUsed;

  CouponData({
    this.id,
    this.name,
    this.discount,
    this.description,
    this.expiresIn,
    this.isUsed,
  });

  CouponData copyWith({
    int? id,
    String? name,
    String? discount,
    String? description,
    String? expiresIn,
    bool? isUsed,
  }) =>
      CouponData(
        id: id ?? this.id,
        name: name ?? this.name,
        discount: discount ?? this.discount,
        description: description ?? this.description,
        expiresIn: expiresIn ?? this.expiresIn,
        isUsed: isUsed ?? this.isUsed,
      );

  factory CouponData.fromJson(Map<String, dynamic> json) => CouponData(
        id: json["id"],
        name: json["name"],
        discount: json["discount"],
        description: json["description"],
        expiresIn: json["expires_in"],
        isUsed: json["is_used"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "discount": discount,
        "description": description,
        "expires_in": expiresIn,
        "is_used": isUsed,
      };
}
