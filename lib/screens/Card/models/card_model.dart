class CardsResponse {
  final List<CardModel> data;

  CardsResponse({required this.data});

  factory CardsResponse.fromJson(Map<String, dynamic> json) {
    return CardsResponse(
      data: (json['data'] as List<dynamic>)
          .map((item) => CardModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((card) => card.toJson()).toList(),
    };
  }
}

class CardModel {
  final String uuid;
  final bool isDefault;
  final String name;
  final String system;
  final String icon;
  final String pan;
  final String cardholder;
  final String expiration;
  final String createdAt;
  final String updatedAt;

  CardModel({
    required this.uuid,
    required this.isDefault,
    required this.name,
    required this.system,
    required this.icon,
    required this.pan,
    required this.cardholder,
    required this.expiration,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      uuid: json['uuid'],
      isDefault: json['isDefault'],
      name: json['name'],
      system: json['system'],
      icon: json['icon'],
      pan: json['pan'],
      cardholder: json['cardholder'],
      expiration: json['expiration'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'isDefault': isDefault,
      'name': name,
      'system': system,
      'icon': icon,
      'pan': pan,
      'cardholder': cardholder,
      'expiration': expiration,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
