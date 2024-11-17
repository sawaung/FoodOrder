part of 'meal_cubit.dart';

sealed class MealState extends Equatable {
  const MealState();

  @override
  List<Object> get props => [];
}

final class MealInitial extends MealState {
  const MealInitial();
}

final class MealError extends MealState {
  const MealError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

// State for Meal
final class GetMealByCategoryLoading extends MealState {
  const GetMealByCategoryLoading();
}

final class GetMealByCategoryLoaded extends MealState {
  const GetMealByCategoryLoaded(this.meal);

  final List<Meal> meal;

  @override
  List<Object> get props => meal.map((e) => {e.idMeal}).toList();
}

final class GetMealByCategoryError extends MealError {
  const GetMealByCategoryError(super.message);
}


final class GetMealCategoriesError extends MealError {
  const GetMealCategoriesError(super.message);
}

