import 'dart:convert';
import 'package:flutter_tdd/src/authentication/data/model/meal_category_model.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_category.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixture/fixture_reader.dart';

void main() {
  //arrange
  const tModel = MealCategoryModel.fake();

  test("Test subclass of the MealCategory Entity", (){
    expect(tModel, isA<MealCategory>());
  });

  final tJson = fixture('meal_category.json');
  final tMap = jsonDecode(tJson)['categories'] as Map<String,dynamic>;


  group('fromMap', () {
    test("Test should return MealCategoryModel", (){
      final result = MealCategoryModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });
  
  group("fromJson", () {
    test("Test should return UserModel", (){
      final result = MealCategoryModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group("toMap", () {
    test("Test should return UserMode Map", () {
      final result = tModel.toMap();
      expect(result,equals(tMap));
    });
  });

  group("toJson", () {
    test("Test should return UserModel Json String", (){
      final result = tModel.toJson();
      expect(result,tJson);
    });
  });

  group("copyWith", () {
    test("Test should return UserModel", (){
      final result = tModel.copyWith(strCategory: "Beef");
      expect(result.strCategory,"Beef");
    });
  });
}