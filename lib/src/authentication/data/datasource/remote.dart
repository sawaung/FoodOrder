import 'dart:convert';

import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/core/util/constant.dart';
import 'package:flutter_tdd/src/authentication/data/model/meal_category_model.dart';
import 'package:flutter_tdd/src/authentication/data/model/meal_detail_model.dart';
import 'package:flutter_tdd/src/authentication/data/model/meal_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

abstract class MealDataSource{

  Future<List<MealCategoryModel>> getAllMealCategories();
  Future<List<MealModel>> getMealByCategory(String categoryId);
  Future<MealDetailModel> getMealDetail(String mealId);
  Future<MealDetailModel> getRandomMealDetail();
  
}

const kGetAllMealCategoriesEndPoint = "/api/json/v1/1/categories.php";
const kGetMealByCategory = "/api/json/v1/1/filter.php";
const kGetMealDetail = "/api/json/v1/1/lookup.php";
const kGetRandomMealDetail = "/api/json/v1/1/random.php";

class MealDataSourceImpl implements MealDataSource{

  const MealDataSourceImpl(this.httpClient);
  final http.Client httpClient;

  @override
  Future<List<MealCategoryModel>> getAllMealCategories() async{
    try {
      final response = await httpClient.get(Uri.https(kBaseUrl,kGetAllMealCategoriesEndPoint));
      if(response.statusCode != 200){
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      //convert JsonString to Map<String,dynamic>
      var jsonReturn = jsonDecode(response.body);
      //get categories from Map<String,dynamic>
      var categories = jsonReturn['categories'] as List;

      //List<String> -> List<Map<String,dyanmic> -> List<MealCategoryModel>
      return List<Map<String,dynamic>>.from(categories)
          .map((mealCategory) => MealCategoryModel.fromMap(mealCategory)).toList();

    } on APIException{
      rethrow;
    }catch(e) {
      debugPrint("_log error -> ${e.toString()}");
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<MealModel>>getMealByCategory(String categoryId) async{
    
    try {
      final queryParameters = {
        'c' : categoryId
      };
      final response = await httpClient.get(Uri.https(kBaseUrl,kGetMealByCategory,queryParameters));
      if(response.statusCode != 200){
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      //convert JsonString to Map<String,dynamic>
      var jsonReturn = jsonDecode(response.body);
      //get categories from Map<String,dynamic>
      var lstMeal = jsonReturn['meals'] as List;

      //List<String> -> List<Map<String,dyanmic> -> List<MealModel>
      return List<Map<String,dynamic>>.from(lstMeal)
          .map((meal) => MealModel.fromMap(meal)).toList();

    } on APIException{
      rethrow;
    }catch(e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<MealDetailModel> getMealDetail(String mealId) async{
    try {
      final queryParameters = {
        'i' : mealId
      };

      final response = await httpClient.get(Uri.https(kBaseUrl,kGetMealDetail,queryParameters));
      if(response.statusCode != 200){
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      //convert JsonString to Map<String,dynamic>
      var jsonReturn = jsonDecode(response.body);
      //get categories from Map<String,dynamic>
      var mealDetail = jsonReturn['meals'] as List;

      //List<String> -> List<Map<String,dyanmic> -> List<MealDetail>.first
      return List<Map<String,dynamic>>.from(mealDetail)
          .map((mealDetail) => MealDetailModel.fromMap(mealDetail)).first;

    } on APIException{
      rethrow;
    }catch(e) {
      debugPrint("_log error -> ${e.toString()}");
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<MealDetailModel> getRandomMealDetail() async{
    try {

      final response = await httpClient.get(Uri.https(kBaseUrl,kGetRandomMealDetail));
      if(response.statusCode != 200){
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      //convert JsonString to Map<String,dynamic>
      var jsonReturn = jsonDecode(response.body);
      //get categories from Map<String,dynamic>
      var mealDetail = jsonReturn['meals'] as List;

      //List<String> -> List<Map<String,dyanmic> -> List<MealDetail>.first
      return List<Map<String,dynamic>>.from(mealDetail)
          .map((mealDetail) => MealDetailModel.fromMap(mealDetail)).first;

    } on APIException{
      rethrow;
    }catch(e) {
      debugPrint("_log error -> ${e.toString()}");
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
  
