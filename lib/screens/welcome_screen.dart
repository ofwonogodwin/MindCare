import 'package:flutter/material.dart';

import '../core/constants/app_routes.dart';
import '../presentation/controllers/app_session_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/developed_by_footer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> _goToSignup(BuildContext context) async {
    await AppSessionController.completeWelcome();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.signup);
  }

  Future<void> _goToLogin(BuildContext context) async {
    await AppSessionController.completeWelcome();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.login);
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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),
                const Icon(
                  Icons.spa_outlined,
                  size: 84,
                  color: AppColors.primaryTeal,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome to MindCare',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Confidential Support',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'Licensed Counselors',
                  style: TextStyle(fontSize: 16),
                ),
                const Text('Your Safe Space', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () => _goToSignup(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentGreen,
                    foregroundColor: AppColors.textDark,
                  ),
                  child: const Text('Get Started'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => _goToLogin(context),
                  child: const Text('I already have an account'),
                ),
                const Spacer(),
                const DevelopedByFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
