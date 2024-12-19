class OngoingResponse {
  final List<Transaction> data;
  final String message;
  final bool success;

  OngoingResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  factory OngoingResponse.fromJson(Map<String, dynamic> json) {
    return OngoingResponse(
      data: (json['data'] as List<dynamic>)
          .map((item) => Transaction.fromJson(item as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String,
      success: json['success'] as bool,
    );
  }
}

class Transaction {
  final int id;
  final int userId;
  final int cartId;
  final int paymentId;
  final int courierId;
  final int addressId;
  final String status;
  final int amount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Transaction({
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
    this.deletedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      cartId: json['cart_id'] as int,
      paymentId: json['payment_id'] as int,
      courierId: json['courier_id'] as int,
      addressId: json['address_id'] as int,
      status: json['status'] as String,
      amount: json['amount'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: (json['deleted_at'] as String) != "0001-01-01T00:00:00Z"
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
    );
  }
}
