// To parse this JSON data, do
//
//     final viewOrderResponse = viewOrderResponseFromJson(jsonString);

import 'dart:convert';

ViewOrderResponse viewOrderResponseFromJson(String str) =>
    ViewOrderResponse.fromJson(json.decode(str));

String viewOrderResponseToJson(ViewOrderResponse data) =>
    json.encode(data.toJson());

class ViewOrderResponse {
  ViewOrderData? data;

  ViewOrderResponse({
    this.data,
  });

  ViewOrderResponse copyWith({
    ViewOrderData? data,
  }) =>
      ViewOrderResponse(
        data: data ?? this.data,
      );

  factory ViewOrderResponse.fromJson(Map<String, dynamic> json) =>
      ViewOrderResponse(
        data:
            json["data"] == null ? null : ViewOrderData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ViewOrderData {
  String? id;
  String? method;
  String? status;
  dynamic address;
  String? date;
  bool? isCancelable;
  bool? isReversable;
  dynamic receiptLink;
  String? start;
  String? end;
  String? subtotal;
  String? discount;
  String? total;
  String? deliveryPrice;
  String? availableBonuses;
  String? totalWithDelivery;
  List<PaymentMethod>? paymentMethods;
  dynamic customer;
  List<Item>? items;
  List<Address>? addresses;

  ViewOrderData({
    this.id,
    this.method,
    this.status,
    this.address,
    this.date,
    this.isCancelable,
    this.isReversable,
    this.receiptLink,
    this.start,
    this.end,
    this.subtotal,
    this.discount,
    this.total,
    this.availableBonuses,
    this.deliveryPrice,
    this.totalWithDelivery,
    this.paymentMethods,
    this.customer,
    this.items,
    this.addresses,
  });

  ViewOrderData copyWith({
    String? id,
    String? method,
    String? status,
    dynamic address,
    String? date,
    bool? isCancelable,
    bool? isReversable,
    dynamic receiptLink,
    String? start,
    String? end,
    String? subtotal,
    String? discount,
    String? total,
    String? availabelBonuses,
    String? deliveryPrice,
    String? totalWithDelivery,
    List<PaymentMethod>? paymentMethods,
    dynamic customer,
    List<Item>? items,
    List<Address>? addresses,
  }) =>
      ViewOrderData(
        id: id ?? this.id,
        method: method ?? this.method,
        status: status ?? this.status,
        address: address ?? this.address,
        date: date ?? this.date,
        isCancelable: isCancelable ?? this.isCancelable,
        isReversable: isReversable ?? this.isReversable,
        receiptLink: receiptLink ?? this.receiptLink,
        start: start ?? this.start,
        end: end ?? this.end,
        subtotal: subtotal ?? this.subtotal,
        discount: discount ?? this.discount,
        total: total ?? this.total,
        availableBonuses: availableBonuses ?? this.availableBonuses,
        deliveryPrice: deliveryPrice ?? this.deliveryPrice,
        totalWithDelivery: totalWithDelivery ?? this.totalWithDelivery,
        paymentMethods: paymentMethods ?? this.paymentMethods,
        customer: customer ?? this.customer,
        items: items ?? this.items,
        addresses: addresses ?? this.addresses,
      );

  factory ViewOrderData.fromJson(Map<String, dynamic> json) => ViewOrderData(
        id: json["id"],
        method: json["method"],
        status: json["status"],
        address: json["address"],
        date: json["date"],
        isCancelable: json["isCancelable"],
        isReversable: json["isReversable"],
        receiptLink: json["receiptLink"],
        start: json["start"],
        end: json["end"],
        subtotal: json["subtotal"],
        discount: json["discount"],
        total: json["total"],
        deliveryPrice: json["deliveryPrice"],
        availableBonuses: json["availableBonuses"],
        totalWithDelivery: json["totalWithDelivery"],
        paymentMethods: json["paymentMethods"] == null
            ? []
            : List<PaymentMethod>.from(
                json["paymentMethods"]!.map((x) => PaymentMethod.fromJson(x))),
        customer: json["customer"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method": method,
        "status": status,
        "address": address,
        "date": date,
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
        "paymentMethods": paymentMethods == null
            ? []
            : List<dynamic>.from(paymentMethods!.map((x) => x.toJson())),
        "customer": customer,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
      };
}

class Address {
  int? id;
  String? name;
  String? address;
  String? details;
  bool? isDefault;

  Address({
    this.id,
    this.name,
    this.address,
    this.details,
    this.isDefault,
  });

  Address copyWith({
    int? id,
    String? name,
    String? address,
    String? details,
    bool? isDefault,
  }) =>
      Address(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        details: details ?? this.details,
        isDefault: isDefault ?? this.isDefault,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        details: json["details"],
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "details": details,
        "isDefault": isDefault,
      };
}

class Item {
  int? id;
  String? count;
  String? subtotal;
  String? discount;
  String? total;
  Product? product;

  Item({
    this.id,
    this.count,
    this.subtotal,
    this.discount,
    this.total,
    this.product,
  });

  Item copyWith({
    int? id,
    String? count,
    String? subtotal,
    String? discount,
    String? total,
    Product? product,
  }) =>
      Item(
        id: id ?? this.id,
        count: count ?? this.count,
        subtotal: subtotal ?? this.subtotal,
        discount: discount ?? this.discount,
        total: total ?? this.total,
        product: product ?? this.product,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        count: json["count"],
        subtotal: json["subtotal"],
        discount: json["discount"],
        total: json["total"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "subtotal": subtotal,
        "discount": discount,
        "total": total,
        "product": product?.toJson(),
      };
}

class Product {
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
  Images? images;
  List<Breadcrumb>? breadcrumb;
  int? rating;

  Product({
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

  Product copyWith({
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
    Images? images,
    List<Breadcrumb>? breadcrumb,
    int? rating,
  }) =>
      Product(
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
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

class Alternative {
  dynamic name;
  dynamic value;

  Alternative({
    this.name,
    this.value,
  });

  Alternative copyWith({
    dynamic name,
    dynamic value,
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

class PaymentMethod {
  String? slug;
  String? name;
  String? description;
  String? icon;
  bool? available;

  PaymentMethod({
    this.slug,
    this.name,
    this.description,
    this.icon,
    this.available,
  });

  PaymentMethod copyWith({
    String? slug,
    String? name,
    String? description,
    String? icon,
    bool? available,
  }) =>
      PaymentMethod(
        slug: slug ?? this.slug,
        name: name ?? this.name,
        description: description ?? this.description,
        icon: icon ?? this.icon,
        available: available ?? this.available,
      );

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        slug: json["slug"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "description": description,
        "icon": icon,
        "available": available,
      };
}
