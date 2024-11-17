import 'package:flutter_tdd/core/services/shared_pref.dart';
import 'package:flutter_tdd/src/authentication/data/datasource/remote.dart';
import 'package:flutter_tdd/src/authentication/data/datasource/storage.dart';
import 'package:flutter_tdd/src/authentication/data/repository/meal_repo_impl.dart';
import 'package:flutter_tdd/src/authentication/domain/repository/meal_repo.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/check_phone_number_usecase.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/get_all_meal_category.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/get_meal_by_category_id.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/get_meal_detail.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/get_order_meal.dart';
import 'package:flutter_tdd/src/authentication/domain/usecases/get_random_meal.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_category_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_detail_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_random_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/order_meal_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

Future<void> init() async{
  //application logic
  getIt.registerFactory(() => MealCubit(getAllMealCategoryUseCase: getIt(), getMealByCategoryIdUseCase: getIt()));
  getIt.registerFactory(() => MealCategoryCubit(getAllMealCategoryUseCase: getIt()));
  getIt.registerFactory(() => AuthenticationCubit(validatePhoneNumberUseCase: getIt()));
  getIt.registerFactory(() => MealDetailCubit(getMealDetailUseCase: getIt()));
  getIt.registerFactory(() => MealRandomCubit(getRandomMealUseCase: getIt()));
  getIt.registerFactory(() => OrderMealCubit(getOrderMealUseCase: getIt()));

  //usecases
  getIt.registerLazySingleton(() => GetMealDetailUseCase(getIt()));
  getIt.registerLazySingleton(() => ValidatePhoneNumberUseCase());
  getIt.registerLazySingleton(() => GetMealByCategoryIdUseCase(getIt()));
  getIt.registerLazySingleton(() => GetAllMealCategoryUseCase(getIt()));
  getIt.registerLazySingleton(() => GetRandomMealUseCase(getIt()));
  getIt.registerLazySingleton(() => GetOrderMealUseCase(getIt()));

  //repo
  getIt.registerLazySingleton<MealRepo>(() => MealRepoImpl(getIt(),getIt()));

  //datasource
  getIt.registerLazySingleton<MealDataSource>(() => MealDataSourceImpl(getIt()));
  getIt.registerLazySingleton<StorageDataSource>(() => StorageDataSourceImpl(getIt()));

  //storage
  getIt.registerLazySingleton(() => Storage());

  //external dependencies
  getIt.registerLazySingleton(() => http.Client());
}