import 'package:flutter_tdd/core/usecase/usecase.dart';
import 'package:flutter_tdd/core/util/typedef.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';
import 'package:flutter_tdd/src/authentication/domain/repository/meal_repo.dart';

class GetMealByCategoryIdUseCase extends UseCaseWithParams<List<Meal>,String>{

  const GetMealByCategoryIdUseCase(this._mealRepo);
  final MealRepo _mealRepo;

  @override
  ResultFuture<List<Meal>> call(String param) {
    return _mealRepo.getMealByCategoryId(categoryId: param);
  }
}