class FinishTransactionModel {
  final int id;
  final int userId;
  final int cartId;
  final int paymentId;
  final int courierId;
  final int addressId;
  final String status;
  final double amount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deletedAt;

  FinishTransactionModel({
    required this.id,
    required this.userId,
    required this.cartId,
    required this.paymentId,
    required this.courierId,
    required this.addressId,
    required this.status,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  // Factory method to create FinishTransactionModel from JSON
  factory FinishTransactionModel.fromJson(Map<String, dynamic> json) {
    return FinishTransactionModel(
      id: json['id'],
      userId: json['user_id'],
      cartId: json['cart_id'],
      paymentId: json['payment_id'],
      courierId: json['courier_id'],
      addressId: json['address_id'],
      status: json['status'],
      amount: json['amount'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: DateTime.parse(json['deleted_at']),
    );
  }

  // Method to convert FinishTransactionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'cart_id': cartId,
      'payment_id': paymentId,
      'courier_id': courierId,
      'address_id': addressId,
      'status': status,
      'amount': amount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt.toIso8601String(),
    };
  }
}

class FinishTransactionResponseModel {
  final List<FinishTransactionModel> data; // Changed to List of FinishTransactionModel
  final String message;
  final bool success;

  FinishTransactionResponseModel({
    required this.data,
    required this.message,
    required this.success,
  });

  // Factory method to create FinishTransactionResponseModel from JSON
  factory FinishTransactionResponseModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<FinishTransactionModel> transactionList =
        list.map((i) => FinishTransactionModel.fromJson(i)).toList();

    return FinishTransactionResponseModel(
      data: transactionList,
      message: json['message'],
      success: json['success'],
    );
  }

  // Method to convert FinishTransactionResponseModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
      'success': success,
    };
  }
}
