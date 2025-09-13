// ---------------- Categories Section ----------------
import 'package:flutter/material.dart';

import 'home_screen.dart';

class DairyCategoriesSection extends StatelessWidget {
  const DairyCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Milk', 'icon': Icons.local_drink, 'color': const Color(0xFF81C784)},
      {'name': 'Cheese', 'icon': Icons.cake, 'color': const Color(0xFFFFB74D)},
      {'name': 'Yogurt', 'icon': Icons.icecream, 'color': const Color(0xFF64B5F6)},
      {'name': 'Butter', 'icon': Icons.breakfast_dining, 'color': const Color(0xFFF06292)},
      {'name': 'Cream', 'icon': Icons.opacity, 'color': const Color(0xFFAED581)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Shop by Category',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              return DairyCategoryItem(
                name: cat['name'] as String,
                icon: cat['icon'] as IconData,
                color: cat['color'] as Color,
              );
            },
          ),
        ),
      ],
    );
  }
}