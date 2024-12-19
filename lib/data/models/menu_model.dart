class MenuModel {
  bool? status;
  String? message;
  MenuDataContainer? data;

  MenuModel({this.status, this.message, this.data});

  MenuModel.fromJson(Map<String, dynamic> json) {
    status = json['success']; // Align with "success" in the JSON
    message = json['message'];
    data = json['data'] != null ? MenuDataContainer.fromJson(json['data']) : null;
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

class MenuDataContainer {
  List<MenuData>? menus;
  String? nextCursor;

  MenuDataContainer({this.menus, this.nextCursor});

  MenuDataContainer.fromJson(Map<String, dynamic> json) {
    if (json['menus'] != null) {
      menus = <MenuData>[];
      json['menus'].forEach((v) {
        menus!.add(MenuData.fromJson(v));
      });
    }
    nextCursor = json['nextCursor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (menus != null) {
      data['menus'] = menus!.map((v) => v.toJson()).toList();
    }
    data['nextCursor'] = nextCursor;
    return data;
  }
}

class MenuData {
  int? id;
  String? title;
  String? description;
  int? price;
  String? image;
  Nutrition? nutrition;
  Features? features;
  String? createdAt;
  String? updatedAt;

  MenuData({
    this.id,
    this.title,
    this.description,
    this.price,
    this.image,
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
    image = json['image_url'];
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
    data['image_url'] = image;
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
  bool? highProtein;

  Features({this.vegetarian, this.glutenFree, this.highProtein});

  Features.fromJson(Map<String, dynamic> json) {
    vegetarian = json['vegetarian'];
    glutenFree = json['gluten_free'];
    highProtein = json['high_protein'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vegetarian'] = vegetarian;
    data['gluten_free'] = glutenFree;
    data['high_protein'] = highProtein;
    return data;
  }
}
