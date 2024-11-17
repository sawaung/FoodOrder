import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_category.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/get_all_meal_category.dart';

part 'meal_category_state.dart';

class MealCategoryCubit extends Cubit<MealCategoryState> {
  MealCategoryCubit(
    {required GetAllMealCategoryUseCase getAllMealCategoryUseCase})
      : _getAllMealCategoryUseCase = getAllMealCategoryUseCase,
        super(const MealCategoryInitial());

  final GetAllMealCategoryUseCase _getAllMealCategoryUseCase;

  List<MealCategory> lstCategory = [];

  Future<void> getAllMealCategory() async {
    emit(const GetMealCategoriesLoading());
    final result = await _getAllMealCategoryUseCase();

    result.fold(
            (failure) => emit(GetMealCategoriesError(failure.errorMessage)),
            (success) async {
              emit(GetMealCategoriesLoaded(success));});
  }
}
