// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  List<Product>? data;

  ProductModel({
    this.data,
  });

  ProductModel copyWith({
    List<Product>? data,
  }) =>
      ProductModel(
        data: data ?? this.data,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Product {
  String id;
  String? name;
  String? description;
  String? count;
  int? isNew;
  int? isPopular;
  Unit? unit;
  String? price;
  String? discount;
  String? discountedPrice;
  Images? images;
  Main? image;
  int? bonusPercent;
  dynamic bonus;

  Product({
    required this.id,
    this.name,
    this.description,
    this.count,
    this.isNew,
    this.isPopular,
    this.unit,
    this.price,
    this.discount,
    this.discountedPrice,
    this.images,
    this.image,
    this.bonusPercent,
    this.bonus,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? count,
    int? isNew,
    int? isPopular,
    Unit? unit,
    String? price,
    String? discount,
    String? discountedPrice,
    Images? images,
    int? bonusPercent,
    dynamic bonus,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        count: count ?? this.count,
        isNew: isNew ?? this.isNew,
        isPopular: isPopular ?? this.isPopular,
        unit: unit ?? this.unit,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        images: images ?? this.images,
        bonusPercent: bonusPercent ?? this.bonusPercent,
        bonus: bonus ?? this.bonus,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        count: json["count"],
        isNew: json["isNew"],
        isPopular: json["isPopular"],
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        price: json["price"],
        discount: json["discount"],
        discountedPrice: json["discountedPrice"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        image: json["image"] == null ? null : Main.fromJson(json["image"]),
        bonusPercent: json["bonusPercent"],
        bonus: json["bonus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "count": count,
        "isNew": isNew,
        "isPopular": isPopular,
        "unit": unit?.toJson(),
        "price": price,
        "discount": discount,
        "discountedPrice": discountedPrice,
        "images": images?.toJson(),
        "bonusPercent": bonusPercent,
        "bonus": bonus,
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
  Type? type;
  Alternative? alternative;
  int? minCount;
  int? maxCount;
  Unit({
    this.name,
    this.value,
    this.type,
    this.alternative,
    this.minCount,
    this.maxCount,
  });

  Unit copyWith({
    String? name,
    String? value,
    Type? type,
    Alternative? alternative,
  }) =>
      Unit(
        name: name ?? this.name,
        value: value ?? this.value,
        type: type ?? this.type,
        alternative: alternative ?? this.alternative,
      );

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        name: json["name"],
        value: json["value"],
        minCount: json["minCount"],
        maxCount: json["maxCount"],
        type: typeValues.map[json["type"]]!,
        alternative: json["alternative"] == null ? null : Alternative.fromJson(json["alternative"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "type": typeValues.reverse[type],
        "alternative": alternative?.toJson(),
      };
}

class Alternative {
  String? name;
  String? value;

  Alternative({
    this.name,
    this.value,
  });

  Alternative copyWith({
    String? name,
    String? value,
  }) =>
      Alternative(
        name: name ?? this.name,
        value: value ?? this.value,
      );

  factory Alternative.fromJson(Map<String, dynamic> json) => Alternative(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}

enum Type { FLOAT, INT }

final typeValues = EnumValues({"float": Type.FLOAT, "int": Type.INT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
