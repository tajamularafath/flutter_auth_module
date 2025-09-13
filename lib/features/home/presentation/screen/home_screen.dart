import 'package:flutter/material.dart';
import 'banner_widget.dart';
import 'category_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DairyHeader(),
              const DairySearchBar(),
              BannerWidget(),
              DairyCategoriesSection(),
              const DairyFeaturedProducts(),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- Header ----------------
class DairyHeader extends StatelessWidget {
  const DairyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fresh',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              Text(
                'Fresh dairy, delivered daily',
                style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: Color(0xFF2E7D32),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Search Bar ----------------

class DairySearchBar extends StatelessWidget {
  const DairySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search for dairy products...',
          hintStyle: TextStyle(color: Color(0xFF999999)),
          prefixIcon: Icon(Icons.search, color: Color(0xFF2E7D32)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

// ---------------- Promo Button ----------------
class DairyPromoButton extends StatelessWidget {
  const DairyPromoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2E7D32),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text(
        'Shop Now',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class DairyCategoryItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;

  const DairyCategoryItem({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ---------------- Featured Products ----------------

class DairyFeaturedProducts extends StatelessWidget {
  const DairyFeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'name': 'Organic Whole Milk',
        'price': '\$4.99',
        'image': '🥛',
        'rating': 4.8,
      },
      {'name': 'Greek Yogurt', 'price': '\$3.49', 'image': '🥛', 'rating': 4.6},
      {
        'name': 'Aged Cheddar Cheese',
        'price': '\$8.99',
        'image': '🧀',
        'rating': 4.9,
      },
      {'name': 'Fresh Butter', 'price': '\$5.49', 'image': '🧈', 'rating': 4.7},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final p = products[index];
            return DairyProductCard(
              name: p['name'] as String,
              price: p['price'] as String,
              image: p['image'] as String,
              rating: p['rating'] as double,
            );
          },
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

class DairyProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final double rating;

  const DairyProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(image, style: const TextStyle(fontSize: 40)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF333333),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFFFB74D), size: 16),
                Text(
                  ' $rating',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
