class CourierDetailModel {
  final Courier courier;

  CourierDetailModel({required this.courier});

  factory CourierDetailModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {}; // Handle the nested 'data' field
    return CourierDetailModel(
      courier: Courier.fromJson(data['courier']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'courier': courier.toJson(),
      }
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
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
      price: json['price'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
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
