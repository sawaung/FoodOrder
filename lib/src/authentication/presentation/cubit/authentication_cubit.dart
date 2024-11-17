import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/check_phone_number_usecase.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({ required ValidatePhoneNumberUseCase validatePhoneNumberUseCase})
      : 
        _validatePhoneNumberUseCase = validatePhoneNumberUseCase,
        super(const AuthenticationInitial());


  final ValidatePhoneNumberUseCase _validatePhoneNumberUseCase;

  Future<void> validatePhoneNumber(String phoneNumber) async {
    final isValid = await _validatePhoneNumberUseCase(phoneNumber);
    isValid.fold(
            (failure) => emit(AuthenticationError(failure.errorMessage)),
            (success) => emit(PhoneNumberValidationState(success)));
  }
}
