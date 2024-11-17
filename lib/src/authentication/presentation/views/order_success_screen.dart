import 'package:flutter/material.dart';
import 'package:flutter_tdd/core/services/shared_pref.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/tab.dart';

class OrderSuccessScreen extends StatefulWidget {
   OrderSuccessScreen({super.key, this.orderMeal});

  Meal? orderMeal;
  @override
  State<OrderSuccessScreen> createState() {
    return _OrderSuccessScreen();
  }
}

class _OrderSuccessScreen extends State<OrderSuccessScreen> {

  @override
  void initState() {
    super.initState();
    _saveOrderMeal();
    debugPrint("_log order success init");
  }

    @override
  void dispose() {
    super.dispose();
  }

  Future<void> _saveOrderMeal() async {
    try {
      debugPrint("_log saving order");
      if(widget.orderMeal != null){
        debugPrint("_log  order not null");
        Storage().saveOrderMeal(widget.orderMeal!);
        debugPrint("_log saving order");
        final orderMealSize = await Storage().getOrderMeal().then((value) => value);
        debugPrint("_log orderMealSize ${orderMealSize.length}");
      }
    } catch (e) {
      debugPrint("Error saveing order data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set your desired color here
        ),
        centerTitle: true,
        title: const Text(
          "Order",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/order_success.png',
              width: 70,
              height: 70,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Your order is received.We will contact you shortly.",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((ctx) => const TabScreen())));
                },
                child: const Text(
                  'BACK TO HOME',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
