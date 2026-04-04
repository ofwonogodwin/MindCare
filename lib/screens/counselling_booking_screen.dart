import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/constants/app_routes.dart';
import '../data/repositories/mindcare_repository.dart';
import '../domain/entities/counselor.dart';
import '../utils/app_colors.dart';
import '../widgets/developed_by_footer.dart';

class CounsellingBookingScreen extends StatefulWidget {
  const CounsellingBookingScreen({super.key});

  @override
  State<CounsellingBookingScreen> createState() =>
      _CounsellingBookingScreenState();
}

class _CounsellingBookingScreenState extends State<CounsellingBookingScreen> {
  final _repository = const MindCareRepository();
  final _reasonController = TextEditingController();

  final List<String> _slots = const [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
  ];

  int _selectedCounselorId = 1;
  DateTime? _selectedDate;
  String? _selectedTime;
  String _appointmentType = 'Chat Session';

  List<Counselor> get _counselors => _repository.counselors();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
      initialDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked == null) return;
    setState(() => _selectedDate = picked);
  }

  Future<void> _bookSession() async {
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose counselor, date, and time.'),
        ),
      );
      return;
    }

    final reference = await _repository.createAppointment(
      userId: 1,
      counselorId: _selectedCounselorId,
      date: _selectedDate!,
      time: _selectedTime!,
      type: _appointmentType,
      reason: _reasonController.text.trim(),
    );

    if (!mounted) return;
    final counselor = _counselors.firstWhere(
      (item) => item.id == _selectedCounselorId,
    );

    Navigator.pushNamed(
      context,
      AppRoutes.appointmentConfirmation,
      arguments: {
        'reference': reference,
        'counselor': counselor.name,
        'date': DateFormat('EEE, MMM d').format(_selectedDate!),
        'time': _selectedTime,
        'type': _appointmentType,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final counselor = _counselors.firstWhere(
      (item) => item.id == _selectedCounselorId,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Book an Appointment')),
      backgroundColor: AppColors.backgroundWhite,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          const Text(
            'All information stays confidential.',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 10),
          const Text(
            'Select a counselor',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 170,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _counselors.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final item = _counselors[index];
                final selected = item.id == _selectedCounselorId;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCounselorId = item.id),
                  child: Container(
                    width: 220,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selected
                            ? AppColors.primaryTeal
                            : Colors.black12,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(item.specialization),
                        const SizedBox(height: 8),
                        Text(
                          item.bio,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          'Next: ${item.nextSlot}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_month_outlined),
            label: Text(
              _selectedDate == null
                  ? 'Select Date'
                  : DateFormat('EEE, MMM d').format(_selectedDate!),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Select a time slot',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _slots
                .map(
                  (slot) => ChoiceChip(
                    label: Text(slot),
                    selected: _selectedTime == slot,
                    onSelected: (_) => setState(() => _selectedTime = slot),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 14),
          const Text(
            'Appointment Type',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          RadioGroup<String>(
            groupValue: _appointmentType,
            onChanged: (value) {
              setState(() => _appointmentType = value ?? 'Chat Session');
            },
            child: const Column(
              children: [
                RadioListTile<String>(
                  title: Text('Video Call'),
                  value: 'Video Call',
                ),
                RadioListTile<String>(
                  title: Text('Chat Session'),
                  value: 'Chat Session',
                ),
                RadioListTile<String>(
                  title: Text('Phone Call'),
                  value: 'Phone Call',
                ),
              ],
            ),
          ),
          TextField(
            controller: _reasonController,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Reason for visit (optional)',
              hintText: "Briefly share what's on your mind...",
            ),
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Booking Summary',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text('Counselor: ${counselor.name}'),
                  Text(
                    'Date: ${_selectedDate == null ? 'Not selected' : DateFormat('EEE, MMM d').format(_selectedDate!)}',
                  ),
                  Text('Time: ${_selectedTime ?? 'Not selected'}'),
                  Text('Type: $_appointmentType'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _bookSession,
            child: const Text('Schedule Session'),
          ),
          const DevelopedByFooter(),
        ],
      ),
    );
  }
}
