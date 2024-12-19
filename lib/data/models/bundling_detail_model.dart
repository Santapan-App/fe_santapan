class BundlingDetailModel {
  bool? success;
  String? message;
  BundlingData? data;

  BundlingDetailModel({this.success, this.message, this.data});

  BundlingDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? BundlingData.fromJson(json['data']) : null;
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

class BundlingData {
  int? id;
  String? bundlingName;
  String? bundlingType;
  String? imageUrl;
  int? price;
  String? createdAt;
  String? updatedAt;

  BundlingData({this.id, this.bundlingType, this.price, this.createdAt, this.updatedAt});

  BundlingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bundlingName = json['bundling_name'];
    imageUrl = json['image_url'];
    bundlingType = json['bundling_type'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bundling_name'] = bundlingName;
    data['image_url'] = imageUrl;
    data['bundling_type'] = bundlingType;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
