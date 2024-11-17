import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/meal_detail_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/widgets/add_user_phone.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/widgets/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatefulWidget {
  MealDetailScreen({super.key, required this.mealId, this.fromOrderHistory = true});

  final String mealId;
  Meal? orderMeal;
  bool fromOrderHistory;

  @override
  State<MealDetailScreen> createState() {
    return _MealDetailScreenState();
  }
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final TextEditingController phoneController = TextEditingController();
  bool categoryLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

    Future<void> _fetchData() async {
    try {
      await context.read<MealDetailCubit>().getMealDetail(widget.mealId);
    } catch (e) {
      // Handle potential errors here
      debugPrint("Error fetching data: $e");
    }
  }

  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set your desired color here
        ),
        centerTitle: true,
        title: const Text(
          "Meal Detail",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<MealDetailCubit, MealDetailState>(
        listener: (context, state) {
      if (state is MealDetailStateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      }else if(state is MealDetailLoaded){
        widget.orderMeal = Meal(strMeal: state.mealDetail.strMeal ?? "", strMealThumb: state.mealDetail.strMealThumb ?? "", idMeal: state.mealDetail.idMeal ?? "");
      }},builder: (context, state) {
        
      return Container(
        child: state is MealDetailLoading
            ? const Center(
                child: ProgressDialog(message: "Fetching Meal"),
              )
            :
            state is MealDetailLoaded
                ? Center(
                    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meal Image
            Stack(
              children: [
                Image.network(
                  state.mealDetail.strMealThumb ??
                      "https://via.placeholder.com/400x300",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    color: Colors.black54,
                    child: Text(
                      state.mealDetail.strCategory ?? "Category",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            // YouTube Video
            if (state.mealDetail.strYoutube != null &&
                state.mealDetail.strYoutube.toString().isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final youtubeUrl = state.mealDetail.strYoutube ;
                    if(youtubeUrl != null){
                      _launchURL(youtubeUrl);
                    }
                    // Navigate to the YouTube video using `url_launcher` or another package
                  },
                  icon: const Icon(Icons.video_collection),
                  label: const Text("Watch Recipe Video"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 248, 161, 161),
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Meal Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                 state.mealDetail.strMeal ?? "No Title",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            //  (Cuisine) and Tags
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text( state.mealDetail.strArea ?? "Unknown Cuisine"),
                  ),
                  if ( state.mealDetail.strTags != null)
                    Flexible(
                      child: Wrap(
                        spacing: 8.0,
                        children:  state.mealDetail.strTags
                            .toString()
                            .split(',')
                            .map((tag) => Chip(label: Text(tag.trim())))
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Ingredients
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.0),
              child:  Text(
                "Ingredients:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                      Text(" ${state.mealDetail.strIngredient1}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(" ${state.mealDetail.strIngredient2}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(" ${state.mealDetail.strIngredient3}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(" ${state.mealDetail.strIngredient4}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(" ${state.mealDetail.strIngredient5}",
                      style: const TextStyle(fontSize: 16),
                    )
                  
                ]
              ),
            ),
            const SizedBox(height: 16),

            // Instructions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                "Instructions:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                state.mealDetail.strInstructions ?? "No Instructions",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            
            const SizedBox(height: 16),
          ],
        ),
                  )
                : const SizedBox.shrink(),
      );
        }),

      ),
      
      floatingActionButton: Visibility(
        visible: widget.fromOrderHistory,
        child: FloatingActionButton.extended(
          
              onPressed: () async {
                await showDialog(context: context, builder: (context) {
                  debugPrint("_log passing order to add user phone ${widget.orderMeal}");
                  return AddUserPhone(changePhoneNo: false,orderMeal: widget.orderMeal,);
                });
              },
              backgroundColor: Colors.red,
              label: const Text("Order Now"),
              icon: const Icon(Icons.add_box,color: Colors.white,),
            ),
      )
    );   
  }

Future<void> _launchURL(String link) async {
  final Uri url = Uri.parse(link);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              throw "Could not launch $link";
            }
}
}
