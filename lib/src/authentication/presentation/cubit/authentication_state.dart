part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

final class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

final class PhoneNumberValidationState extends AuthenticationState  {
 final bool validatePhoneNumber;
  const PhoneNumberValidationState(this.validatePhoneNumber);
  @override
  List<bool> get props => [validatePhoneNumber]; 
}

