import 'package:authication_module/features/profile/presentation/screen/about_us_screen.dart';
import 'package:authication_module/features/profile/presentation/screen/help_supports_screen.dart';
import 'package:authication_module/features/profile/presentation/screen/my_order_screen.dart';
import 'package:authication_module/features/profile/presentation/screen/payment_methods_screen.dart';
import 'package:flutter/material.dart';

import 'delivered_screen.dart';
import 'notifications_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF2E7D32),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2E7D32)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
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
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF2E7D32).withOpacity(0.8),
                                const Color(0xFF4CAF50),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'A',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E7D32),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Hi, Alex!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'alex.johnson@email.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Account Options Section
              Container(
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
                child: Column(
                  children: [
                    _buildProfileOption(
                      icon: Icons.shopping_bag_outlined,
                      title: 'My Orders',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyOrdersScreen()),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildProfileOption(
                      icon: Icons.location_on_outlined,
                      title: 'Delivery Address',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DeliveryAddressScreen()),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildProfileOption(
                      icon: Icons.credit_card,
                      title: 'Payment Methods',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaymentMethodsScreen()),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildProfileOption(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationsScreen()),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildProfileOption(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HelpSupportScreen()),
                        );
                    },
                    ),
                    _buildDivider(),
                    _buildProfileOption(
                      icon: Icons.info_outline,
                      title: 'About Us',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutUsScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Logout Button
              Container(
                width: double.infinity,
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
                child: _buildProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  textColor: Colors.red[600],
                  iconColor: Colors.red[600],
                  showArrow: false,
                  onTap: () => _handleLogout(),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (iconColor ?? const Color(0xFF2E7D32)).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: iconColor ?? const Color(0xFF2E7D32),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? const Color(0xFF2E2E2E),
                ),
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 76),
      child: Divider(
        height: 1,
        color: Colors.grey[200],
      ),
    );
  }

  void _handleOptionTap(String option) {
    // Handle navigation to respective screens
    print('Tapped on: $option');
  }

  void _handleLogout() {
    // Handle logout functionality

    print('Logout tapped');
  }
}