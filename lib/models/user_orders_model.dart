// To parse this JSON data, do
//
//     final userOrdersResponse = userOrdersResponseFromJson(jsonString);

import 'dart:convert';

UserOrdersResponse userOrdersResponseFromJson(String str) =>
    UserOrdersResponse.fromJson(json.decode(str));

String userOrdersResponseToJson(UserOrdersResponse data) =>
    json.encode(data.toJson());

class UserOrdersResponse {
  List<Datum>? data;
  Links? links;
  Meta? meta;

  UserOrdersResponse({
    this.data,
    this.links,
    this.meta,
  });

  UserOrdersResponse copyWith({
    List<Datum>? data,
    Links? links,
    Meta? meta,
  }) =>
      UserOrdersResponse(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory UserOrdersResponse.fromJson(Map<String, dynamic> json) =>
      UserOrdersResponse(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  String? id;
  String? method;
  String? status;
  Address? address;
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
  String? totalWithDelivery;
  dynamic customer;

  Datum({
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
    this.deliveryPrice,
    this.totalWithDelivery,
    this.customer,
  });

  Datum copyWith({
    String? id,
    String? method,
    String? status,
    Address? address,
    String? date,
    bool? isCancelable,
    bool? isReversable,
    dynamic receiptLink,
    String? start,
    String? end,
    String? subtotal,
    String? discount,
    String? total,
    String? deliveryPrice,
    String? totalWithDelivery,
    dynamic customer,
  }) =>
      Datum(
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
        deliveryPrice: deliveryPrice ?? this.deliveryPrice,
        totalWithDelivery: totalWithDelivery ?? this.totalWithDelivery,
        customer: customer ?? this.customer,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        method: json["method"],
        status: json["status"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
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
        totalWithDelivery: json["totalWithDelivery"],
        customer: json["customer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method": method,
        "status": status,
        "address": address?.toJson(),
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
        "customer": customer,
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

class Links {
  String? first;
  String? last;
  dynamic prev;
  String? next;

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
    String? next,
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
