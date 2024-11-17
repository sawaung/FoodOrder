import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/core/error/failure.dart';
import 'package:flutter_tdd/core/util/typedef.dart';
import 'package:flutter_tdd/src/authentication/data/datasource/remote.dart';
import 'package:flutter_tdd/src/authentication/data/datasource/storage.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_category.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_detail.dart';
import 'package:flutter_tdd/src/authentication/domain/repository/meal_repo.dart';

class MealRepoImpl extends MealRepo{

  const MealRepoImpl(this._mealDataSource,this._storageDataSource);

  final MealDataSource _mealDataSource;
  final StorageDataSource _storageDataSource;


  @override
  ResultFuture<List<MealCategory>> getAllMealCategories() async{
    try {
      final result = await _mealDataSource.getAllMealCategories();
      return Right(result);
    }on APIException catch(e){
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Meal>> getMealByCategoryId({required String categoryId}) async{
     try {
      final result = await _mealDataSource.getMealByCategory(categoryId);
      return Right(result);
    }on APIException catch(e){
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<MealDetail> getMealDetail({required String mealId})async {
    try {
      final result = await _mealDataSource.getMealDetail(mealId);
      return Right(result);
    }on APIException catch(e){
      return Left(APIFailure.fromException(e));
    }
  }
  
  @override
  ResultFuture<MealDetail> getRandomMealDetail()async {
    try {
      final result = await _mealDataSource.getRandomMealDetail();
      return Right(result);
    }on APIException catch(e){
      return Left(APIFailure.fromException(e));
    }
  }
  
  @override
  ResultFuture<List<Meal>> getOrderMeal() async{
    try {
      final result = await _storageDataSource.getOrderedMeal();
      return Right(result);
    }on StorageException catch(e){
      return Left(StorageFailure.fromException(e));
    }
  }

}