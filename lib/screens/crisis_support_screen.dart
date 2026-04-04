import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/constants/app_routes.dart';
import '../widgets/developed_by_footer.dart';

class CrisisSupportScreen extends StatelessWidget {
  const CrisisSupportScreen({super.key});

  Future<void> _launchPhone(String number) async {
    final uri = Uri.parse('tel:$number');
    await launchUrl(uri);
  }

  Future<void> _launchSms(String number, String text) async {
    final uri = Uri.parse('sms:$number?body=$text');
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crisis Support')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'You are not alone.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            _HotlineCard(
              title: 'National Suicide Prevention Line',
              number: '+256800123456',
              onCall: () => _launchPhone('+256800123456'),
            ),
            _HotlineCard(
              title: 'Mental Health Uganda',
              number: '+256414123456',
              onCall: () => _launchPhone('+256414123456'),
            ),
            ListTile(
              title: const Text('Crisis Text Line'),
              subtitle: const Text('Text HELP to +256700123456'),
              trailing: const Icon(Icons.sms_outlined),
              onTap: () => _launchSms('+256700123456', 'HELP'),
            ),
            const SizedBox(height: 8),
            ExpansionTile(
              title: const Text('Immediate coping strategies'),
              children: const [
                ListTile(title: Text('5-4-3-2-1 grounding technique')),
                ListTile(title: Text('Box breathing for 2 minutes')),
                ListTile(title: Text('Call a trusted support person')),
              ],
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.breathingExercise),
              child: const Text('Start Breathing Exercise'),
            ),
            const DevelopedByFooter(),
          ],
        ),
      ),
    );
  }
}

class _HotlineCard extends StatelessWidget {
  const _HotlineCard({
    required this.title,
    required this.number,
    required this.onCall,
  });

  final String title;
  final String number;
  final VoidCallback onCall;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(number),
        trailing: const Icon(Icons.call),
        onTap: onCall,
      ),
    );
  }
}
