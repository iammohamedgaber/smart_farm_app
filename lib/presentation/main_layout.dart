import 'package:flutter/material.dart';
import 'package:smart_farm_app/animations/animations.dart';
import 'package:smart_farm_app/animations/app_colors.dart';
import 'package:smart_farm_app/presentation/sensors/view/SensorsScreen.dart';
import 'package:smart_farm_app/presentation/operations/view/operations_page.dart';
import 'package:smart_farm_app/presentation/profile/view/profile_page.dart';
import 'package:smart_farm_app/presentation/zones/view/camera_page.dart';
import 'package:smart_farm_app/presentation/zones/view/zones_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with TickerProviderStateMixin {
  int currentIndex = 0;
  late final AnimationController _glowController;
  late final PageController _pageController;

  final List<Widget> pages = const [
    ZonesPage(),
    SensorPage(),
    CameraPage(),
    OperationsPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _glowController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: EntranceAnimation(
        duration: const Duration(milliseconds: 400),
        child: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: pages,
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A2E1F), Color(0xFF145C37), Color(0xFF27AE60)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.navBarShadow.withOpacity(0.25),
            blurRadius: 25,
            offset: const Offset(0, -8),
          ),
          BoxShadow(
            color: AppColors.navBarShadow.withOpacity(0.10),
            blurRadius: 40,
            offset: const Offset(0, -15),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              final isSelected = currentIndex == index;
              return _buildNavItem(
                icon: _getIcon(index),
                label: _getLabel(index),
                index: index,
                isSelected: isSelected,
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: isSelected ? 10 : 6,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColors.navBarSelected.withOpacity(0.15),
                    AppColors.navBarSelected.withOpacity(0.04),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(
                  color: AppColors.navBarSelected.withOpacity(0.20),
                  width: 1.2,
                )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) {
                final glow = _glowController.value;
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.navBarSelected.withOpacity(
                                0.30 * glow,
                              ),
                              blurRadius: 20,
                              spreadRadius: 3,
                            ),
                          ]
                        : [],
                  ),
                  child: Transform.scale(
                    scale: isSelected ? 1.0 + (0.08 * glow) : 1.0,
                    child: Icon(
                      icon,
                      color: isSelected
                          ? AppColors.navBarSelected
                          : AppColors.navBarUnselected,
                      size: isSelected ? 32 : 26,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              style: TextStyle(
                color: isSelected
                    ? AppColors.navBarSelected
                    : AppColors.navBarUnselected,
                fontSize: isSelected ? 13 : 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: isSelected ? 0.5 : 0.3,
                shadows: isSelected
                    ? [
                        Shadow(
                          color: AppColors.navBarSelected.withOpacity(0.3),
                          blurRadius: 8,
                        ),
                      ]
                    : [],
              ),
              child: Text(label),
            ),
            if (isSelected)
              AnimatedBuilder(
                animation: _glowController,
                builder: (context, _) {
                  final glow = _glowController.value;
                  return Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 22 + (10 * glow),
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.navBarSelected,
                          AppColors.navBarSelected.withOpacity(0.1),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                },
              )
            else
              const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(int index) {
    const icons = [
      Icons.grass_rounded,
      Icons.sensors_rounded,
      Icons.videocam_rounded,
      Icons.history_rounded,
      Icons.person_rounded,
    ];
    return icons[index];
  }

  String _getLabel(int index) {
    const labels = ['Zones', 'Sensors', 'Camera', 'Ops', 'Profile'];
    return labels[index];
  }
}
