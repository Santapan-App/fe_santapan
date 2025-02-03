import 'dart:convert';

class CourierResponse {
  final List<Courier> couriers;
  final String message;
  final bool success;

  CourierResponse({
    required this.couriers,
    required this.message,
    required this.success,
  });

  factory CourierResponse.fromJson(Map<String, dynamic> json) {
    return CourierResponse(
      couriers: List<Courier>.from(json['data']['couriers'].map((item) => Courier.fromJson(item))),
      message: json['message'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'couriers': couriers.map((courier) => courier.toJson()).toList(),
      },
      'message': message,
      'success': success,
    };
  }
}

class Courier {
  final int id;
  final String name;
  final String logo;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;

  Courier({
    required this.id,
    required this.name,
    required this.logo,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Courier.fromJson(Map<String, dynamic> json) {
    return Courier(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      price: json['price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}