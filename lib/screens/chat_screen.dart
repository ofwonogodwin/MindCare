import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/developed_by_footer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final List<_ChatMessage> _messages = [
    const _ChatMessage(
      sender: 'counselor',
      text: 'Hi, this chat is confidential and encrypted.',
    ),
  ];
  bool _typing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(sender: 'user', text: text));
      _controller.clear();
      _typing = true;
    });

    Timer(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _typing = false;
        _messages.add(
          const _ChatMessage(
            sender: 'counselor',
            text: 'Thank you for sharing. Let us take this one step at a time.',
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final name = args?['name'] as String? ?? 'Counselor';

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: const Color(0xFFEAF7F2),
              child: const Text('This chat is confidential and encrypted.'),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message.sender == 'user';
                  return Align(
                    alignment: isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isUser
                            ? const Color(0xFFB8E1C6)
                            : const Color(0xFFE8F1F8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(message.text),
                    ),
                  );
                },
              ),
            ),
            if (_typing)
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Counselor is typing...'),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                  ),
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

class _ChatMessage {
  const _ChatMessage({required this.sender, required this.text});

  final String sender;
  final String text;
}
