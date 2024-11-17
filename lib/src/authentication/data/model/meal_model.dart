import 'dart:convert';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';

class MealModel extends Meal {
  const MealModel(
    {required super.idMeal,
    required super.strMeal,
    required super.strMealThumb,
    });

  const MealModel.fake() : this(
    idMeal: "52959",
    strMeal:  "Baked salmon with fennel & tomatoes",
    strMealThumb: "https://www.themealdb.com/images/media/meals/1548772327.jpg",
  );

  factory MealModel.fromJson(String source) =>
      MealModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  MealModel.fromMap(Map<String, dynamic> map)
      : this(
            strMeal: map['strMeal'] as String,
            strMealThumb: map['strMealThumb'] as String,
            idMeal: map['idMeal'] as String);


  Map<String, dynamic> toMap() =>
      {'idMeal': idMeal, 'strMealThumb': strMealThumb,'strMeal': strMeal };

  //String toJson() => jsonEncode(toMap());

  MealModel copyWith(
      {String? idMeal, String? strMealThumb, String? strMeal}) {
    return MealModel(
        idMeal: idMeal ?? this.idMeal,
        strMealThumb: strMealThumb ?? this.strMealThumb,
        strMeal: idMeal ?? this.idMeal);
  }
}
