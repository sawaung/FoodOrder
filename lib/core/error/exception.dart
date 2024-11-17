import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception{
  const ServerException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [statusCode,message];
}

class APIException extends ServerException{
  const APIException({required super.message, required super.statusCode});
}

//create DataBaseException
class StorageException extends Equatable implements Exception{
  const StorageException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [statusCode,message];
}





