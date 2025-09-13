import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FDF8),
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Color(0xFF2D5016),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey.withOpacity(0.1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D5016)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Company Logo Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Icon(
                      Icons.local_drink,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'DairyFresh',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D5016),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Introduction Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'At DairyFresh, we bring you fresh, organic, and high-quality dairy products directly from local farms. Our commitment to excellence ensures that every product meets the highest standards of purity and taste.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Color(0xFF555555),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),

            // Mission & Values Section
            const Text(
              'Our Values',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D5016),
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildValueCard(
                  icon: Icons.eco,
                  title: 'Freshness',
                  description: 'Farm to table in 24 hours',
                  color: const Color(0xFF4CAF50),
                ),
                _buildValueCard(
                  icon: Icons.verified,
                  title: 'Quality',
                  description: 'Premium dairy products',
                  color: const Color(0xFF2196F3),
                ),
                _buildValueCard(
                  icon: Icons.nature,
                  title: 'Sustainability',
                  description: 'Eco-friendly practices',
                  color: const Color(0xFF8BC34A),
                ),
                _buildValueCard(
                  icon: Icons.favorite,
                  title: 'Care',
                  description: 'Customer satisfaction',
                  color: const Color(0xFFFF9800),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Team Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Our Farm Partners',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D5016),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFarmerProfile('John D.', 'Organic Farm'),
                      _buildFarmerProfile('Sarah M.', 'Green Valley'),
                      _buildFarmerProfile('Mike R.', 'Fresh Dairy'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Contact Information
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D5016),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactItem(Icons.email, 'info@dairyfresh.com'),
                  _buildContactItem(Icons.phone, '+1 (555) 123-4567'),
                  _buildContactItem(Icons.location_on, '123 Farm Road, Green Valley'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Social Media Links
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Follow Us',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D5016),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSocialIcon(Icons.facebook, const Color(0xFF1877F2)),
                      _buildSocialIcon(Icons.camera_alt, const Color(0xFFE4405F)),
                      _buildSocialIcon(Icons.alternate_email, const Color(0xFF1DA1F2)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100), // Space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF4CAF50),
        unselectedItemColor: Colors.grey,
        currentIndex: 3, // Profile tab selected
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D5016),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFarmerProfile(String name, String farm) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0xFF4CAF50),
          child: Text(
            name.split(' ').map((e) => e[0]).join(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D5016),
          ),
        ),
        Text(
          farm,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4CAF50), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF555555),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle social media link tap
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}