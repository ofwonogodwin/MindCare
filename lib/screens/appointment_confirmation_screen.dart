import 'package:flutter/material.dart';

import '../core/constants/app_routes.dart';
import '../utils/app_colors.dart';
import '../widgets/developed_by_footer.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  const AppointmentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final reference = args?['reference'] as String? ?? 'MC-000000';
    final counselor = args?['counselor'] as String? ?? 'Assigned Counselor';
    final date = args?['date'] as String? ?? 'Date pending';
    final time = args?['time'] as String? ?? 'Time pending';
    final type = args?['type'] as String? ?? 'Chat Session';

    return Scaffold(
      appBar: AppBar(title: const Text('Appointment Confirmed')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.check_circle,
                size: 72,
                color: AppColors.primaryTeal,
              ),
              const SizedBox(height: 10),
              const Text(
                'Appointment Confirmed',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 18),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reference: $reference'),
                      Text('Counselor: $counselor'),
                      Text('Date: $date'),
                      Text('Time: $time'),
                      Text('Type: $type'),
                      const Text('Duration: 50 minutes'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Before your session: Find a quiet space, keep water nearby, and take deep breaths.',
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.home,
                    (route) => false,
                  );
                },
                child: const Text('Back to Dashboard'),
              ),
              const DevelopedByFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
