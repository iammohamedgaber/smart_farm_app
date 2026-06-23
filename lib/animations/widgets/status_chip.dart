import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final bool hasCrop;

  const StatusChip({super.key, required this.hasCrop});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(hasCrop ? 0.22 : 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Text(
        hasCrop ? "Active" : "Empty",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}