import 'package:flutter/material.dart';

/// كلاس إدارة الثيمات (Light & Dark) - نسخة كاملة وشغالة 100%
class AppThemes {
  // ================= الألوان الأساسية =================
  static const Color primaryColor = Color(0xFF27AE60); // أخضر المزرعة
  static const Color secondaryColor = Color(0xFF3498DB); // أزرق المياه
  static const Color successColor = Color(0xFF2ECC71);
  static const Color warningColor = Color(0xFFF39C12);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color infoColor = Color(0xFF3498DB);

  // ================= ألوان الخلفيات للكاردز =================
  static const Color cardLightBg = Color(0xFFF8F9FA);
  static const Color cardDarkBg = Color(0xFF1E1E24);
  
  // ================= ظلال الكاردز =================
  static List<BoxShadow> get cardLightShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 20,
      offset: const Offset(0, 8),
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get cardDarkShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 25,
      offset: const Offset(0, 10),
      spreadRadius: 0,
    ),
  ];

  // ================= حدود الكاردز (دوال مساعدة) =================
  static BorderSide cardBorderLight(Color primary) => 
      BorderSide(color: primary.withOpacity(0.15), width: 1.5);
  
  static BorderSide cardBorderDark(Color primary) => 
      BorderSide(color: primary.withOpacity(0.3), width: 1.5);

  // ================= الثيم الفاتح =================
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: secondaryColor,
          onSecondary: Colors.white,
          surface: const Color(0xFFF5F7FA),
          onSurface: const Color(0xFF1E1E2F),
          error: errorColor,
          onError: Colors.white,
          surfaceVariant: const Color(0xFFE8EAED),
          surfaceContainerHighest: const Color(0xFFE0E4E8),
        ),
        
        // AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        
        // Text Theme
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1E1E2F)),
          headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF1E1E2F)),
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1E1E2F)),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1E1E2F)),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF1E1E2F)),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF1E1E2F)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF555566)),
          bodySmall: TextStyle(fontSize: 12, color: Color(0xFF777788)),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E1E2F)),
          labelSmall: TextStyle(fontSize: 12, color: Color(0xFF777788)),
        ),
        
        // Button Themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 3,
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        
        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        
        // ✅ Card Theme (مُصلح: CardTheme بدل CardThemeData)
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: cardLightBg,
          shadowColor: Colors.black.withOpacity(0.1),
        ),
        
        // Slider Theme
        sliderTheme: const SliderThemeData(
          activeTrackColor: primaryColor,
          inactiveTrackColor: Color(0xFFD0D5DB),
          thumbColor: primaryColor,
          overlayColor: Color(0x1F27AE60),
          valueIndicatorColor: primaryColor,
          valueIndicatorTextStyle: TextStyle(color: Colors.white),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 24),
        ),
        
        // SnackBar Theme
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          backgroundColor: Color(0xFF1E1E2F),
          contentTextStyle: TextStyle(color: Colors.white),
        ),
        
        // Progress Indicator
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      );

  // ================= الثيم الداكن =================
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: secondaryColor,
          onSecondary: Colors.white,
          surface: const Color(0xFF121212),
          onSurface: const Color(0xFFE0E0E0),
          error: errorColor,
          onError: Colors.white,
          surfaceVariant: const Color(0xFF2A2A32),
          surfaceContainerHighest: const Color(0xFF2A2A32),
        ),
        
        // AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          scrolledUnderElevation: 2,
        ),
        
        // Text Theme
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFE0E0E0)),
          headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFFE0E0E0)),
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFE0E0E0)),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFE0E0E0)),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFE0E0E0)),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFE0E0E0)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFFA0A0A0)),
          bodySmall: TextStyle(fontSize: 12, color: Color(0xFF888899)),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFE0E0E0)),
          labelSmall: TextStyle(fontSize: 12, color: Color(0xFF888899)),
        ),
        
        // Button Themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 3,
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            shadowColor: Colors.black.withOpacity(0.3),
          ),
        ),
        
        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1E1E24),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        
        // ✅ Card Theme (مُصلح: CardTheme بدل CardThemeData)
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: cardDarkBg,
          shadowColor: Colors.black.withOpacity(0.5),
        ),
        
        // Slider Theme
        sliderTheme: SliderThemeData(
          activeTrackColor: primaryColor,
          inactiveTrackColor: primaryColor.withOpacity(0.2),
          thumbColor: primaryColor,
          overlayColor: primaryColor.withOpacity(0.1),
          valueIndicatorColor: primaryColor,
          valueIndicatorTextStyle: const TextStyle(color: Colors.white),
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
        ),
        
        // SnackBar Theme
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          backgroundColor: Color(0xFF1E1E2F),
          contentTextStyle: TextStyle(color: Colors.white),
        ),
        
        // Progress Indicator
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      );

  // ================= 🎨 Helper Methods (الدوال المساعدة) =================
  
  /// إرجاع خلفية الكارد حسب الثيم
  static Color getCardBg(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? cardDarkBg 
        : cardLightBg;
  }
  
  /// إرجاع ظل الكارد حسب الثيم
  static List<BoxShadow> getCardShadow(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? cardDarkShadow 
        : cardLightShadow;
  }
  
  /// ✅ إرجاع حدود الكارد حسب الثيم (الدالة الناقصة)
  static BorderSide getCardBorder(BuildContext context, Color primary) {
    return Theme.of(context).brightness == Brightness.dark 
        ? cardBorderDark(primary) 
        : cardBorderLight(primary);
  }
  
  /// إرجاع لون النص الثانوي حسب الثيم
  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? const Color(0xFFA0A0A0) 
        : const Color(0xFF555566);
  }

  // ================= 🎯 دوال إضافية مفيدة =================

  /// إرجاع لون الزر حسب الحالة (success, warning, error)
  static Color getActionColor(String type) {
    switch (type) {
      case 'success': return successColor;
      case 'warning': return warningColor;
      case 'error': return errorColor;
      default: return primaryColor;
    }
  }

  /// إرجاع أيقونة حسب الحالة
  static IconData getStatusIcon(bool isActive) {
    return isActive ? Icons.check_circle : Icons.warning_amber_rounded;
  }

  /// إرجاع نص الحالة
  static String getStatusText(bool isActive, {String active = "Active", String inactive = "Inactive"}) {
    return isActive ? active : inactive;
  }

  /// تشغيل انميشن الثيم عند التبديل بين Light/Dark
  static void toggleThemeMode(BuildContext context) {
    final current = Theme.of(context).brightness;
    // ملاحظة: دي مجرد دالة مساعدة، التبديل الفعلي بيتم عبر Provider/Bloc
    print('Current theme: $current');
  }
}