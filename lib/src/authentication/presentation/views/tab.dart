import 'package:flutter/material.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/home_screen.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/order_meal_screen.dart';


class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  
  //BottomNavigationBar click logic
  int _selectedPageIndex = 0;
  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async{
     Navigator.pop(context);
 
  }

  @override
  Widget build(BuildContext context) {
    
    //BottomNavigationBar click logic
    var activePageTitle = 'Home';
    Widget activeWidget = const HomeScreen();

    if (_selectedPageIndex == 1) {
      activePageTitle = 'Order History';
      activeWidget = OrderMealList();
    }

    final List<Widget> _screens = [
      const HomeScreen(),
      OrderMealList(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedPageIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Meal'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Order History')
          ]),
    );
  }
}
