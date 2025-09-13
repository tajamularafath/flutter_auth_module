import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF2D5016),
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Shop by Category',
          style: TextStyle(
            color: Color(0xFF2D5016),
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Color(0xFF2D5016),
              size: 24,
            ),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Fresh & Natural',
                style: TextStyle(
                  color: Color(0xFF6B8E23),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: dairyCategories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(category: dairyCategories[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final DairyCategory category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle category selection
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected ${category.name}'),
            duration: const Duration(seconds: 1),
            backgroundColor: const Color(0xFF6B8E23),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: category.backgroundColor.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: category.backgroundColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                category.icon,
                size: 36,
                color: category.backgroundColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              category.name,
              style: const TextStyle(
                color: Color(0xFF2D5016),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category.subtitle,
              style: TextStyle(
                color: const Color(0xFF2D5016).withOpacity(0.6),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DairyCategory {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;

  DairyCategory({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
  });
}

final List<DairyCategory> dairyCategories = [
  DairyCategory(
    name: 'Milk',
    subtitle: 'Fresh & Pure',
    icon: Icons.local_drink,
    backgroundColor: const Color(0xFF87CEEB),
  ),
  DairyCategory(
    name: 'Cheese',
    subtitle: 'Artisan Made',
    icon: Icons.cake,
    backgroundColor: const Color(0xFFFFD700),
  ),
  DairyCategory(
    name: 'Yogurt',
    subtitle: 'Creamy & Healthy',
    icon: Icons.icecream,
    backgroundColor: const Color(0xFFFF69B4),
  ),
  DairyCategory(
    name: 'Butter',
    subtitle: 'Farm Fresh',
    icon: Icons.grain,
    backgroundColor: const Color(0xFFFFA500),
  ),
  DairyCategory(
    name: 'Cream',
    subtitle: 'Rich & Smooth',
    icon: Icons.coffee,
    backgroundColor: const Color(0xFF98FB98),
  ),
  DairyCategory(
    name: 'Ice Cream',
    subtitle: 'Sweet Treats',
    icon: Icons.ac_unit,
    backgroundColor: const Color(0xFFDDA0DD),
  ),
];