import 'package:equatable/equatable.dart';
import 'package:flutter_tdd/core/error/exception.dart';

abstract class Failure extends Equatable{
  const Failure({required this.message, required this.statusCode});
  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message,statusCode];

  String get errorMessage => "$statusCode Error : $message";
}

class APIFailure extends Failure{
  const APIFailure({required super.message, required super.statusCode});
  APIFailure.fromException(APIException e) : this(
    message: e.message,
    statusCode: e.statusCode
  );
}

class ValidPhoneNumberFail extends Failure{
  const ValidPhoneNumberFail({required super.message, super.statusCode = 11});
  ValidPhoneNumberFail.fromException(APIException e) : this(
    message: e.message,
    statusCode: e.statusCode
  );
}

class StorageFailure extends Failure{
  const StorageFailure({required super.message, required super.statusCode});
  StorageFailure.fromException(StorageException e) : this(
    message: e.message,
    statusCode: e.statusCode
  );
}