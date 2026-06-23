import 'package:flutter/material.dart';
import 'package:smart_farm_app/animations/animations.dart';

enum ActionTileVariant { grid, full }

class ActionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final bool loading;
  final ActionTileVariant variant;

  const ActionTile({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.loading = false,
    this.variant = ActionTileVariant.grid,
  });

  @override
  Widget build(BuildContext context) {
    return ScalePressAnimation(
      enabled: !loading,
      onPressed: onPressed,
      child: switch (variant) {
        ActionTileVariant.grid => _buildGrid(),
        ActionTileVariant.full => _buildFull(),
      },
    );
  }

  Widget _buildGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.12), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _iconBadge(size: 52, iconSize: 26),
          const SizedBox(height: 12),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: loading ? Colors.grey : const Color(0xFF1A3A2A),
              fontWeight: FontWeight.w600,
              fontSize: 13.5,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFull() {
    final colors = loading
        ? [Colors.grey.shade300, Colors.grey.shade400]
        : [color, Color.lerp(color, Colors.black, 0.18)!];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: loading
            ? []
            : [
                BoxShadow(
                  color: color.withOpacity(0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBadge({required double size, required double iconSize}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: color, size: iconSize),
    );
  }
}