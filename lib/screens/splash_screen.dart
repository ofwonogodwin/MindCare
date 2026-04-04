import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/constants/app_routes.dart';
import '../presentation/controllers/app_session_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/developed_by_footer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final SystemUiMode _previousMode;

  @override
  void initState() {
    super.initState();
    _previousMode = SystemUiMode.edgeToEdge;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    Future<void>.delayed(const Duration(milliseconds: 2500), () async {
      if (!mounted) return;
      final isLoggedIn = await AppSessionController.isLoggedIn();
      final shouldShowWelcome = await AppSessionController.shouldShowWelcome();
      if (!mounted) return;

      if (shouldShowWelcome) {
        Navigator.pushReplacementNamed(context, AppRoutes.welcome);
        return;
      }

      Navigator.pushReplacementNamed(
        context,
        isLoggedIn ? AppRoutes.home : AppRoutes.login,
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(_previousMode);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEAF6FB), Color(0xFFE8F6EE)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundColor: AppColors.accentGreen,
                      child: Icon(
                        Icons.favorite_rounded,
                        color: AppColors.primaryTeal,
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'MindCare',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondaryBlue,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your Safe Space for Mental Wellness',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryTeal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(strokeWidth: 3),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const DevelopedByFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
