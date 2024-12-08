// To parse this JSON data, do
//
//     final bannerModelResponse = bannerModelResponseFromJson(jsonString);

import 'dart:convert';

BannerModelResponse bannerModelResponseFromJson(String str) =>
    BannerModelResponse.fromJson(json.decode(str));

String bannerModelResponseToJson(BannerModelResponse data) =>
    json.encode(data.toJson());

class BannerModelResponse {
  List<Datum>? data;

  BannerModelResponse({
    this.data,
  });

  BannerModelResponse copyWith({
    List<Datum>? data,
  }) =>
      BannerModelResponse(
        data: data ?? this.data,
      );

  factory BannerModelResponse.fromJson(Map<String, dynamic> json) =>
      BannerModelResponse(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? key;
  String? type;
  String? src;
  dynamic link;
  dynamic description;
  dynamic value;

  Datum({
    this.key,
    this.type,
    this.src,
    this.link,
    this.description,
    this.value,
  });

  Datum copyWith({
    String? key,
    String? type,
    String? src,
    dynamic link,
    dynamic description,
    dynamic value,
  }) =>
      Datum(
        key: key ?? this.key,
        type: type ?? this.type,
        src: src ?? this.src,
        link: link ?? this.link,
        description: description ?? this.description,
        value: value ?? this.value,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        key: json["key"],
        type: json["type"],
        src: json["src"],
        link: json["link"],
        description: json["description"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "type": type,
        "src": src,
        "link": link,
        "description": description,
        "value": value,
      };
}
