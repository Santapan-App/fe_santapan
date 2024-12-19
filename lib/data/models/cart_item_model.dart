class CartResponseModel {
  bool? success;
  String? message;
  CartData? data;

  CartResponseModel({this.success, this.message, this.data});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CartData.fromJson(json['data']) : null;
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

class CartData {
  Cart? cart;
  List<Item>? items;

  CartData({this.cart, this.items});

  CartData.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  int? id;
  int? userId;
  int? totalPrice;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  Cart({this.id, this.userId, this.totalPrice, this.createdAt, this.updatedAt});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    imageUrl = json['image_url'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['image_url'] = imageUrl;
    data['total_price'] = totalPrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Item {
  int? id;
  int? cartId;
  int? menuId;
  int? bundlingId;
  String? name;
  String? imageUrl;
  int? quantity;
  int? price;
  String? createdAt;
  String? updatedAt;

  Item({
    this.id,
    this.cartId,
    this.menuId,
    this.bundlingId,
    this.name,
    this.imageUrl,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    menuId = json['menu_id'];
    bundlingId = json['bundling_id'];
    imageUrl = json['image_url'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cart_id'] = cartId;
    data['menu_id'] = menuId;
    data['bundling_id'] = bundlingId;
    data['image_url'] = imageUrl;
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
