part of 'meal_detail_cubit.dart';

sealed class MealDetailState extends Equatable {
  const MealDetailState();

  @override
  List<Object> get props => [];
}

final class MealDetailStateInitial extends MealDetailState {
  const MealDetailStateInitial();
}

final class MealDetailStateError extends MealDetailState {
  const MealDetailStateError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

// State for MealCategory
final class MealDetailLoading extends MealDetailState {
  const MealDetailLoading();
}

final class MealDetailLoaded extends MealDetailState {
  const MealDetailLoaded(this.mealDetail);

  final MealDetail mealDetail;

  @override
  List<MealDetail> get props => [mealDetail];
}



