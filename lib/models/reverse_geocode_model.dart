// To parse this JSON data, do
//
//     final reverseGeocodeResponse = reverseGeocodeResponseFromJson(jsonString);

import 'dart:convert';

ReverseGeocodeResponse reverseGeocodeResponseFromJson(String str) =>
    ReverseGeocodeResponse.fromJson(json.decode(str));

String reverseGeocodeResponseToJson(ReverseGeocodeResponse data) =>
    json.encode(data.toJson());

class ReverseGeocodeResponse {
  int? placeId;
  String? licence;
  String? osmType;
  int? osmId;
  String? lat;
  String? lon;
  String? reverseGeocodeResponseClass;
  String? type;
  int? placeRank;
  double? importance;
  String? addresstype;
  String? name;
  String? displayName;
  Address? address;
  List<String>? boundingbox;

  ReverseGeocodeResponse({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.reverseGeocodeResponseClass,
    this.type,
    this.placeRank,
    this.importance,
    this.addresstype,
    this.name,
    this.displayName,
    this.address,
    this.boundingbox,
  });

  ReverseGeocodeResponse copyWith({
    int? placeId,
    String? licence,
    String? osmType,
    int? osmId,
    String? lat,
    String? lon,
    String? reverseGeocodeResponseClass,
    String? type,
    int? placeRank,
    double? importance,
    String? addresstype,
    String? name,
    String? displayName,
    Address? address,
    List<String>? boundingbox,
  }) =>
      ReverseGeocodeResponse(
        placeId: placeId ?? this.placeId,
        licence: licence ?? this.licence,
        osmType: osmType ?? this.osmType,
        osmId: osmId ?? this.osmId,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        reverseGeocodeResponseClass:
            reverseGeocodeResponseClass ?? this.reverseGeocodeResponseClass,
        type: type ?? this.type,
        placeRank: placeRank ?? this.placeRank,
        importance: importance ?? this.importance,
        addresstype: addresstype ?? this.addresstype,
        name: name ?? this.name,
        displayName: displayName ?? this.displayName,
        address: address ?? this.address,
        boundingbox: boundingbox ?? this.boundingbox,
      );

  factory ReverseGeocodeResponse.fromJson(Map<String, dynamic> json) =>
      ReverseGeocodeResponse(
        placeId: json["place_id"],
        licence: json["licence"],
        osmType: json["osm_type"],
        osmId: json["osm_id"],
        lat: json["lat"],
        lon: json["lon"],
        reverseGeocodeResponseClass: json["class"],
        type: json["type"],
        placeRank: json["place_rank"],
        importance: json["importance"]?.toDouble(),
        addresstype: json["addresstype"],
        name: json["name"],
        displayName: json["display_name"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        boundingbox: json["boundingbox"] == null
            ? []
            : List<String>.from(json["boundingbox"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "licence": licence,
        "osm_type": osmType,
        "osm_id": osmId,
        "lat": lat,
        "lon": lon,
        "class": reverseGeocodeResponseClass,
        "type": type,
        "place_rank": placeRank,
        "importance": importance,
        "addresstype": addresstype,
        "name": name,
        "display_name": displayName,
        "address": address?.toJson(),
        "boundingbox": boundingbox == null
            ? []
            : List<dynamic>.from(boundingbox!.map((x) => x)),
      };
}

class Address {
  String? houseNumber;
  String? road;
  String? suburb;
  String? city;
  String? iso31662Lvl4;
  String? postcode;
  String? country;
  String? countryCode;

  Address({
    this.houseNumber,
    this.road,
    this.suburb,
    this.city,
    this.iso31662Lvl4,
    this.postcode,
    this.country,
    this.countryCode,
  });

  Address copyWith({
    String? houseNumber,
    String? road,
    String? suburb,
    String? city,
    String? iso31662Lvl4,
    String? postcode,
    String? country,
    String? countryCode,
  }) =>
      Address(
        houseNumber: houseNumber ?? this.houseNumber,
        road: road ?? this.road,
        suburb: suburb ?? this.suburb,
        city: city ?? this.city,
        iso31662Lvl4: iso31662Lvl4 ?? this.iso31662Lvl4,
        postcode: postcode ?? this.postcode,
        country: country ?? this.country,
        countryCode: countryCode ?? this.countryCode,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        houseNumber: json["house_number"],
        road: json["road"],
        suburb: json["suburb"],
        city: json["city"],
        iso31662Lvl4: json["ISO3166-2-lvl4"],
        postcode: json["postcode"],
        country: json["country"],
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "house_number": houseNumber,
        "road": road,
        "suburb": suburb,
        "city": city,
        "ISO3166-2-lvl4": iso31662Lvl4,
        "postcode": postcode,
        "country": country,
        "country_code": countryCode,
      };
}
