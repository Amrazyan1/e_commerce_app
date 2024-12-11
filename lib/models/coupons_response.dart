// To parse this JSON data, do
//
//     final couponResponse = couponResponseFromJson(jsonString);

import 'dart:convert';

CouponResponse couponResponseFromJson(String str) => CouponResponse.fromJson(json.decode(str));

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
        data: json["data"] == null ? [] : List<CouponData>.from(json["data"]!.map((x) => CouponData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CouponData {
    String? name;
    String? discount;
    dynamic validTill;
    bool? isUsed;

    CouponData({
        this.name,
        this.discount,
        this.validTill,
        this.isUsed,
    });

    CouponData copyWith({
        String? name,
        String? discount,
        dynamic validTill,
        bool? isUsed,
    }) => 
        CouponData(
            name: name ?? this.name,
            discount: discount ?? this.discount,
            validTill: validTill ?? this.validTill,
            isUsed: isUsed ?? this.isUsed,
        );

    factory CouponData.fromJson(Map<String, dynamic> json) => CouponData(
        name: json["name"],
        discount: json["discount"],
        validTill: json["valid_till"],
        isUsed: json["is_used"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "discount": discount,
        "valid_till": validTill,
        "is_used": isUsed,
    };
}
