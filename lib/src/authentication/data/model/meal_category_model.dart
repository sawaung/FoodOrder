import 'dart:convert';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_category.dart';

class MealCategoryModel extends MealCategory {
  const MealCategoryModel(
      {required super.idCategory,
      required super.strCategory,
      required super.strCategoryThumb,
      required super.strCategoryDescription});

  const MealCategoryModel.fake()
      : this(
            idCategory: '1',
    strCategory: 'Chicken',
    strCategoryThumb: "https://www.themealdb.com/images/category/chicken.png",
    strCategoryDescription: 'Chicken is a type of domesticated fowl, a subspecies of the red junglefowl. It is one of the most common and widespread domestic animals, with a total population of more than 19 billion as of 2011.[1] Humans commonly keep chickens as a source of food (consuming both their meat and eggs) and, more rarely, as pets.'
);

  // Json -> JsonDecode() -> Map -> Model
  // Model -> Map -> JsonEncode -> Json
  //Json String -> Model
  factory MealCategoryModel.fromJson(String source) =>
      MealCategoryModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  //Model Map -> Model
  MealCategoryModel.fromMap(Map<String, dynamic> map)
      : this(
            idCategory: map['idCategory'] as String,
            strCategory: map['strCategory'] as String,
            strCategoryThumb: map['strCategoryThumb'] as String,
            strCategoryDescription: map['strCategoryDescription'] as String);

  //Model object to Model Map
  Map<String, dynamic> toMap() =>
      {'idCategory': idCategory, 'strCategory': strCategory,'strCategoryThumb': strCategoryThumb,'strCategoryDescription': strCategoryDescription };

  String toJson() => jsonEncode(toMap());

  MealCategoryModel copyWith(
      {String? idCategory, String? strCategory, String? strCategoryThumb, String? strCategoryDescription}) {
    return MealCategoryModel(
        idCategory: idCategory ?? this.idCategory,
        strCategory: strCategory ?? this.strCategory,
        strCategoryThumb: strCategoryThumb ?? this.strCategoryThumb,
        strCategoryDescription: strCategoryDescription ?? this.strCategoryDescription);
  }
}
