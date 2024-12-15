// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:e_commerce_app/models/Product/product_model.dart';

ProductDetailModel productDetailModelFromJson(String str) =>
    ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) =>
    json.encode(data.toJson());

class ProductDetailModel {
  ProductDetail? data;

  ProductDetailModel({
    this.data,
  });

  ProductDetailModel copyWith({
    ProductDetail? data,
  }) =>
      ProductDetailModel(
        data: data ?? this.data,
      );

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        data:
            json["data"] == null ? null : ProductDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ProductDetail {
  String? id;
  String? name;
  String? description;
  String? count;
  dynamic code;
  int? isNew;
  int? isPopular;
  dynamic brand;
  Unit? unit;
  Category? category;
  String? price;
  String? discount;
  String? discountedPrice;
  DataImages? images;
  List<dynamic>? characteristics;
  List<dynamic>? relates;
  List<Similar>? similars;
  List<Breadcrumb>? breadcrumb;
  int? rating;
  List<dynamic>? feedbacks;

  ProductDetail({
    this.id,
    this.name,
    this.description,
    this.count,
    this.code,
    this.isNew,
    this.isPopular,
    this.brand,
    this.unit,
    this.category,
    this.price,
    this.discount,
    this.discountedPrice,
    this.images,
    this.characteristics,
    this.relates,
    this.similars,
    this.breadcrumb,
    this.rating,
    this.feedbacks,
  });

  ProductDetail copyWith({
    String? id,
    String? name,
    String? description,
    String? count,
    dynamic code,
    int? isNew,
    int? isPopular,
    dynamic brand,
    Unit? unit,
    Category? category,
    String? price,
    String? discount,
    String? discountedPrice,
    DataImages? images,
    List<dynamic>? characteristics,
    List<dynamic>? relates,
    List<Similar>? similars,
    List<Breadcrumb>? breadcrumb,
    int? rating,
    List<dynamic>? feedbacks,
  }) =>
      ProductDetail(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        count: count ?? this.count,
        code: code ?? this.code,
        isNew: isNew ?? this.isNew,
        isPopular: isPopular ?? this.isPopular,
        brand: brand ?? this.brand,
        unit: unit ?? this.unit,
        category: category ?? this.category,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        images: images ?? this.images,
        characteristics: characteristics ?? this.characteristics,
        relates: relates ?? this.relates,
        similars: similars ?? this.similars,
        breadcrumb: breadcrumb ?? this.breadcrumb,
        rating: rating ?? this.rating,
        feedbacks: feedbacks ?? this.feedbacks,
      );

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        count: json["count"],
        code: json["code"],
        isNew: json["isNew"],
        isPopular: json["isPopular"],
        brand: json["brand"],
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        price: json["price"],
        discount: json["discount"],
        discountedPrice: json["discountedPrice"],
        images:
            json["images"] == null ? null : DataImages.fromJson(json["images"]),
        characteristics: json["characteristics"] == null
            ? []
            : List<dynamic>.from(json["characteristics"]!.map((x) => x)),
        relates: json["relates"] == null
            ? []
            : List<dynamic>.from(json["relates"]!.map((x) => x)),
        similars: json["similars"] == null
            ? []
            : List<Similar>.from(
                json["similars"]!.map((x) => Similar.fromJson(x))),
        breadcrumb: json["breadcrumb"] == null
            ? []
            : List<Breadcrumb>.from(
                json["breadcrumb"]!.map((x) => Breadcrumb.fromJson(x))),
        rating: json["rating"],
        feedbacks: json["feedbacks"] == null
            ? []
            : List<dynamic>.from(json["feedbacks"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "count": count,
        "code": code,
        "isNew": isNew,
        "isPopular": isPopular,
        "brand": brand,
        "unit": unit?.toJson(),
        "category": category?.toJson(),
        "price": price,
        "discount": discount,
        "discountedPrice": discountedPrice,
        "images": images?.toJson(),
        "characteristics": characteristics == null
            ? []
            : List<dynamic>.from(characteristics!.map((x) => x)),
        "relates":
            relates == null ? [] : List<dynamic>.from(relates!.map((x) => x)),
        "similars": similars == null
            ? []
            : List<dynamic>.from(similars!.map((x) => x.toJson())),
        "breadcrumb": breadcrumb == null
            ? []
            : List<dynamic>.from(breadcrumb!.map((x) => x.toJson())),
        "rating": rating,
        "feedbacks": feedbacks == null
            ? []
            : List<dynamic>.from(feedbacks!.map((x) => x)),
      };
}

class Breadcrumb {
  String? uuid;
  String? name;
  bool? isSubcategory;

  Breadcrumb({
    this.uuid,
    this.name,
    this.isSubcategory,
  });

  Breadcrumb copyWith({
    String? uuid,
    String? name,
    bool? isSubcategory,
  }) =>
      Breadcrumb(
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        isSubcategory: isSubcategory ?? this.isSubcategory,
      );

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
        uuid: json["uuid"],
        name: json["name"],
        isSubcategory: json["is_subcategory"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "is_subcategory": isSubcategory,
      };
}

class Category {
  String? id;
  String? name;
  String? image;
  dynamic categoryParentId;

  Category({
    this.id,
    this.name,
    this.image,
    this.categoryParentId,
  });

  Category copyWith({
    String? id,
    String? name,
    String? image,
    dynamic categoryParentId,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        categoryParentId: categoryParentId ?? this.categoryParentId,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        categoryParentId: json["categoryParentId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "categoryParentId": categoryParentId,
      };
}

class DataImages {
  Main? main;
  List<Main>? additional;

  DataImages({
    this.main,
    this.additional,
  });

  DataImages copyWith({
    Main? main,
    List<Main>? additional,
  }) =>
      DataImages(
        main: main ?? this.main,
        additional: additional ?? this.additional,
      );

  factory DataImages.fromJson(Map<String, dynamic> json) => DataImages(
        main: json["main"] == null ? null : Main.fromJson(json["main"]),
        additional: json["additional"] == null
            ? []
            : List<Main>.from(json["additional"]!.map((x) => Main.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "main": main?.toJson(),
        "additional": additional == null
            ? []
            : List<dynamic>.from(additional!.map((x) => x.toJson())),
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

class Similar {
  String? id;
  String? name;
  String? description;
  String? count;
  dynamic code;
  int? isNew;
  int? isPopular;
  dynamic brand;
  Unit? unit;
  String? price;
  String? discount;
  String? discountedPrice;
  SimilarImages? images;
  List<Breadcrumb>? breadcrumb;
  int? rating;

  Similar({
    this.id,
    this.name,
    this.description,
    this.count,
    this.code,
    this.isNew,
    this.isPopular,
    this.brand,
    this.unit,
    this.price,
    this.discount,
    this.discountedPrice,
    this.images,
    this.breadcrumb,
    this.rating,
  });

  Similar copyWith({
    String? id,
    String? name,
    String? description,
    String? count,
    dynamic code,
    int? isNew,
    int? isPopular,
    dynamic brand,
    Unit? unit,
    String? price,
    String? discount,
    String? discountedPrice,
    SimilarImages? images,
    List<Breadcrumb>? breadcrumb,
    int? rating,
  }) =>
      Similar(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        count: count ?? this.count,
        code: code ?? this.code,
        isNew: isNew ?? this.isNew,
        isPopular: isPopular ?? this.isPopular,
        brand: brand ?? this.brand,
        unit: unit ?? this.unit,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        images: images ?? this.images,
        breadcrumb: breadcrumb ?? this.breadcrumb,
        rating: rating ?? this.rating,
      );

  factory Similar.fromJson(Map<String, dynamic> json) => Similar(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        count: json["count"],
        code: json["code"],
        isNew: json["isNew"],
        isPopular: json["isPopular"],
        brand: json["brand"],
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        price: json["price"],
        discount: json["discount"],
        discountedPrice: json["discountedPrice"],
        images: json["images"] == null
            ? null
            : SimilarImages.fromJson(json["images"]),
        breadcrumb: json["breadcrumb"] == null
            ? []
            : List<Breadcrumb>.from(
                json["breadcrumb"]!.map((x) => Breadcrumb.fromJson(x))),
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "count": count,
        "code": code,
        "isNew": isNew,
        "isPopular": isPopular,
        "brand": brand,
        "unit": unit?.toJson(),
        "price": price,
        "discount": discount,
        "discountedPrice": discountedPrice,
        "images": images?.toJson(),
        "breadcrumb": breadcrumb == null
            ? []
            : List<dynamic>.from(breadcrumb!.map((x) => x.toJson())),
        "rating": rating,
      };
}

class SimilarImages {
  Main? main;

  SimilarImages({
    this.main,
  });

  SimilarImages copyWith({
    Main? main,
  }) =>
      SimilarImages(
        main: main ?? this.main,
      );

  factory SimilarImages.fromJson(Map<String, dynamic> json) => SimilarImages(
        main: json["main"] == null ? null : Main.fromJson(json["main"]),
      );

  Map<String, dynamic> toJson() => {
        "main": main?.toJson(),
      };
}
