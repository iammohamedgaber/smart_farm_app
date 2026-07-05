import 'dart:math' as math;
import 'package:flutter/material.dart';

class EntranceAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const EntranceAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 650),
    this.delay = Duration.zero,
  });

  @override
  State<EntranceAnimation> createState() => _EntranceAnimationState();
}

class _EntranceAnimationState extends State<EntranceAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}

class ScalePressAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool enabled;

  const ScalePressAnimation({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled = true,
  });

  @override
  State<ScalePressAnimation> createState() => _ScalePressAnimationState();
}

class _ScalePressAnimationState extends State<ScalePressAnimation>
    with SingleTickerProviderStateMixin {
  static const double _pressedScale = 0.95;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: _pressedScale,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails _) {
    if (widget.enabled) _controller.reverse();
  }

  void _handleTapUp(TapUpDetails _) {
    _controller.forward();
    if (widget.enabled && widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  void _handleTapCancel() => _controller.forward();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _controller,
        child: widget.child,
      ),
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  final Color backgroundColor;
  final Color progressColor;
  final double height;

  const LoadingAnimation({
    super.key,
    this.backgroundColor = const Color(0xFFE8F5E9),
    this.progressColor = const Color(0xFF43A047),
    this.height = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: LinearProgressIndicator(
        minHeight: height,
        backgroundColor: backgroundColor,
        color: progressColor,
      ),
    );
  }
}

class FarmBackground extends StatelessWidget {
  const FarmBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(painter: FarmBackgroundPainter()),
    );
  }
}

class FarmBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFECF7ED), Color(0xFFF4FAF5), Color(0xFFFAFFFB)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Offset.zero & size, bgPaint);

    final arcPaint = Paint()
      ..color = const Color(0xFF43A047).withOpacity(0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 40;

    for (int i = 0; i < 3; i++) {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.width + 40, -40),
          width: 260.0 + i * 90,
          height: 260.0 + i * 90,
        ),
        math.pi * 0.55,
        math.pi * 0.45,
        false,
        arcPaint,
      );
    }

    final dotPaint = Paint()
      ..color = const Color(0xFF81C784).withOpacity(0.14);

    for (int row = 0; row < 5; row++) {
      for (int col = 0; col < 4; col++) {
        canvas.drawCircle(
          Offset(16.0 + col * 22, size.height - 100 + row * 22),
          3,
          dotPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PulseAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;

  const PulseAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1200),
    this.minScale = 0.92,
    this.maxScale = 1.06,
  });

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _scale = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: widget.child,
    );
  }
}

class FloatAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double beginOffset;
  final double endOffset;

  const FloatAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 4),
    this.beginOffset = -6.0,
    this.endOffset = 6.0,
  });

  @override
  State<FloatAnimation> createState() => _FloatAnimationState();
}

class _FloatAnimationState extends State<FloatAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _float;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _float = Tween<double>(
      begin: widget.beginOffset,
      end: widget.endOffset,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _float.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class GradientAnimation extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final Duration duration;
  final Alignment begin;
  final Alignment end;

  const GradientAnimation({
    super.key,
    required this.child,
    required this.colors,
    this.duration = const Duration(seconds: 6),
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  @override
  State<GradientAnimation> createState() => _GradientAnimationState();
}

class _GradientAnimationState extends State<GradientAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _animation.value;
        final colors = _interpolateColors(widget.colors, t);
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: widget.begin,
              end: widget.end,
              colors: colors,
            ),
          ),
          child: widget.child,
        );
      },
    );
  }

  List<Color> _interpolateColors(List<Color> colors, double t) {
    if (colors.length < 3) return colors;
    final List<Color> result = [];
    for (int i = 0; i < colors.length; i++) {
      final hsl = HSLColor.fromColor(colors[i]);
      final lightness = (0.45 + 0.08 * t) * (1 - i * 0.1);
      result.add(hsl.withLightness(lightness.clamp(0.0, 1.0)).toColor());
    }
    return result;
  }
}

class RotateAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const RotateAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<RotateAnimation> createState() => _RotateAnimationState();
}

class _RotateAnimationState extends State<RotateAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
}

class SlideInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Offset beginOffset;
  final Curve curve;

  const SlideInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.beginOffset = const Offset(0, 0.1),
    this.curve = Curves.easeOut,
  });

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    _slide = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: widget.child,
    );
  }
}

class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const FadeInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOut,
  });

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    _fade = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: widget.child,
    );
  }
}

class AnimationHelper {
  static Future<void> playSequence(List<AnimationController> controllers) async {
    for (var controller in controllers) {
      await controller.forward().orCancel;
    }
  }

  static Future<void> playReverseSequence(
      List<AnimationController> controllers) async {
    for (var controller in controllers.reversed) {
      await controller.reverse().orCancel;
    }
  }

  static Future<void> playParallel(List<AnimationController> controllers) async {
    await Future.wait(controllers.map((c) => c.forward().orCancel));
  }
}

class GaugeAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const GaugeAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return child!;
      },
      child: child,
    );
  }
}

class NavBarAnimation extends StatefulWidget {
  final Widget child;
  final bool isSelected;
  final Duration duration;
  final Color selectedColor;
  final Color unselectedColor;
  final double selectedScale;
  final double unselectedScale;

  const NavBarAnimation({
    super.key,
    required this.child,
    required this.isSelected,
    this.duration = const Duration(milliseconds: 250),
    this.selectedColor = Colors.green,
    this.unselectedColor = Colors.grey,
    this.selectedScale = 1.12,
    this.unselectedScale = 1.0,
  });

  @override
  State<NavBarAnimation> createState() => _NavBarAnimationState();
}

class _NavBarAnimationState extends State<NavBarAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<Color?> _color;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scale = Tween<double>(
      begin: widget.unselectedScale,
      end: widget.selectedScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _color = ColorTween(
      begin: widget.unselectedColor,
      end: widget.selectedColor,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isSelected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant NavBarAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Transform.scale(
          scale: _scale.value,
          child: IconTheme(
            data: IconThemeData(
              color: _color.value ?? widget.unselectedColor,
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}

class StaggeredListAnimation extends StatelessWidget {
  final List<Widget> children;
  final Duration itemDelay;
  final Duration itemDuration;
  final EdgeInsetsGeometry? padding;

  const StaggeredListAnimation({
    super.key,
    required this.children,
    this.itemDelay = const Duration(milliseconds: 60),
    this.itemDuration = const Duration(milliseconds: 420),
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding,
      itemCount: children.length,
      itemBuilder: (_, i) => EntranceAnimation(
        delay: itemDelay * i,
        duration: itemDuration,
        child: children[i],
      ),
    );
  }
}

class FadePageRoute<T> extends PageRoute<T> {
  final Widget child;

  FadePageRoute({required this.child});

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 280);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    );
  }
}

class SlideUpPageRoute<T> extends PageRoute<T> {
  final Widget child;

  SlideUpPageRoute({required this.child});

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 380);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: SlideTransition(position: slide, child: child),
    );
  }
}