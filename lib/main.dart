import 'package:flutter/material.dart';

import 'core/constants/app_routes.dart';
import 'screens/appointment_confirmation_screen.dart';
import 'screens/article_detail_screen.dart';
import 'screens/breathing_exercise_screen.dart';
import 'screens/chat_list_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/counselling_booking_screen.dart';
import 'screens/crisis_support_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/mood_tracker_screen.dart';
import 'screens/profile_settings_screen.dart';
import 'screens/resources_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const MindCareApp());
}

class MindCareApp extends StatelessWidget {
  const MindCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryTeal,
      primary: AppColors.primaryTeal,
      secondary: AppColors.secondaryBlue,
      surface: Colors.white,
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindCare',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundWhite,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundWhite,
          foregroundColor: AppColors.textDark,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF6FAFA),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.primaryTeal,
              width: 1.2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryTeal,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          margin: EdgeInsets.zero,
        ),
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.welcome: (_) => const WelcomeScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.signup: (_) => const SignupScreen(),
        AppRoutes.home: (_) => const HomeDashboardScreen(),
        AppRoutes.booking: (_) => const CounsellingBookingScreen(),
        AppRoutes.appointmentConfirmation: (_) =>
            const AppointmentConfirmationScreen(),
        AppRoutes.chatList: (_) => const ChatListScreen(),
        AppRoutes.chat: (_) => const ChatScreen(),
        AppRoutes.moodTracker: (_) => const MoodTrackerScreen(),
        AppRoutes.resources: (_) => const ResourcesScreen(),
        AppRoutes.articleDetail: (_) => const ArticleDetailScreen(),
        AppRoutes.profile: (_) => const ProfileSettingsScreen(),
        AppRoutes.crisisSupport: (_) => const CrisisSupportScreen(),
        AppRoutes.breathingExercise: (_) => const BreathingExerciseScreen(),
      },
    );
  }
}
