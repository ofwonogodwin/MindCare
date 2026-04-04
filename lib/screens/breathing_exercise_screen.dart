import 'package:flutter/material.dart';

import '../widgets/developed_by_footer.dart';

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() =>
      _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  String _phase = 'Breathe in';
  String _preset = '4-7-8 Breathing';

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat(reverse: true)
          ..addListener(() {
            final value = _controller.value;
            setState(() {
              if (value < 0.33) {
                _phase = 'Breathe in';
              } else if (value < 0.66) {
                _phase = 'Hold';
              } else {
                _phase = 'Breathe out';
              }
            });
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const presets = [
      '4-7-8 Breathing',
      'Box Breathing',
      'Deep Breathing',
      'Calming Breath',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Breathing Exercise')),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Take a moment to breathe',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final size = 120 + (_controller.value * 80);
                return Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    color: Color(0xFFB8E1C6),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(_phase, textAlign: TextAlign.center),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              children: presets
                  .map(
                    (preset) => ChoiceChip(
                      label: Text(preset),
                      selected: _preset == preset,
                      onSelected: (_) => setState(() => _preset = preset),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Text('Duration: 1, 3, or 5 minutes'),
            const Spacer(),
            const DevelopedByFooter(),
          ],
        ),
      ),
    );
  }
}
