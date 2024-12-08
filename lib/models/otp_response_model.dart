// To parse this JSON data, do
//
//     final otpModelResponse = otpModelResponseFromJson(jsonString);

import 'dart:convert';

OtpModelResponse otpModelResponseFromJson(String str) =>
    OtpModelResponse.fromJson(json.decode(str));

String otpModelResponseToJson(OtpModelResponse data) =>
    json.encode(data.toJson());

class OtpModelResponse {
  bool? errors;
  String? message;
  Data? data;

  OtpModelResponse({
    this.errors,
    this.message,
    this.data,
  });

  OtpModelResponse copyWith({
    bool? errors,
    String? message,
    Data? data,
  }) =>
      OtpModelResponse(
        errors: errors ?? this.errors,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory OtpModelResponse.fromJson(Map<String, dynamic> json) =>
      OtpModelResponse(
        errors: json["errors"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "errors": errors,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  bool? verified;
  Token? token;
  User? user;

  Data({
    this.verified,
    this.token,
    this.user,
  });

  Data copyWith({
    bool? verified,
    Token? token,
    User? user,
  }) =>
      Data(
        verified: verified ?? this.verified,
        token: token ?? this.token,
        user: user ?? this.user,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        verified: json["verified"],
        token: json["token"] == null ? null : Token.fromJson(json["token"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
        "token": token?.toJson(),
        "user": user?.toJson(),
      };
}

class Token {
  AccessToken? accessToken;
  String? plainTextToken;

  Token({
    this.accessToken,
    this.plainTextToken,
  });

  Token copyWith({
    AccessToken? accessToken,
    String? plainTextToken,
  }) =>
      Token(
        accessToken: accessToken ?? this.accessToken,
        plainTextToken: plainTextToken ?? this.plainTextToken,
      );

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["accessToken"] == null
            ? null
            : AccessToken.fromJson(json["accessToken"]),
        plainTextToken: json["plainTextToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken?.toJson(),
        "plainTextToken": plainTextToken,
      };
}

class AccessToken {
  String? name;
  List<String>? abilities;
  dynamic expiresAt;
  int? tokenableId;
  String? tokenableType;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  AccessToken({
    this.name,
    this.abilities,
    this.expiresAt,
    this.tokenableId,
    this.tokenableType,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  AccessToken copyWith({
    String? name,
    List<String>? abilities,
    dynamic expiresAt,
    int? tokenableId,
    String? tokenableType,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      AccessToken(
        name: name ?? this.name,
        abilities: abilities ?? this.abilities,
        expiresAt: expiresAt ?? this.expiresAt,
        tokenableId: tokenableId ?? this.tokenableId,
        tokenableType: tokenableType ?? this.tokenableType,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
        name: json["name"],
        abilities: json["abilities"] == null
            ? []
            : List<String>.from(json["abilities"]!.map((x) => x)),
        expiresAt: json["expires_at"],
        tokenableId: json["tokenable_id"],
        tokenableType: json["tokenable_type"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "abilities": abilities == null
            ? []
            : List<dynamic>.from(abilities!.map((x) => x)),
        "expires_at": expiresAt,
        "tokenable_id": tokenableId,
        "tokenable_type": tokenableType,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

class User {
  int? id;
  int? roleId;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? birthday;
  String? phone;
  dynamic emailVerifiedAt;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.roleId,
    this.firstName,
    this.lastName,
    this.email,
    this.birthday,
    this.phone,
    this.emailVerifiedAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    int? roleId,
    String? firstName,
    String? lastName,
    String? email,
    DateTime? birthday,
    String? phone,
    dynamic emailVerifiedAt,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        roleId: roleId ?? this.roleId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        phone: phone ?? this.phone,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        roleId: json["role_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "birthday":
            "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        "phone": phone,
        "email_verified_at": emailVerifiedAt,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
