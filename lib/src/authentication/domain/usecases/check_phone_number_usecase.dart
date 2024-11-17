import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/failure.dart';
import 'package:flutter_tdd/core/usecase/usecase.dart';
import 'package:flutter_tdd/core/util/typedef.dart';
import 'package:flutter/foundation.dart';

class ValidatePhoneNumberUseCase  extends UseCaseWithParams<bool,String>{
  @override
  ResultFuture<bool> call(String param) async {
     try {
       final regex = RegExp(r'^(099|99)\d{8}$');
       bool valid = regex.hasMatch(param);
       debugPrint("_log valid phone $valid");
      return Right(valid);
    }on ValidPhoneNumberFail catch(e){
      return Left(ValidPhoneNumberFail(message: e.toString()));
    }
  }
}