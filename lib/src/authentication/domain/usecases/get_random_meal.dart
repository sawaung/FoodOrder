import 'package:flutter_tdd/core/usecase/usecase.dart';
import 'package:flutter_tdd/core/util/typedef.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_detail.dart';
import 'package:flutter_tdd/src/authentication/domain/repository/meal_repo.dart';

class GetRandomMealUseCase extends UseCaseWithoutParams<MealDetail>{
  const GetRandomMealUseCase(this._mealRepo);
  final MealRepo _mealRepo;

  @override
  ResultFuture<MealDetail> call() async {
    return _mealRepo.getRandomMealDetail();
  }
}