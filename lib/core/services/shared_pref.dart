import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Storage {
  Future<void> saveCode(String code);
  Future<String?> getCode();
  Future<void> clearCode();

  Future<void> saveOrderMeal(Meal meal);
  Future<List<Meal>> getOrderMeal();
  
  Future<void> setFavoriteMeal(Meal meal);
  Future<List<Meal>> getFavoritemeal();
  // Factory method
  factory Storage() => SharedPreferencesCodeStorage();
}

class SharedPreferencesCodeStorage implements Storage {
  static const String _codeKey = 'random_code';
  static const String _orderMealKey = 'order_meal';
  static const String _favoriteMealKey = 'favorite_meal';

  @override
  Future<void> saveCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_codeKey, code);
  }

  @override
  Future<String?> getCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_codeKey);
  }

  @override
  Future<void> clearCode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_codeKey);
  }
  
  @override
  Future<List<Meal>> getFavoritemeal() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final lstFavoriteMeal = prefs.getString(_favoriteMealKey);
      if(lstFavoriteMeal == null) return [];
      final List<dynamic> jsonList = jsonDecode(lstFavoriteMeal);
      final lstOrder = jsonList.map((meal) => Meal.fromJson(meal)).toList();
      return lstOrder;
    }catch(e){
      return [];
    }
  }
  
  @override
  Future<List<Meal>> getOrderMeal() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final strOrderList = prefs.getString(_orderMealKey);
      if(strOrderList == null) return [];
      final List<dynamic> jsonList = jsonDecode(strOrderList);
      final lstOrder = jsonList.map((meal) => Meal.fromJson(meal)).toList();
      return lstOrder;
    }catch(e){
      return [];
    }
  }
  
  @override
  Future<void> saveOrderMeal(Meal meal) async{
    try{
      final prefs = await SharedPreferences.getInstance();
      final strOrderList = prefs.getString(_orderMealKey);
      if(strOrderList == null) {
        final lstOrder = [meal];
        prefs.setString(_orderMealKey, jsonEncode(lstOrder));
      }else{
        final List<dynamic> jsonList = jsonDecode(strOrderList);
        final lstOrder = jsonList.map((meal) => Meal.fromJson(meal)).toList();
        lstOrder.add(meal);
        prefs.setString(_orderMealKey, jsonEncode(lstOrder));
        debugPrint("_log pref save meal ${prefs.getString(_orderMealKey)}");
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }
  
  @override
  Future<void> setFavoriteMeal(Meal meal) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final lstFavoriteMeal = prefs.getString(_favoriteMealKey);
      if(lstFavoriteMeal == null) {
        final lstFavorite = [meal];
        prefs.setString(_orderMealKey, jsonEncode(lstFavorite));
      }else{
        final List<dynamic> jsonList = jsonDecode(lstFavoriteMeal);
        final lstFavorite = jsonList.map((meal) => Meal.fromJson(meal)).toList();
        lstFavorite.add(meal);
        prefs.setString(_favoriteMealKey, jsonEncode(lstFavorite));
        debugPrint("_log pref favorite meal ${prefs.getString(_favoriteMealKey)}");
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }
}
