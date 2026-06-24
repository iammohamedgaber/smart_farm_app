
import 'package:flutter/material.dart';
import 'package:smart_farm_app/animations/app_colors.dart';

class SoilConditionBadge extends StatelessWidget {
  final double value;

  const SoilConditionBadge({required this.value});

  String get _label {
    if (value < 20) return 'Dry';
    if (value < 40) return 'Low';
    if (value < 70) return 'Optimal';
    return 'Saturated';
  }

  Color get _color {
    if (value < 20) return AppColors.sensorOrange;
    if (value < 40) return AppColors.sensorOrange;
    if (value < 70) return AppColors.sensorGreen;
    return AppColors.sensorBlue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _color.withOpacity(0.3)),
      ),
      child: Text(
        _label,
        style: TextStyle(
          color: _color,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}