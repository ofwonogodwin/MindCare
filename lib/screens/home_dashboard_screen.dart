import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/constants/app_routes.dart';
import '../presentation/controllers/app_session_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/developed_by_footer.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _selectedBottomIndex = 0;
  int? _selectedMood;
  String _displayName = 'there';

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final name = await AppSessionController.displayName();
    if (!mounted) return;
    setState(() => _displayName = name);
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(title: const Text('MindCare Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$_greeting, $_displayName',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat.yMMMMEEEEd().format(DateTime.now()),
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 10),
            const Text(
              'You are not alone. Every step counts.',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const Text(
              'All conversations are private.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Card(
              color: AppColors.accentGreen.withValues(alpha: 0.55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.mood,
                          color: AppColors.primaryTeal,
                          size: 30,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'How are you feeling today?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: [
                        _MoodChip(
                          index: 5,
                          label: 'Great',
                          selectedMood: _selectedMood,
                          onSelected: (value) =>
                              setState(() => _selectedMood = value),
                        ),
                        _MoodChip(
                          index: 4,
                          label: 'Okay',
                          selectedMood: _selectedMood,
                          onSelected: (value) =>
                              setState(() => _selectedMood = value),
                        ),
                        _MoodChip(
                          index: 3,
                          label: 'Neutral',
                          selectedMood: _selectedMood,
                          onSelected: (value) =>
                              setState(() => _selectedMood = value),
                        ),
                        _MoodChip(
                          index: 2,
                          label: 'Low',
                          selectedMood: _selectedMood,
                          onSelected: (value) =>
                              setState(() => _selectedMood = value),
                        ),
                        _MoodChip(
                          index: 1,
                          label: 'Struggling',
                          selectedMood: _selectedMood,
                          onSelected: (value) =>
                              setState(() => _selectedMood = value),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoutes.moodTracker),
                        child: const Text('Open full mood tracker'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Quick Access',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.05,
              children: [
                _QuickCard(
                  title: 'Book Session',
                  icon: Icons.calendar_today_outlined,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.booking),
                ),
                _QuickCard(
                  title: 'Talk to Counselor',
                  icon: Icons.support_agent_outlined,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.chatList),
                ),
                _QuickCard(
                  title: 'Self Help Resources',
                  icon: Icons.menu_book_outlined,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.resources),
                ),
                _QuickCard(
                  title: 'Emergency Support',
                  icon: Icons.emergency_outlined,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.crisisSupport),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ExpansionTile(
              title: const Text('Need immediate help?'),
              children: [
                ListTile(
                  title: const Text('National Suicide Prevention Line'),
                  subtitle: const Text('+256 (0) 800 123 456'),
                  trailing: const Icon(Icons.call_outlined),
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.crisisSupport),
                ),
                ListTile(
                  title: const Text('Open Crisis Support Tools'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.crisisSupport),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Upcoming appointment: Tue 2:00 PM'),
              subtitle: Text('Dr. Daniel Kofi'),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Unread message from Dr. Sarah Mensah'),
              subtitle: Text('Tap Talk to Counselor to open.'),
            ),
            Card(
              color: const Color(0xFFEAF6FB),
              child: const Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  '“You are stronger than you think, and help is always available.”',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const SizedBox(height: 22),
            const Center(child: DevelopedByFooter()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomIndex,
        onTap: (index) {
          setState(() => _selectedBottomIndex = index);
          switch (index) {
            case 1:
              Navigator.pushNamed(context, AppRoutes.booking);
              break;
            case 2:
              Navigator.pushNamed(context, AppRoutes.chatList);
              break;
            case 3:
              Navigator.pushNamed(context, AppRoutes.moodTracker);
              break;
            case 4:
              Navigator.pushNamed(context, AppRoutes.profile);
              break;
            default:
              break;
          }
        },
        selectedItemColor: AppColors.primaryTeal,
        unselectedItemColor: Colors.black45,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Mood',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  const _QuickCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.secondaryBlue.withValues(alpha: 0.4),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.secondaryBlue.withValues(
                    alpha: 0.25,
                  ),
                  child: Icon(icon, color: AppColors.primaryTeal),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MoodChip extends StatelessWidget {
  const _MoodChip({
    required this.index,
    required this.label,
    required this.selectedMood,
    required this.onSelected,
  });

  final int index;
  final String label;
  final int? selectedMood;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selectedMood == index,
      onSelected: (_) => onSelected(index),
    );
  }
}
