import 'package:intl/intl.dart';

import '../../domain/entities/article.dart';
import '../../domain/entities/counselor.dart';
import '../local/mindcare_database.dart';

class MindCareRepository {
  const MindCareRepository();

  List<Counselor> counselors() {
    return const [
      Counselor(
        id: 1,
        name: 'Dr. Sarah Mensah',
        specialization: 'Anxiety',
        bio: 'Licensed counselor with 8 years helping students manage stress.',
        nextSlot: 'Mon 10:00 AM',
      ),
      Counselor(
        id: 2,
        name: 'Dr. Daniel Kofi',
        specialization: 'Depression',
        bio: 'Focuses on emotional wellness and recovery planning.',
        nextSlot: 'Tue 2:00 PM',
      ),
      Counselor(
        id: 3,
        name: 'Dr. Irene Boateng',
        specialization: 'Academic Stress',
        bio: 'Supports burnout prevention and balanced routines.',
        nextSlot: 'Wed 11:00 AM',
      ),
    ];
  }

  List<Article> articles() {
    return const [
      Article(
        id: 1,
        title: 'Understanding Anxiety',
        category: 'Anxiety',
        summary: 'Learn common signs and practical coping techniques.',
        content:
            'Anxiety is a normal response to stress. Start with slow breathing, grounding, and seeking support when symptoms persist.',
        readTime: 6,
      ),
      Article(
        id: 2,
        title: '5-Minute Mindfulness Exercises',
        category: 'Mindfulness',
        summary: 'Quick grounding techniques you can do between classes.',
        content:
            'Try box breathing, body scan, and sensory grounding. Keep each exercise short and repeat throughout your day.',
        readTime: 5,
      ),
      Article(
        id: 3,
        title: 'Coping with Academic Stress',
        category: 'Stress',
        summary: 'Healthy routines for assignment-heavy weeks.',
        content:
            'Break tasks into small milestones, take movement breaks, and avoid perfectionism loops.',
        readTime: 7,
      ),
    ];
  }

  Future<String> createAppointment({
    required int userId,
    required int counselorId,
    required DateTime date,
    required String time,
    required String type,
    required String reason,
  }) async {
    final db = await MindCareDatabase.instance();
    final ref =
        'MC-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';

    await db.insert('appointments', {
      'booking_reference': ref,
      'user_id': userId,
      'counselor_id': counselorId,
      'appointment_date': DateFormat('yyyy-MM-dd').format(date),
      'appointment_time': time,
      'appointment_type': type,
      'reason': reason,
      'status': 'scheduled',
      'created_at': DateTime.now().toIso8601String(),
    });

    return ref;
  }
}
