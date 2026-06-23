import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String text;
  final Color accentColor;
  final Color textColor;

  const SectionLabel(
    this.text, {
    super.key,
    required this.accentColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: textColor,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}