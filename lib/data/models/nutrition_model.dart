class NutritionModel {
  final int id;
  final String foodName;
  final int calories;
  final int protein;
  final int fat;
  final int carbohydrates;
  final int sugar;

  NutritionModel({
    required this.id,
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbohydrates,
    required this.sugar,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json) {
    return NutritionModel(
      id: json['data']['id'],
      foodName: json['data']['food_name'],
      calories: json['data']['calories'],
      protein: json['data']['protein'],
      fat: json['data']['fat'],
      carbohydrates: json['data']['carbohydrates'],
      sugar: json['data']['sugar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food_name': foodName,
      'calories': calories,
      'protein': protein,
      'fat': fat,
      'carbohydrates': carbohydrates,
      'sugar': sugar,
    };
  }
}
