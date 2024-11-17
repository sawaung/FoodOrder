import 'package:flutter_tdd/core/usecase/usecase.dart';
import 'package:flutter_tdd/core/util/typedef.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_category.dart';
import 'package:flutter_tdd/src/authentication/domain/repository/meal_repo.dart';

class GetAllMealCategoryUseCase extends UseCaseWithoutParams<List<MealCategory>>{
  const GetAllMealCategoryUseCase(this._mealRepo);
  final MealRepo _mealRepo;

  @override
  ResultFuture<List<MealCategory>> call() async {
    return _mealRepo.getAllMealCategories();
  }
}