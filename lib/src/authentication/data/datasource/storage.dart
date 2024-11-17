import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/core/services/shared_pref.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';
import 'package:flutter/foundation.dart';

abstract class StorageDataSource{

  Future<List<Meal>> getOrderedMeal();
  
}

class StorageDataSourceImpl implements StorageDataSource{

  const StorageDataSourceImpl(this.storage);
  final Storage storage;

  @override
  Future<List<Meal>> getOrderedMeal() async{
    try {
      final response = await storage.getOrderMeal().then((value) => value);
      return response;
    } catch(e) {
      debugPrint("_log error -> ${e.toString()}");
      throw StorageException(message: e.toString(), statusCode: 01);
    }
  }
}
  
