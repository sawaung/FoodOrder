import 'package:flutter/material.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/widgets/add_user_phone.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/widgets/meal_category_list.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/widgets/meal_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() {
    return _DashboardScreen();
  }
}

class _DashboardScreen extends State<DashboardScreen> {
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
            const SizedBox(height: 10,),
            MealCategoryList(buildContext: context),
            const SizedBox(height: 5,),
            Divider(color: Colors.grey.shade300, thickness: 1,),
            const MealList(),
            
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //       onPressed: () async {
      //         await showDialog(context: context, builder: (context) {
      //           return AddUserPhone(changePhoneNo: false);
      //         });
      //       },
      //       icon: const Icon(Icons.add),
      //       label: const Text("Add User"),
      //     )
    );
    
  }
}
