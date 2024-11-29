// To parse this JSON data, do
//
//     final favoritesResponse = favoritesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:e_commerce_app/models/Product/product_model.dart';

FavoritesResponse favoritesResponseFromJson(String str) =>
    FavoritesResponse.fromJson(json.decode(str));

class FavoritesResponse {
  Data? data;

  FavoritesResponse({
    this.data,
  });

  FavoritesResponse copyWith({
    Data? data,
  }) =>
      FavoritesResponse(
        data: data ?? this.data,
      );

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) =>
      FavoritesResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  String? fullName;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  bool? isPartner;
  dynamic discountDetails;
  List<Product>? favorites;

  Data({
    this.fullName,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.isPartner,
    this.discountDetails,
    this.favorites,
  });

  Data copyWith({
    String? fullName,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    bool? isPartner,
    dynamic discountDetails,
    List<Product>? favorites,
  }) =>
      Data(
        fullName: fullName ?? this.fullName,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        isPartner: isPartner ?? this.isPartner,
        discountDetails: discountDetails ?? this.discountDetails,
        favorites: favorites ?? this.favorites,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fullName: json["fullName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        isPartner: json["isPartner"],
        discountDetails: json["discountDetails"],
        favorites: json["favorites"] == null
            ? []
            : List<Product>.from(
                json["favorites"]!.map((x) => Product.fromJson(x))),
      );
}
