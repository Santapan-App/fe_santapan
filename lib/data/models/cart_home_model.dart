class CartHomeModel {
  bool? status;
  String? message;
  CartDataContainer? data;

  CartHomeModel({this.status, this.message, this.data});

  CartHomeModel.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    message = json['message'];
    data = json['data'] != null ? CartDataContainer.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CartDataContainer {
  int? totalAmount;
  int? totalQuantity;

  CartDataContainer({this.totalAmount});

  CartDataContainer.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    totalQuantity = json['total_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_amount'] = totalAmount;
    data['total_quantity'] = totalQuantity;
    return data;
  }
}
