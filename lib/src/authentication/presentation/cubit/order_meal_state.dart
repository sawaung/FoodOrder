part of 'order_meal_cubit.dart';

sealed class OrderMealState extends Equatable {
  const OrderMealState();

  @override
  List<Object> get props => [];
}

final class OrderMealInitial extends OrderMealState {
  const OrderMealInitial();
}

final class OrderMealError extends OrderMealState {
  const OrderMealError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

final class GetOrderMealLoading extends OrderMealState {
  const GetOrderMealLoading();
}

final class GetOrderMealLoaded extends OrderMealState {
  const GetOrderMealLoaded(this.meal);

  final List<Meal> meal;

  @override
  List<Object> get props => meal.map((e) => {e.idMeal}).toList();
}

