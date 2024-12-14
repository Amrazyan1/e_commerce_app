// To parse this JSON data, do
//
//     final globalSearchResponse = globalSearchResponseFromJson(jsonString);

import 'dart:convert';

import 'package:e_commerce_app/models/Product/product_model.dart';

GlobalSearchResponse globalSearchResponseFromJson(String str) =>
    GlobalSearchResponse.fromJson(json.decode(str));

String globalSearchResponseToJson(GlobalSearchResponse data) =>
    json.encode(data.toJson());

class GlobalSearchResponse {
  bool? errors;
  String? message;
  GlobalSearchResponseData? data;

  GlobalSearchResponse({
    this.errors,
    this.message,
    this.data,
  });

  GlobalSearchResponse copyWith({
    bool? errors,
    String? message,
    GlobalSearchResponseData? data,
  }) =>
      GlobalSearchResponse(
        errors: errors ?? this.errors,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GlobalSearchResponse.fromJson(Map<String, dynamic> json) =>
      GlobalSearchResponse(
        errors: json["errors"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : GlobalSearchResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "errors": errors,
        "message": message,
        "data": data?.toJson(),
      };
}

class GlobalSearchResponseData {
  List<dynamic>? colors;
  Products? products;

  GlobalSearchResponseData({
    this.colors,
    this.products,
  });

  GlobalSearchResponseData copyWith({
    List<dynamic>? colors,
    Products? products,
  }) =>
      GlobalSearchResponseData(
        colors: colors ?? this.colors,
        products: products ?? this.products,
      );

  factory GlobalSearchResponseData.fromJson(Map<String, dynamic> json) =>
      GlobalSearchResponseData(
        colors: json["colors"] == null
            ? []
            : List<dynamic>.from(json["colors"]!.map((x) => x)),
        products: json["products"] == null
            ? null
            : Products.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "colors":
            colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
        "products": products?.toJson(),
      };
}

class Products {
  ProductsData? data;

  Products({
    this.data,
  });

  Products copyWith({
    ProductsData? data,
  }) =>
      Products(
        data: data ?? this.data,
      );

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        data: json["data"] == null ? null : ProductsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ProductsData {
  List<Product>? data;
  Links? links;
  Meta? meta;

  ProductsData({
    this.data,
    this.links,
    this.meta,
  });

  ProductsData copyWith({
    List<Product>? data,
    Links? links,
    Meta? meta,
  }) =>
      ProductsData(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory ProductsData.fromJson(Map<String, dynamic> json) => ProductsData(
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
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

  Unit({
    this.name,
    this.value,
    this.type,
    this.alternative,
  });

  Unit copyWith({
    String? name,
    String? value,
    String? type,
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
        type: json["type"],
        alternative: json["alternative"] == null
            ? null
            : Alternative.fromJson(json["alternative"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "type": type,
        "alternative": alternative?.toJson(),
      };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  Links copyWith({
    String? first,
    String? last,
    dynamic prev,
    dynamic next,
  }) =>
      Links(
        first: first ?? this.first,
        last: last ?? this.last,
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  Meta copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    List<Link>? links,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) =>
      Meta(
        currentPage: currentPage ?? this.currentPage,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        links: links ?? this.links,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
