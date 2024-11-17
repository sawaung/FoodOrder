import 'package:flutter_tdd/core/util/typedef.dart';

abstract class UseCaseWithParams<T,Params>{//declaration<Type,Parameter> 
  const UseCaseWithParams();
  ResultFuture<T> call(Params param);//higher order function return<ResultFuture<String>>
}

abstract class UseCaseWithoutParams<Type>{//declaration
  const UseCaseWithoutParams();
  ResultFuture<Type> call();
}