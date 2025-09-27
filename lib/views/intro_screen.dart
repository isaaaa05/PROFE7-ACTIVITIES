import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'main_navigation.dart';
import '../widgets/custom_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD2B48C), Color(0xFF8B4513)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(70),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 25,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 70,
                  color: Colors.white,
                ),
              )
                  .animate()
                  .scale(duration: 1000.ms, curve: Curves.elasticOut)
                  .then()
                  .shimmer(
                      duration: 2000.ms,
                      color: Colors.white.withValues(alpha: 0.3)),

              const SizedBox(height: 50),

              // Title
              const Text(
                'Party Glow',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B4513),
                  letterSpacing: 1.2,
                ),
              ).animate().slideY(begin: 0.3, duration: 800.ms).fadeIn(),

              const SizedBox(height: 16),

              // Subtitle
              Text(
                'Illuminate your celebrations with our premium decoration services',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF8B4513).withValues(alpha: 0.7),
                  height: 1.6,
                  letterSpacing: 0.5,
                ),
              ).animate().slideY(begin: 0.3, duration: 1000.ms).fadeIn(),

              const SizedBox(height: 80),

              // Get Started Button
              CustomButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const MainNavigation(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
                isPrimary: true,
                width: double.infinity,
                icon: Icons.arrow_forward,
              ).animate().slideY(begin: 0.5, duration: 1200.ms).fadeIn(),

              const SizedBox(height: 40),

              // Features Preview
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFeatureItem(Icons.design_services, 'Custom Design'),
                  _buildFeatureItem(Icons.schedule, 'Quick Setup'),
                  _buildFeatureItem(Icons.star, 'Premium Quality'),
                ],
              ).animate().slideY(begin: 0.3, duration: 1400.ms).fadeIn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: const Color(0xFF8B4513),
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: const Color(0xFF8B4513).withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
