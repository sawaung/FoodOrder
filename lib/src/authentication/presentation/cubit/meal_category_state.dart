part of 'meal_category_cubit.dart';

sealed class MealCategoryState extends Equatable {
  const MealCategoryState();

  @override
  List<Object> get props => [];
}

final class MealCategoryInitial extends MealCategoryState {
  const MealCategoryInitial();
}

final class MealCategoryError extends MealCategoryState {
  const MealCategoryError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

// State for MealCategory
final class GetMealCategoriesLoading extends MealCategoryState {
  const GetMealCategoriesLoading();
}

final class GetMealCategoriesLoaded extends MealCategoryState {
  const GetMealCategoriesLoaded(this.category);

  final List<MealCategory> category;

  @override
  List<Object> get props => category.map((e) => {e.idCategory}).toList();
}

final class GetMealCategoriesError extends MealCategoryError {
  const GetMealCategoriesError(super.message);
}

