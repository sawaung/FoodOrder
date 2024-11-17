part of 'meal_random_cubit.dart';

sealed class MealRandomState extends Equatable {
  const MealRandomState();

  @override
  List<Object> get props => [];
}

final class MealRandomStateInitial extends MealRandomState {
  const MealRandomStateInitial();
}

final class MealRandomStateError extends MealRandomState {
  const MealRandomStateError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

// State for MealCategory
final class MealRandomLoading extends MealRandomState {
  const MealRandomLoading();
}

final class MealRandomLoaded extends MealRandomState {
  const MealRandomLoaded(this.mealDetail);

  final MealDetail mealDetail;

  @override
  List<MealDetail> get props => [mealDetail];
}



