class MenuDetailModel {
  bool? success;
  String? message;
  MenuData? data;

  MenuDetailModel({this.success, this.message, this.data});

  MenuDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? MenuData.fromJson(json['data']) : null;
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

class MenuData {
  int? id;
  String? title;
  String? description;
  int? price;
  String? imageUrl;
  Nutrition? nutrition;
  Features? features;
  String? createdAt;
  String? updatedAt;

  MenuData({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.nutrition,
    this.features,
    this.createdAt,
    this.updatedAt,
  });

  MenuData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    imageUrl = json['image_url'];
    nutrition = json['nutrition'] != null ? Nutrition.fromJson(json['nutrition']) : null;
    features = json['features'] != null ? Features.fromJson(json['features']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['image_url'] = imageUrl;
    if (nutrition != null) {
      data['nutrition'] = nutrition!.toJson();
    }
    if (features != null) {
      data['features'] = features!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Nutrition {
  int? fat;
  int? protein;
  int? calories;

  Nutrition({this.fat, this.protein, this.calories});

  Nutrition.fromJson(Map<String, dynamic> json) {
    fat = json['fat'];
    protein = json['protein'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fat'] = fat;
    data['protein'] = protein;
    data['calories'] = calories;
    return data;
  }
}

class Features {
  bool? vegetarian;
  bool? glutenFree;

  Features({this.vegetarian, this.glutenFree});

  Features.fromJson(Map<String, dynamic> json) {
    vegetarian = json['vegetarian'];
    glutenFree = json['gluten_free'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vegetarian'] = vegetarian;
    data['gluten_free'] = glutenFree;
    return data;
  }
}
