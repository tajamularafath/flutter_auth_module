import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:authication_module/constants/string_constants.dart';
import 'package:authication_module/features/cart/presentation/screen/cart_screen.dart';
import 'package:authication_module/features/category/presentation/screen/category_screen.dart';
import 'package:authication_module/features/home/presentation/screen/home_screen.dart';
import 'package:authication_module/features/profile/presentation/screen/profile_screen.dart';
import 'package:authication_module/onboarding/provider/bottom_navigation_provider.dart';

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});

  final List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      body: _pages[navigationProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationProvider.currentIndex,
        onTap: navigationProvider.updateIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2E7D32), // Green
        unselectedItemColor: const Color(0xFF999999), // Grey
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: StringConstants.homeLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            label: StringConstants.categoryLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: StringConstants.cartLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: StringConstants.profileLabel,
          ),
        ],
      ),
    );
  }
}
