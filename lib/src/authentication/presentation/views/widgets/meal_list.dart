import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/meal_detail_screen.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/widgets/progress_dialog.dart';

class MealList extends StatefulWidget {
  const MealList({super.key});

  @override
  State<MealList> createState() => _MealListState();
}

class _MealListState extends State<MealList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<MealCubit, MealState>(listener: (context, state) {
      if (state is MealError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      }
    }, builder: (context, state) {
      return Container(
        child: state is GetMealByCategoryLoading
            ? const Center(
                child: ProgressDialog(message: "Fetching Meal"),
              )
            :
            //state is CreatingUser ? const Center(child: ProgressDialog(message:"Creating User"),) :
            state is GetMealByCategoryLoaded
                ? Center(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.meal.length,
                        itemBuilder: (ctx, index) {
                          debugPrint("_log meal -> $index}");
                          final meal = state.meal[index];
                          return Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: meal.strMealThumb,
                                      placeholder: (context, url) => Container(
                                        width: 30,
                                        height: 30,
                                        alignment: Alignment.center,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2.0, // Thinner indicator
                                          color: Colors.grey,
                                        ),
                                      ),
                                      height: width * 0.2,
                                      width: width * 0.2,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        meal.strMeal,
                                        softWrap: false,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder: ((ctx) =>
                                                      MealDetailScreen(mealId:meal.idMeal,))));
                                              },
                                              child: const Text(
                                                'Detail >>',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  )
                : const SizedBox.shrink(),
      );
    });
  }
}
