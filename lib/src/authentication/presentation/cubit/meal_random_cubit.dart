import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_detail.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/get_meal_detail.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/get_random_meal.dart';

part 'meal_random_state.dart';

class MealRandomCubit extends Cubit<MealRandomState> {
  MealRandomCubit(
    {required GetRandomMealUseCase getRandomMealUseCase})
      : _getRandomMealUseCase = getRandomMealUseCase,
        super(const MealRandomStateInitial());

  final GetRandomMealUseCase _getRandomMealUseCase;

  Future<void> getMealRandom() async {
    emit(const MealRandomLoading());
    final result = await _getRandomMealUseCase();

    result.fold(
            (failure) => emit(MealRandomStateError(failure.errorMessage)),
            (success) async{ emit(MealRandomLoaded(success));});
  }


}
