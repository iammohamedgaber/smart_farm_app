import 'package:flutter/material.dart';
import 'package:smart_farm_app/animations/app_colors.dart';

class StatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const StatItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.sensorTextLight,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: AppColors.sensorTextLight.withOpacity(0.4),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
