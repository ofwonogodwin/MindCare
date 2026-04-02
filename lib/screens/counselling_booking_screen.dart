import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CounsellingBookingScreen extends StatefulWidget {
  const CounsellingBookingScreen({super.key});

  @override
  State<CounsellingBookingScreen> createState() =>
      _CounsellingBookingScreenState();
}

class _CounsellingBookingScreenState extends State<CounsellingBookingScreen> {
  final List<Counsellor> _counsellors = const [
    Counsellor(
      name: 'Dr. Sarah Mensah',
      specialty: 'Anxiety & Stress Management',
      dates: ['Apr 05', 'Apr 07', 'Apr 10'],
    ),
    Counsellor(
      name: 'Dr. Daniel Kofi',
      specialty: 'Academic Burnout Support',
      dates: ['Apr 06', 'Apr 09', 'Apr 11'],
    ),
    Counsellor(
      name: 'Dr. Irene Boateng',
      specialty: 'Relationship & Emotional Wellness',
      dates: ['Apr 08', 'Apr 12', 'Apr 14'],
    ),
  ];

  String? _selectedCounsellor;
  String? _selectedDate;

  void _bookSession() {
    if (_selectedCounsellor == null || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose a counselor and a date first.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Session booked with $_selectedCounsellor on $_selectedDate.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counselling Booking')),
      backgroundColor: AppColors.backgroundWhite,
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
        itemCount: _counsellors.length,
        itemBuilder: (context, index) {
          final counsellor = _counsellors[index];
          final isSelected = _selectedCounsellor == counsellor.name;

          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: isSelected
                    ? AppColors.primaryTeal
                    : AppColors.secondaryBlue.withValues(alpha: 0.35),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.accentGreen.withValues(
                          alpha: 0.5,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.primaryTeal,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              counsellor.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              counsellor.specialty,
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Available Dates',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: counsellor.dates.map((date) {
                      final selectedForDate =
                          isSelected && _selectedDate == date;
                      return ChoiceChip(
                        label: Text(date),
                        selected: selectedForDate,
                        onSelected: (_) {
                          setState(() {
                            _selectedCounsellor = counsellor.name;
                            _selectedDate = date;
                          });
                        },
                        selectedColor: AppColors.secondaryBlue.withValues(
                          alpha: 0.4,
                        ),
                        labelStyle: TextStyle(
                          color: selectedForDate
                              ? AppColors.primaryTeal
                              : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _bookSession,
              icon: const Icon(Icons.event_available_outlined),
              label: const Text('Book Session'),
            ),
          ),
        ),
      ),
    );
  }
}

class Counsellor {
  const Counsellor({
    required this.name,
    required this.specialty,
    required this.dates,
  });

  final String name;
  final String specialty;
  final List<String> dates;
}
