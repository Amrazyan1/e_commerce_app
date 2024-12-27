// To parse this JSON data, do
//
//     final cartProductsResponse = cartProductsResponseFromJson(jsonString);

import 'dart:convert';

import 'Product/product_model.dart';

CartProductsResponse cartProductsResponseFromJson(String str) =>
    CartProductsResponse.fromJson(json.decode(str));

String cartProductsResponseToJson(CartProductsResponse data) =>
    json.encode(data.toJson());

class CartProductsResponse {
  CartResponseData? data;

  CartProductsResponse({
    this.data,
  });

  CartProductsResponse copyWith({
    CartResponseData? data,
  }) =>
      CartProductsResponse(
        data: data ?? this.data,
      );

  factory CartProductsResponse.fromJson(Map<String, dynamic> json) =>
      CartProductsResponse(
        data: json["data"] == null
            ? null
            : CartResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class CartResponseData {
  String? subtotal;
  String? discount;
  String? total;
  int? count;
  OrderAble? orderAble;
  DeliveryDetails? deliveryDetails;
  List<CartProductItem>? list;

  CartResponseData({
    this.subtotal,
    this.discount,
    this.total,
    this.count,
    this.orderAble,
    this.deliveryDetails,
    this.list,
  });

  CartResponseData copyWith({
    String? subtotal,
    String? discount,
    String? total,
    int? count,
    List<CartProductItem>? list,
  }) =>
      CartResponseData(
        subtotal: subtotal ?? this.subtotal,
        discount: discount ?? this.discount,
        total: total ?? this.total,
        count: count ?? this.count,
        list: list ?? this.list,
      );

  factory CartResponseData.fromJson(Map<String, dynamic> json) =>
      CartResponseData(
        subtotal: json["subtotal"],
        discount: json["discount"],
        total: json["total"],
        count: json["count"],
        orderAble: json["orderAble"] == null
            ? null
            : OrderAble.fromJson(json["orderAble"]),
        deliveryDetails: json["deliveryDetails"] == null
            ? null
            : DeliveryDetails.fromJson(json["deliveryDetails"]),
        list: json["list"] == null
            ? []
            : List<CartProductItem>.from(
                json["list"]!.map((x) => CartProductItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subtotal": subtotal,
        "discount": discount,
        "total": total,
        "count": count,
        "orderAble": orderAble?.toJson(),
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class OrderAble {
  bool? orderAbleIs;
  String? description;

  OrderAble({
    this.orderAbleIs,
    this.description,
  });

  factory OrderAble.fromJson(Map<String, dynamic> json) => OrderAble(
        orderAbleIs: json["is"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "is": orderAbleIs,
        "description": description,
      };
}

class DeliveryDetails {
  bool? deliveryDetailIs;
  String? limit;

  DeliveryDetails({
    this.deliveryDetailIs,
    this.limit,
  });

  factory DeliveryDetails.fromJson(Map<String, dynamic> json) =>
      DeliveryDetails(
        deliveryDetailIs: json["is"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "is": deliveryDetailIs,
        "limit": limit,
      };
}

class CartProductItem {
  int? count;
  String? total;
  Product? product;

  CartProductItem({
    this.count,
    this.total,
    this.product,
  });

  CartProductItem copyWith({
    int? count,
    String? total,
    Product? product,
  }) =>
      CartProductItem(
        count: count ?? this.count,
        total: total ?? this.total,
        product: product ?? this.product,
      );

  factory CartProductItem.fromJson(Map<String, dynamic> json) =>
      CartProductItem(
        count: json["count"],
        total: json["total"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "total": total,
        "product": product?.toJson(),
      };
}

class Images {
  Main? main;

  Images({
    this.main,
  });

  Images copyWith({
    Main? main,
  }) =>
      Images(
        main: main ?? this.main,
      );

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        main: json["main"] == null ? null : Main.fromJson(json["main"]),
      );

  Map<String, dynamic> toJson() => {
        "main": main?.toJson(),
      };
}

class Main {
  String? src;
  bool? isMain;

  Main({
    this.src,
    this.isMain,
  });

  Main copyWith({
    String? src,
    bool? isMain,
  }) =>
      Main(
        src: src ?? this.src,
        isMain: isMain ?? this.isMain,
      );

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        src: json["src"],
        isMain: json["isMain"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
        "isMain": isMain,
      };
}

class Unit {
  String? name;
  String? value;
  String? type;
  Alternative? alternative;
  int? step;

  Unit({
    this.name,
    this.value,
    this.type,
    this.alternative,
    this.step,
  });

  Unit copyWith({
    String? name,
    String? value,
    String? type,
    Alternative? alternative,
    int? step,
  }) =>
      Unit(
        name: name ?? this.name,
        value: value ?? this.value,
        type: type ?? this.type,
        alternative: alternative ?? this.alternative,
        step: step ?? this.step,
      );

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        name: json["name"],
        value: json["value"],
        type: json["type"],
        alternative: json["alternative"] == null
            ? null
            : Alternative.fromJson(json["alternative"]),
        step: json["step"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "type": type,
        "alternative": alternative?.toJson(),
        "step": step,
      };
}
