
import 'package:flutter_tdd/core/util/typedef.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_category.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_detail.dart';

abstract class MealRepo{
  const MealRepo();

  ResultFuture<List<MealCategory>> getAllMealCategories();
  ResultFuture<List<Meal>> getMealByCategoryId({required String categoryId});
  ResultFuture<MealDetail> getMealDetail({required String mealId});
  ResultFuture<MealDetail> getRandomMealDetail();
  ResultFuture<List<Meal>> getOrderMeal();

}