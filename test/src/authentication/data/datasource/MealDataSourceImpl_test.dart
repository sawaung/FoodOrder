import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/core/util/constant.dart';
import 'package:flutter_tdd/src/authentication/data/datasource/remote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late MealDataSourceImpl dataSourceImpl;

  setUp(() {
    client = MockClient();
    dataSourceImpl = MealDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('calling meal data from API', () {
    test('get meal category success case', () async {
      when(() => client.get(Uri.https(kBaseUrl, kGetAllMealCategoriesEndPoint)))
    .thenAnswer((_) async => http.Response('{"categories": [{"idCategory": "1", "strCategory": "Beef", "strCategoryThumb": "some_url", "strCategoryDescription": "Description"}]}', 200));

      final methodCall = dataSourceImpl
          .getAllMealCategories(); //assign createUser function reference to methodCall

      expect(
          methodCall,
          completes); // test async call is completed successfully

      verify(() => client.get(Uri.https(kBaseUrl, kGetAllMealCategoriesEndPoint)))
    .called(1);

      verifyNoMoreInteractions(client);
    });

    test("get meal category fail case", () async {
      when(() => client.get(Uri.https(kBaseUrl, kGetAllMealCategoriesEndPoint)))
    .thenAnswer((_) async => http.Response('{}', 400));


      final methodCall = dataSourceImpl.getAllMealCategories(); //assign reference

      expect(
          () async => methodCall,
          throwsA(const APIException(
              message: '{}', statusCode: 400)));

      verify(() => client.get(Uri.https(kBaseUrl, kGetAllMealCategoriesEndPoint)))
    .called(1);
      verifyNoMoreInteractions(client);
    });


    group('getMealByCategory', () {
    test('getMealByCategory success case', () async {
      const jsonReturn = '{"meals": [{"strMeal": "Beef and Mustard Pie","strMealThumb": "https://www.themealdb.com/images/media/meals/sytuqu1511553755.jpg","idMeal": "52874"}]}';
      when(() => client.get(Uri.https(kBaseUrl, kGetMealByCategory,{
        'c' : "Beef"
      })))
    .thenAnswer((_) async => http.Response(jsonReturn, 200));

      final methodCall = dataSourceImpl
          .getMealByCategory("Beef"); //assign createUser function reference to methodCall

      expect(
          methodCall,
          completes); // test async call is completed successfully

      verify(() => client.get(Uri.https(kBaseUrl, kGetMealByCategory, {
        'c' : "Beef"
      }))).called(1);

      verifyNoMoreInteractions(client);
    });

    test('getMealByCategory success case', () async {
      const jsonReturn = '{}';
      when(() => client.get(Uri.https(kBaseUrl, kGetMealByCategory,{
        'c' : "Beef"
      })))
    .thenAnswer((_) async => http.Response(jsonReturn, 201));

      final methodCall = dataSourceImpl
          .getMealByCategory("Beef"); //assign createUser function reference to methodCall

      expect(
          () async => methodCall,
          throwsA(const APIException(
              message: '{}', statusCode: 201)));

      verify(() => client.get(Uri.https(kBaseUrl, kGetMealByCategory, {
        'c' : "Beef"
      }))).called(1);

      verifyNoMoreInteractions(client);
    });
    
  });

  });
  
}
