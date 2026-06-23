import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:smart_farm_app/animations/app_colors.dart';

class SensorGauge extends StatelessWidget {
  final double value;
  final double maxValue;
  final String label;
  final String unit;
  final Color color;
  final IconData icon;
  final bool compact;
  final bool isLoading;

  const SensorGauge({
    Key? key,
    required this.value,
    required this.maxValue,
    required this.label,
    required this.unit,
    required this.color,
    required this.icon,
    this.compact = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double pct = (value / maxValue).clamp(0.0, 1.0);
    final double size = compact ? 72.0 : 120.0;
    final double strokeWidth = compact ? 7.0 : 11.0;
    final double valueFontSize = compact ? 15.0 : 24.0;
    final double unitFontSize = compact ? 9.0 : 13.0;
    final double iconSize = compact ? 14.0 : 20.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isLoading
            ? _buildLoadingState(size, strokeWidth, iconSize)
            : _buildGauge(
                size: size,
                strokeWidth: strokeWidth,
                valueFontSize: valueFontSize,
                unitFontSize: unitFontSize,
                iconSize: iconSize,
                pct: pct,
              ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: compact ? 12.0 : 14.0,
            fontWeight: FontWeight.w500,
            color: AppColors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildGauge({
    required double size,
    required double strokeWidth,
    required double valueFontSize,
    required double unitFontSize,
    required double iconSize,
    required double pct,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: pct),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      builder: (context, animPct, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: _ArcPainter(
                  progress: 1.0,
                  color: AppColors.white.withOpacity(0.1),
                  strokeWidth: strokeWidth,
                ),
              ),
            ),

            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: _ArcPainter(
                  progress: animPct,
                  color: color,
                  strokeWidth: strokeWidth,
                  withGradient: true,
                  gradientColors: [color.withOpacity(0.5), color],
                ),
              ),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: iconSize),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: (animPct * maxValue).toStringAsFixed(1),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: valueFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: unit,
                        style: TextStyle(
                          color: AppColors.white.withOpacity(0.6),
                          fontSize: unitFontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoadingState(double size, double strokeWidth, double iconSize) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: _ArcPainter(
              progress: 1.0,
              color: AppColors.white.withOpacity(0.05),
              strokeWidth: strokeWidth,
            ),
          ),
          SizedBox(
            width: size * 0.85,
            height: size * 0.85,
            child: CircularProgressIndicator(
              color: color,
              strokeWidth: strokeWidth * 0.6,
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            builder: (context, scale, _) {
              return Transform.scale(
                scale: scale,
                child: Icon(
                  icon,
                  color: color.withOpacity(0.6),
                  size: iconSize,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final bool withGradient;
  final List<Color>? gradientColors;

  const _ArcPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    this.withGradient = false,
    this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double startAngle = 135 * (math.pi / 180);
    const double sweepTotal = 270 * (math.pi / 180);

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (withGradient && gradientColors != null && progress > 0) {
      final gradient = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepTotal * progress,
        colors: gradientColors!,
      );
      paint.shader = gradient.createShader(rect);
    } else {
      paint.color = color;
    }

    canvas.drawArc(rect, startAngle, sweepTotal * progress, false, paint);
  }

  @override
  bool shouldRepaint(covariant _ArcPainter old) =>
      old.progress != progress || old.color != color;
}
