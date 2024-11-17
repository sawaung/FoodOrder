import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_category_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/widgets/progress_dialog.dart';

class MealCategoryList extends StatefulWidget {
  const MealCategoryList({super.key, required this.buildContext});

//
  final BuildContext buildContext;
  //inal void Function() selectCategory;

  @override
  State<MealCategoryList> createState() => _MealCategoryItemState();
}

class _MealCategoryItemState extends State<MealCategoryList> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      await context.read<MealCategoryCubit>().getAllMealCategory();
    } catch (e) {
      // Handle potential errors here
      debugPrint("Error fetching data: $e");
    }
  }

  Future<void> _fetchMealData(String str) async {
    try {
      await context.read<MealCubit>().getMealByCategoryId(str);
    } catch (e) {
      // Handle potential errors here
      debugPrint("Error fetching data: $e");
    }
  }

  void _onItemTap(int index, MealCategory meal) async {
    setState(() {
      _selectedIndex = index; // Update selected index
    });

    await Future.delayed(const Duration(seconds: 1));
    _fetchMealData(meal.strCategory);
    debugPrint('Selected category: ${meal.strCategory}');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<MealCategoryCubit, MealCategoryState>(
        listener: (context, state) {
      if (state is MealCategoryError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      } else if (state is GetMealCategoriesLoaded) {
        setState(() {
          _selectedIndex = 0;
          _onItemTap(_selectedIndex, state.category.first);
        });
      }
    }, builder: (context, state) {
      return
      SizedBox(
        height: 120,
        child: state is GetMealCategoriesLoading
            ? const Center(
                child: ProgressDialog(message: "Fetching Meal"),
              )
            : state is GetMealCategoriesLoaded
                ? Center(
                    child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.category.length,
                    itemBuilder: (ctx, index) {
                      final meal = state.category[index];
                      final isSelected = index == _selectedIndex;
                      return InkWell(
                        onTap: () {
                          _onItemTap(index, meal);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10,),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Colors.red.shade100 : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.grey.shade100
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child:CachedNetworkImage(
                                      imageUrl: meal.strCategoryThumb,
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.scaleDown,
                                    ),
                                // child: Image.network(
                                //   meal.strCategoryThumb,
                                //   height: 80,
                                //   width: 80,
                                //   fit: BoxFit.scaleDown,
                                // ),
                              ),
                              Text(meal.strCategory,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal))
                            ],
                          ),
                        ),
                      );
                    },
                  ))
                : const SizedBox.shrink(),
      );
    });
  }
}
