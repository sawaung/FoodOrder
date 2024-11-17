import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/core/services/injection_container.dart';
import 'package:flutter_tdd/core/services/noti_service.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_category_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_detail_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_random_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/order_meal_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/tab.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  NotificationService().checkNotificationPermissionStatus(); //if changed Main Function to Async, need to add ->WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
          providers: [
            BlocProvider<MealCubit>(
              create: (BuildContext context) => getIt<MealCubit>(),
            ),
            BlocProvider<MealCategoryCubit>(
              create: (BuildContext context) => getIt<MealCategoryCubit>(),
            ),
             BlocProvider<MealDetailCubit>(
              create: (BuildContext context) => getIt<MealDetailCubit>(),
            ),
             BlocProvider<MealRandomCubit>(
              create: (BuildContext context) => getIt<MealRandomCubit>(),
            ),
            BlocProvider<OrderMealCubit>(
              create: (BuildContext context) => getIt<OrderMealCubit>(),
            )
          ],
          child: MaterialApp(
          title: 'Food Order',
          debugShowCheckedModeBanner: true,
          theme: ThemeData(
            backgroundColor: const Color.fromARGB(255, 218, 217, 217),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home:  const TabScreen(),
        ),
    );
  }
}
