class PaymentDetailModel {
  bool? success;
  String? message;
  PaymentData? data;

  PaymentDetailModel({this.success, this.message, this.data});

  PaymentDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? PaymentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PaymentData {
  String? paymentUrl;
  Transaction? transaction;

  PaymentData({this.paymentUrl, this.transaction});

  PaymentData.fromJson(Map<String, dynamic> json) {
    paymentUrl = json['payment_url'];
    transaction = json['transaction'] != null
        ? Transaction.fromJson(json['transaction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_url'] = paymentUrl;
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
    return data;
  }
}

class Transaction {
  int? id;
  int? userId;
  int? cartId;
  int? paymentId;
  int? courierId;
  int? addressId;
  String? status;
  int? amount;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Transaction({
    this.id,
    this.userId,
    this.cartId,
    this.paymentId,
    this.courierId,
    this.addressId,
    this.status,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cartId = json['cart_id'];
    paymentId = json['payment_id'];
    courierId = json['courier_id'];
    addressId = json['address_id'];
    status = json['status'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['cart_id'] = cartId;
    data['payment_id'] = paymentId;
    data['courier_id'] = courierId;
    data['address_id'] = addressId;
    data['status'] = status;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
