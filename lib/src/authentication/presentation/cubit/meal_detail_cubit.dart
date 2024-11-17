import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_detail.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/get_meal_detail.dart';
import 'package:flutter/foundation.dart';

part 'meal_detail_state.dart';

class MealDetailCubit extends Cubit<MealDetailState> {
  MealDetailCubit(
    {required GetMealDetailUseCase getMealDetailUseCase})
      : _getMealDetailUseCase = getMealDetailUseCase,
        super(const MealDetailStateInitial());

  final GetMealDetailUseCase _getMealDetailUseCase;

  Future<void> getMealDetail(String mealId) async {
    debugPrint("_log mealId $mealId");
    emit(const MealDetailLoading());
    final result = await _getMealDetailUseCase(mealId);

    result.fold(
            (failure) => emit(MealDetailStateError(failure.errorMessage)),
            (success) async{ emit(MealDetailLoaded(success));});
  }


}
