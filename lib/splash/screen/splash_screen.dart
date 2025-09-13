import 'dart:math' as Math;

import 'package:flutter/material.dart';

import '../../features/home/presentation/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _taglineController;
  late AnimationController _loadingController;
  late AnimationController _milkController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _taglineOpacity;
  late Animation<double> _taglineSlide;
  late Animation<double> _loadingOpacity;
  late Animation<double> _milkRotation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
    _navigateToHome();
  }

  void _initializeAnimations() {
    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Tagline animation controller
    _taglineController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Loading animation controller
    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Milk bottle rotation controller
    _milkController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Logo animations
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    // Tagline animations
    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.easeIn),
    );

    _taglineSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.easeOut),
    );

    // Loading animation
    _loadingOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loadingController, curve: Curves.easeIn),
    );

    // Milk bottle rotation
    _milkRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _milkController, curve: Curves.linear),
    );
  }

  void _startAnimationSequence() async {
    // Start logo animation
    _logoController.forward();

    // Start tagline animation after 600ms
    await Future.delayed(const Duration(milliseconds: 600));
    _taglineController.forward();

    // Start loading animation after 1000ms
    await Future.delayed(const Duration(milliseconds: 400));
    _loadingController.forward();

    // Start milk bottle rotation
    _milkController.repeat();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _taglineController.dispose();
    _loadingController.dispose();
    _milkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8FFFE), // Very light mint
              Color(0xFFE8F5E8), // Light sage green
              Color(0xFFF0F8FF), // Alice blue
              Color(0xFFFFFFF8), // Cream white
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top decorative elements
              _buildTopDecoration(),

              // Main content area
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo section
                    AnimatedBuilder(
                      animation: _logoController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _logoScale.value,
                          child: Opacity(
                            opacity: _logoOpacity.value,
                            child: _buildLogo(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Tagline section
                    AnimatedBuilder(
                      animation: _taglineController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _taglineSlide.value),
                          child: Opacity(
                            opacity: _taglineOpacity.value,
                            child: _buildTagline(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 60),

                    // Loading indicator
                    AnimatedBuilder(
                      animation: _loadingController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _loadingOpacity.value,
                          child: _buildLoadingIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Bottom decorative wave
              _buildBottomDecoration(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopDecoration() {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -10,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 20,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFF81C784),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 80,
            top: 30,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFA5D6A7),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        // Milk bottle icon with rotation animation
        AnimatedBuilder(
          animation: _milkController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _milkRotation.value * 0.1, // Subtle rotation
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4CAF50).withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Milk bottle illustration
                    Container(
                      width: 60,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF4CAF50),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Bottle cap
                          Container(
                            width: 20,
                            height: 8,
                            margin: const EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          // Milk level
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Milk drops decoration
                    Positioned(
                      right: 15,
                      top: 15,
                      child: Container(
                        width: 8,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFF81C784),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        // App name
        const Text(
          'DairyFresh',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
            letterSpacing: 1.2,
            fontFamily: 'serif',
          ),
        ),
      ],
    );
  }

  Widget _buildTagline() {
    return Column(
      children: [
        const Text(
          'Fresh from Farm to Home',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF558B2F),
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 2,
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.6),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      children: [
        // Custom milk splash loading animation
        SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            children: List.generate(3, (index) {
              return AnimatedBuilder(
                animation: _milkController,
                builder: (context, child) {
                  final delay = index * 0.3;
                  final animationValue = (_milkController.value + delay) % 1.0;
                  final scale = (animationValue < 0.5)
                      ? 0.4 + (animationValue * 1.2)
                      : 1.0 - ((animationValue - 0.5) * 1.2);

                  return Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Transform.scale(
                        scale: scale.clamp(0.2, 1.0),
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Color(0xFF4CAF50)
                                .withOpacity(0.7 - (animationValue * 0.5)),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Loading fresh products...',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF558B2F),
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomDecoration() {
    return Container(
      height: 80,
      child: Stack(
        children: [
          // Wave pattern
          Positioned.fill(
            child: CustomPaint(
              painter: WavePainter(),
            ),
          ),
          // Additional decorative elements
          Positioned(
            left: 20,
            bottom: 20,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for wave decoration
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4CAF50).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.5);

    for (double x = 0; x <= size.width; x++) {
      final y = size.height * 0.5 +
          10 * Math.sin((x / size.width) * 4 * Math.pi);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/*
// Placeholder home screen for demonstration
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DairyFresh Home'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 80,
              color: Color(0xFF4CAF50),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to DairyFresh!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your fresh dairy products are here',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF558B2F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
