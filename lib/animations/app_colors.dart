import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF1B5E20);
  static const Color primarySurface = Color(0xFFE8F5EE);

  static const Color secondary = Color(0xFF4CAF50);
  static const Color secondaryLight = Color(0xFFE8F5E9);

  static const Color success = Color(0xFF4CAF50);
  static const Color successSurface = Color(0xFFE8F5E9);
  static const Color successBorder = Color(0xFFA5D6A7);

  static const Color warning = Color(0xFFEF6C00);
  static const Color warningSurface = Color(0xFFFEF3DC);
  static const Color warningBorder = Color(0xFFFFCC80);

  static const Color error = Color(0xFFD32F2F);
  static const Color errorSurface = Color(0xFFFDECEA);
  static const Color errorBorder = Color(0xFFEF9A9A);

  static const Color info = Color(0xFF1E88E5);
  static const Color infoSurface = Color(0xFFDEEEF8);
  static const Color infoBorder = Color(0xFF90CAF9);

  static const Color green500 = primary;
  static const Color green700 = primaryDark;
  static const Color green900 = Color(0xFF1B5E20);
  static const Color green100 = Color(0xFFE8F5E9);
  static const Color orange = warning;
  static const Color blue = info;
  static const Color red = error;
  static const Color teal = Color(0xFF00796B);
  static const Color purple = Color(0xFF6A1B9A);

  static const Color background = Color(0xFFF4F7F5);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF1F8F2);
  static const Color surfaceElevated = Color(0xFFFAFCFB);

  static const Color selectCropBackground = Color(0xFFF4F7FA);
  static const Color zonesBackground = Color(0xFFF0F7F0);
  static const Color splashBackground = Color(0xFFF4F7FA);
  static const Color dropdownFill = Color(0xFFF1F4F8);

  static const Color sensorBackground = Color(0xFF0A2E1F);
  static const Color sensorGreen = Color(0xFF1DB860);
  static const Color sensorLightGreen = Color(0xFF6EE7A0);
  static const Color sensorOrange = Color(0xFFFF6B4A);
  static const Color sensorBlue = Color(0xFF4A9EFF);
  static const Color sensorTextLight = Color(0xFFF0F4F0);
  static const Color sensorYellow = Color(0xFFF4B942);

  static const Color border = Color(0xFFCBE8CE);
  static const Color borderSubtle = Color(0xFFEEF4F0);
  static const Color divider = Color(0xFFDCEEDD);

  static const Color textPrimary = Color(0xFF1A3A2A);
  static const Color textSecondary = Color(0xFF78909C);
  static const Color textLight = Color(0xFFB0BEC5);
  static const Color textDark = Color(0xFF1A3A2A);
  static const Color textOnPrimary = Colors.white;
  static const Color textOnDark = Colors.white;
  static const Color black87 = Colors.black87;
  static const Color black12 = Colors.black12;

  static const Color navBarDark = Color(0xFF0D1F2D);
  static const Color navBarLight = Color(0xFFF8FAFB);
  static const Color navBarSelected = Color(0xFF4CAF50);
  static const Color navBarUnselected = Color(0xFF78909C);
  static const Color navBarShadow = Color(0xFF0A2E1F);

  static const Color white = Colors.white;
  static const Color white24 = Colors.white24;
  static const Color transparent = Colors.transparent;

  static const LinearGradient appBarGradient = LinearGradient(
    colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient cardAccentGradient = LinearGradient(
    colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sensorNavGradient = LinearGradient(
    colors: [Color(0xFF0A2E1F), Color(0xFF1B5E20)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0xFF2E7D32).withOpacity(0.08),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 6),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Color(0xFF2E7D32).withOpacity(0.14),
      blurRadius: 32,
      spreadRadius: 0,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: Color(0xFF2E7D32).withOpacity(0.35),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> navShadow = [
    BoxShadow(
      color: Color(0xFF0A2E1F).withOpacity(0.25),
      blurRadius: 25,
      offset: const Offset(0, -8),
    ),
    BoxShadow(
      color: Color(0xFF0A2E1F).withOpacity(0.10),
      blurRadius: 40,
      offset: const Offset(0, -15),
    ),
  ];

  static const LinearGradient lightGreenGradient = LinearGradient(
    colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9), Color(0xFFA5D6A7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient softGreenGradient = LinearGradient(
    colors: [Color(0xFFF4F9F5), Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient neutralGreenGradient = LinearGradient(
    colors: [Color(0xFFF4F7F9), Color(0xFFF0F5F5), Color(0xFFE8F5E9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}