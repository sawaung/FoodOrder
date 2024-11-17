import 'package:flutter/material.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/widgets/meal_category_list.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/widgets/meal_list.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/widgets/meal_random_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController phoneController = TextEditingController();
  bool categoryLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MealRandomItem(),
            const SizedBox(height: 10,),
            MealCategoryList(buildContext: context),
            const SizedBox(height: 5,),
            Divider(color: Colors.grey.shade300, thickness: 1,),
            const MealList(),
            
          ],
        ),
      ),
    );
    
  }
}
