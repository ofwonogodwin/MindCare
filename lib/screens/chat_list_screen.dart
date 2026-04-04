import 'package:flutter/material.dart';

import '../core/constants/app_routes.dart';
import '../utils/app_colors.dart';
import '../widgets/developed_by_footer.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = const [
      ('Dr. Sarah Mensah', 'How have you been feeling today?', '10:24 AM', 2),
      ('Dr. Daniel Kofi', 'Remember your breathing routine.', 'Yesterday', 0),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Messages'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Archived'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final item = chats[index];
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: AppColors.secondaryBlue,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(item.$1),
                        subtitle: Text(item.$2),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item.$3, style: const TextStyle(fontSize: 12)),
                            if (item.$4 > 0)
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: AppColors.primaryTeal,
                                child: Text(
                                  '${item.$4}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.chat,
                          arguments: {'name': item.$1},
                        ),
                      );
                    },
                  ),
                  const Center(child: Text('No archived conversations yet.')),
                ],
              ),
            ),
            const DevelopedByFooter(),
          ],
        ),
      ),
    );
  }
}
