import 'package:flutter/material.dart';
import 'package:smart_farm_app/core/utils/user_storage.dart';
import 'package:smart_farm_app/presentation/auth/view/login_page.dart';
import 'package:smart_farm_app/presentation/main_layout.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _floatController;
  late final AnimationController _gradientController;
  late final Animation<double> _pulse;
  late final Animation<double> _float;
  late final Animation<double> _gradientAnim;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _pulse = Tween<double>(begin: 0.92, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _float = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
    _floatController.repeat(reverse: true);

    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );
    _gradientAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _gradientController, curve: Curves.linear),
    );
    _gradientController.repeat();

    Future.delayed(const Duration(milliseconds: 450), checkUser);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  Future<void> checkUser() async {
    final id = await UserStorage.getUserId();
    await Future.delayed(const Duration(seconds: 1, milliseconds: 200));
    if (!mounted) return;

    if (id != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainLayout()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  List<Color> _animatedGradientColors(double t, Color base) {
    final c1 = HSLColor.fromColor(
      base,
    ).withLightness((0.45 + 0.08 * t)).toColor();
    final c2 = HSLColor.fromColor(
      base,
    ).withLightness((0.30 + 0.12 * (1 - t))).toColor();
    final c3 = HSLColor.fromColor(
      base,
    ).withLightness((0.60 - 0.10 * t)).toColor();
    return [c1, c2, c3];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final base = Colors.green; // ✅ الخلفية الأساسية أخضر
    final bg = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bg,
      body: AnimatedBuilder(
        animation: _gradientController,
        builder: (context, _) {
          final t = _gradientAnim.value;
          final colors = _animatedGradientColors(t, base);

          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.8 + 1.6 * t, -1),
                      end: Alignment(0.8 - 1.6 * t, 1),
                      colors: colors,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.28,
                child: ScaleTransition(
                  scale: _pulse,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          base.withOpacity(0.22),
                          base.withOpacity(0.06),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.45, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _floatController,
                    builder: (context, _) {
                      final offset = _float.value;
                      return Stack(
                        children: [
                          _floatingLeaf(
                            left: 40,
                            top: 120 + offset,
                            size: 28,
                            angle: -0.25,
                            opacity: 0.9,
                          ),
                          _floatingLeaf(
                            right: 40,
                            top: 160 - offset,
                            size: 22,
                            angle: 0.18,
                            opacity: 0.75,
                          ),
                          _floatingLeaf(
                            left: 18,
                            bottom: 120 + offset,
                            size: 20,
                            angle: 0.35,
                            opacity: 0.6,
                          ),
                          _floatingLeaf(
                            right: 18,
                            bottom: 140 - offset,
                            size: 26,
                            angle: -0.18,
                            opacity: 0.7,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.22,
                child: ScaleTransition(
                  scale: _pulse,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          base.withOpacity(0.98),
                          base.withOpacity(0.75),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: base.withOpacity(0.28),
                          blurRadius: 26,
                          offset: const Offset(0, 12),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                        width: 1.4,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'SF',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.6,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.52,
                child: FadeTransition(
                  opacity: _pulseController.drive(
                    Tween(
                      begin: 0.0,
                      end: 1.0,
                    ).chain(CurveTween(curve: Curves.easeIn)),
                  ),
                  child: Column(
                    children: [
                      _shimmerText('Smart Farm', theme),
                      const SizedBox(height: 8),
                      Text(
                        'Manage your farm smarter',
                        style: TextStyle(
                          color: theme.brightness == Brightness.dark
                              ? Colors.white70
                              : Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Positioned(
                bottom: 48,
                child: SizedBox(
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: LinearProgressIndicator(minHeight: 6),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _floatingLeaf({
    double? left,
    double? right,
    double? top,
    double? bottom,
    required double size,
    required double angle,
    required double opacity,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Transform.rotate(
        angle: angle,
        child: Icon(
          Icons.eco,
          size: size,
          color: Colors.white.withOpacity(opacity),
        ),
      ),
    );
  }

  Widget _shimmerText(String text, ThemeData theme) {
    return const Text(
      'Smart Farm',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
    );
  }
}
