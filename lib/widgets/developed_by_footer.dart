import 'package:flutter/material.dart';

class DevelopedByFooter extends StatelessWidget {
  const DevelopedByFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 8, bottom: 12),
      child: Center(
        child: Text(
          'Developed by Godwin Ofwono',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
