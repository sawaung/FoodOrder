import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_random_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/meal_detail_screen.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/widgets/progress_dialog.dart';

class MealRandomItem extends StatefulWidget {
  const MealRandomItem({super.key});

  @override
  State<MealRandomItem> createState() => _MealRandomItemState();
}

class _MealRandomItemState extends State<MealRandomItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    
    _fetchData();
  

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();

    //_startPeriodicApiCall();
  }

  void _startPeriodicApiCall() {
      _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        _fetchData();
      });
  }

  Future<void> _fetchData() async {
    try {
      await context.read<MealRandomCubit>().getMealRandom();
    } catch (e) {
      // Handle potential errors here
      debugPrint("Error fetching data: $e");
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<MealRandomCubit, MealRandomState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SizedBox(
            height: 230,
            width: double.infinity,
            child: state is MealRandomLoading
                ? const Center(
                    //child: ProgressDialog(message: "fetching .."),
                  )
                : state is MealRandomLoaded
                    ? FadeTransition(
                        opacity: _animation as Animation<double>,
                        child: Stack(
                          children: [
                            SizedBox(
                              child:CachedNetworkImage(
                                      imageUrl: state.mealDetail.strMealThumb ?? "",
                                      placeholder: (context, url) => Container(
                                        height: 230,
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),
                                     height: 230,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                              // child: Image.network(
                              //   height: 230,
                              //   width: double.infinity,
                              //   state.mealDetail.strMealThumb ?? "",
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: InkWell(
                                onTap: () {
                                   Navigator.of(context).push(
                                                    MaterialPageRoute(builder: ((ctx) =>
                                                      MealDetailScreen(mealId:state.mealDetail.idMeal!))));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: const Text(
                                      'Detail >>',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                            Positioned(
                                bottom: 10,
                                left: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    state.mealDetail.strMeal ?? "Meal Name",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
          );
        });
  }
}
