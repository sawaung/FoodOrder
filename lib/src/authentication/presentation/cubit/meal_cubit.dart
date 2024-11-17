import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_category.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/get_all_meal_category.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/get_meal_by_category_id.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit(
    {required GetAllMealCategoryUseCase getAllMealCategoryUseCase, 
    required GetMealByCategoryIdUseCase getMealByCategoryIdUseCase})
      : _getAllMealCategoryUseCase = getAllMealCategoryUseCase,
        _getMealByCategoryIdUseCase = getMealByCategoryIdUseCase,
        super(const MealInitial());

  final GetAllMealCategoryUseCase _getAllMealCategoryUseCase;
  final GetMealByCategoryIdUseCase _getMealByCategoryIdUseCase;

  List<MealCategory> lstCategory = [];


  Future<void> getMealByCategoryId(String categoryId) async {
    debugPrint("_log categoryId $categoryId");
    emit(const GetMealByCategoryLoading());
    final result = await _getMealByCategoryIdUseCase(categoryId);

    result.fold(
            (failure) => emit(GetMealByCategoryError(failure.errorMessage)),
            (success) async{ emit(GetMealByCategoryLoaded(success));});
  }


}
