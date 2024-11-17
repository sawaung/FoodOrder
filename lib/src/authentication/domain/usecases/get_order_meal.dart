import 'package:flutter_tdd/core/usecase/usecase.dart';
import 'package:flutter_tdd/core/util/typedef.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';
import 'package:flutter_tdd/src/authentication/domain/repository/meal_repo.dart';

class GetOrderMealUseCase extends UseCaseWithoutParams<List<Meal>>{
  const GetOrderMealUseCase(this._mealRepo);
  final MealRepo _mealRepo;

  @override
  ResultFuture<List<Meal>> call() async {
    return _mealRepo.getOrderMeal();
  }
}