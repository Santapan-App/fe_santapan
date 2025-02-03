class ArticleModel {
  bool? status;
  String? message;
  List<ArticleData>? articles; // Change 'data' to 'articles'
  String? nextCursor; // Add nextCursor

  ArticleModel({this.status, this.message, this.articles, this.nextCursor});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    status = json['success']; // Assuming API uses "success" for status
    message = json['message'];
    nextCursor = json['data']['nextCursor']; // Get the nextCursor value
    if (json['data']['articles'] != null) {  // Change 'data' to 'articles'
      articles = <ArticleData>[];
      json['data']['articles'].forEach((v) {
        articles!.add(ArticleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = status;
    data['message'] = message;
    if (articles != null) {
      data['data'] = {
        'articles': articles!.map((v) => v.toJson()).toList(),
        'nextCursor': nextCursor
      };
    }
    return data;
  }
}

class ArticleData {
  int? id;
  String? title;
  String? content;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  ArticleData({
    this.id,
    this.title,
    this.content,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  ArticleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? DateTime.parse(json['updated_at'])
        : null;
    deletedAt = json['deleted_at'] != null
        ? DateTime.parse(json['deleted_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['image_url'] = imageUrl;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    data['deleted_at'] = deletedAt?.toIso8601String();
    return data;
  }
}
