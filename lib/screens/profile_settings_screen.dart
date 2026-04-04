import 'package:flutter/material.dart';

import '../core/constants/app_routes.dart';
import '../presentation/controllers/app_session_controller.dart';
import '../widgets/developed_by_footer.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool _anonymousMode = false;
  bool _dataSharing = false;
  bool _appointmentNotifications = true;
  bool _messageNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person_outline)),
              title: Text('Godwin'),
              subtitle: Text('Member since 2026'),
            ),
            const SizedBox(height: 12),
            const Text(
              'Privacy & Security',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SwitchListTile(
              value: _anonymousMode,
              title: const Text('Anonymous mode'),
              onChanged: (value) => setState(() => _anonymousMode = value),
            ),
            SwitchListTile(
              value: _dataSharing,
              title: const Text('Data sharing consent'),
              onChanged: (value) => setState(() => _dataSharing = value),
            ),
            ListTile(
              title: const Text('Clear chat history'),
              trailing: const Icon(Icons.delete_outline),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Chat history cleared (prototype).'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            const Text(
              'Notifications',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SwitchListTile(
              value: _appointmentNotifications,
              title: const Text('Appointment reminders'),
              onChanged: (value) =>
                  setState(() => _appointmentNotifications = value),
            ),
            SwitchListTile(
              value: _messageNotifications,
              title: const Text('Message notifications'),
              onChanged: (value) =>
                  setState(() => _messageNotifications = value),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () async {
                await AppSessionController.logout();
                if (!context.mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
            const DevelopedByFooter(),
          ],
        ),
      ),
    );
  }
}
