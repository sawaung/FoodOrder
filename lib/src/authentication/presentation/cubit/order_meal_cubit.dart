import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/get_order_meal.dart';

part 'order_meal_state.dart';

class OrderMealCubit extends Cubit<OrderMealState> {
  OrderMealCubit(
    {required GetOrderMealUseCase getOrderMealUseCase})
      : _getOrderMealUseCase = getOrderMealUseCase,
        super(const OrderMealInitial());

  final GetOrderMealUseCase _getOrderMealUseCase;

  Future<void> getOrderMeal() async {
    emit(const GetOrderMealLoading());
    final result = await _getOrderMealUseCase();

    result.fold(
            (failure) => emit(OrderMealError(failure.errorMessage)),
            (success) async{ emit(GetOrderMealLoaded(success));});
  }


}
