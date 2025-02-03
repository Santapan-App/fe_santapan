class TransactionDetail {
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

  TransactionDetail({
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

  factory TransactionDetail.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};  // Handle the nested 'data' field
    return TransactionDetail(
      id: data['id'] as int,
      userId: data['user_id'] as int,
      cartId: data['cart_id'] as int,
      paymentId: data['payment_id'] as int,
      courierId: data['courier_id'] as int,
      addressId: data['address_id'] as int,
      status: data['status'] as String,
      amount: data['amount'] as int,
      createdAt: DateTime.parse(data['created_at'] as String),
      updatedAt: DateTime.parse(data['updated_at'] as String),
      deletedAt: (data['deleted_at'] == "0001-01-01T00:00:00Z" || data['deleted_at'] == null)
          ? null
          : DateTime.parse(data['deleted_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
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
        'deleted_at': deletedAt?.toIso8601String() ?? "0001-01-01T00:00:00Z",
      }
    };
  }
}
