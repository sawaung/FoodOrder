import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/core/services/injection_container.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/order_meal_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/meal_detail_screen.dart';

class OrderMealList extends StatefulWidget {
  OrderMealList({super.key});

  //List<Meal> lstOrderMeal = [];

  @override
  State<OrderMealList> createState() => _OrderMealList();
}

class _OrderMealList extends State<OrderMealList> {
  @override
  void initState() {
    super.initState();
    _fetchOrderMeal();
  }

  Future<void> _fetchOrderMeal() async {
    // try {
    //   debugPrint("_log loading meal from db");
    //   widget.lstOrderMeal =
    //       await Storage().getOrderMeal().then((value) => value);
    //   debugPrint("_log orderMealSize ${widget.lstOrderMeal.length}");
    //   setState(() {
        
    //   });
    // } catch (e) {
    //   debugPrint("Error loading order data: $e");
    // }

     try {
      final cubit =  context.read<OrderMealCubit>();
      cubit.getOrderMeal();
    } catch (e) {
      // Handle potential errors here
      debugPrint("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          iconTheme: const IconThemeData(
            color: Colors.white, // Set your desired color here
          ),
          centerTitle: true,
          title: const Text(
            "Order History",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocConsumer<OrderMealCubit, OrderMealState>(
          listener: (context, state) {
            
          },
          builder: (context, state) {
            return SizedBox(
                  child:  state is GetOrderMealLoaded ? Container(
                    child: state.meal.isNotEmpty ? ListView.builder(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      meal.strMeal,
                                      softWrap: false,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.normal),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: ((ctx) =>
                                                          MealDetailScreen(
                                                            mealId: meal.idMeal,
                                                            fromOrderHistory: true,
                                                          ))));
                                            },
                                            child: const Text(
                                              "View",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ) : const Center(
                      child: Text("No order history"),
                    ),
                  ): const SizedBox.shrink() ,
                );
            
          }
        )
    );
  }
}



