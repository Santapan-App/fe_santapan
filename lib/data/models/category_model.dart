class CategoryModel {
  bool? status;
  String? message;
  CategoryDataContainer? data;

  CategoryModel({this.status, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    print(json);
    status = json['success']; // Align with "success" in the JSON
    message = json['message'];
    data = json['data'] != null ? CategoryDataContainer.fromJson(json['data']) : null;
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

class CategoryDataContainer {
  List<CategoryData>? categories;
  String? nextCursor;

  CategoryDataContainer({this.categories, this.nextCursor});

  CategoryDataContainer.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <CategoryData>[];
      json['categories'].forEach((v) {
        categories!.add(CategoryData.fromJson(v));
      });
    }
    nextCursor = json['nextCursor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    data['nextCursor'] = nextCursor;
    return data;
  }
}

class CategoryData {
  int? id;
  String? title;
  String? image;
  String? createdAt;
  String? updatedAt;

  CategoryData({this.id, this.title, this.image, this.createdAt, this.updatedAt});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image_url']; // Correct field mapping
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
