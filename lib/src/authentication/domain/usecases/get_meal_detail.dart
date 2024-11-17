import 'package:flutter_tdd/core/usecase/usecase.dart';
import 'package:flutter_tdd/core/util/typedef.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_detail.dart';
import 'package:flutter_tdd/src/authentication/domain/repository/meal_repo.dart';

class GetMealDetailUseCase extends UseCaseWithParams<MealDetail,String>{

  const GetMealDetailUseCase(this._mealRepo);
  final MealRepo _mealRepo;

  @override
  ResultFuture<MealDetail> call(String param) {
    return _mealRepo.getMealDetail(mealId: param);
  }
}