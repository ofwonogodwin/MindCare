import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/developed_by_footer.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  int? _selectedMood;
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final moods = const [
      (5, 'Great', '😀'),
      (4, 'Good', '🙂'),
      (3, 'Neutral', '😐'),
      (2, 'Low', '😔'),
      (1, 'Struggling', '😣'),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('How are you feeling?'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Week'),
              Tab(text: 'Month'),
              Tab(text: 'Trends'),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today • ${DateFormat.yMMMMd().format(DateTime.now())}',
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: moods.map((mood) {
                        return ChoiceChip(
                          label: Text('${mood.$3} ${mood.$2}'),
                          selected: _selectedMood == mood.$1,
                          onSelected: (_) =>
                              setState(() => _selectedMood = mood.$1),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _noteController,
                      decoration: const InputDecoration(
                        hintText: "What's contributing to this feeling?",
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    _SimpleChart(title: 'Weekly Mood View'),
                    _SimpleChart(title: 'Monthly Mood Grid'),
                    _SimpleChart(title: 'Mood Trends'),
                  ],
                ),
              ),
              const DevelopedByFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SimpleChart extends StatelessWidget {
  const _SimpleChart({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Center(
          child: Text(
            '$title\n(Mock prototype visualization)',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
