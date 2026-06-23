import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_farm_app/animations/app_colors.dart';

// ============================================================
// 1. LOADING INDICATOR - للشاشات الكاملة
// ============================================================
class LoadingIndicator extends StatelessWidget {
  final Color color;
  final double size;
  final double strokeWidth;

  const LoadingIndicator({
    super.key,
    this.color = AppColors.primary,
    this.size = 40,
    this.strokeWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

// ============================================================
// 2. LOADING WITH TEXT - تحميل مع نص
// ============================================================
class LoadingWithText extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const LoadingWithText({
    super.key,
    this.text = 'Loading...',
    this.color = AppColors.primary,
    this.textColor = AppColors.textDark,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingIndicator(color: color),
          const SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 3. LOADING BAR - شريط تحميل متحرك
// ============================================================
class LoadingBar extends StatelessWidget {
  final Color backgroundColor;
  final Color progressColor;
  final double height;
  final double? width;

  const LoadingBar({
    super.key,
    this.backgroundColor = AppColors.green100,
    this.progressColor = AppColors.green500,
    this.height = 3,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: LinearProgressIndicator(
        minHeight: height,
        backgroundColor: backgroundColor,
        color: progressColor,
      ),
    );
  }
}

// ============================================================
// 4. LOADING OVERLAY - فوق الشاشة
// ============================================================
class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Color overlayColor;

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.overlayColor = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: overlayColor,
            child: const Center(
              child: LoadingIndicator(),
            ),
          ),
      ],
    );
  }
}

// ============================================================
// 5. LOADING SHIMMER - تأثير شيمر (سكلتون)
// ============================================================
class LoadingShimmer extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingShimmer({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child,
    );
  }
}

// ============================================================
// 6. LOADING BUTTON - زر مع تحميل
// ============================================================
class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final double width;
  final double height;

  const LoadingButton({
    super.key,
    required this.isLoading,
    this.onPressed,
    required this.text,
    this.color = AppColors.primary,
    this.width = double.infinity,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}

// ============================================================
// 7. LOADING LIST - قائمة تحميل (سكلتون)
// ============================================================
class LoadingList extends StatelessWidget {
  final int itemCount;

  const LoadingList({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const LoadingShimmer(
          isLoading: true,
          child: SizedBox(),
        ),
      ),
    );
  }
}

// ============================================================
// 8. APP LOADING - الأجمل والأفضل (شعار متحرك)
// ============================================================
class AppLoading extends StatelessWidget {
  final String? text;
  final Color color;

  const AppLoading({
    super.key,
    this.text,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // شعار متحرك (نبض)
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.85, end: 1.0),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            builder: (context, scale, _) {
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        color,
                        Color.lerp(color, Colors.black, 0.2)!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.eco_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          if (text != null) ...[
            Text(
              text!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
          ],
          // نقاط متحركة
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 600 + (index * 200)),
                curve: Curves.easeInOut,
                builder: (context, value, _) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withOpacity(value),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 9. EMPTY STATE
// ============================================================
class EmptyState extends StatelessWidget {
  final String message;
  final String? subMessage;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionText;

  const EmptyState({
    super.key,
    required this.message,
    this.subMessage,
    this.icon = Icons.inbox_outlined,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: Icon(
                icon,
                size: 40,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (subMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                subMessage!,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onAction != null && actionText != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  actionText!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 10. ERROR STATE
// ============================================================
class ErrorState extends StatelessWidget {
  final String message;
  final String? subMessage;
  final VoidCallback onRetry;

  const ErrorState({
    super.key,
    required this.message,
    this.subMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.red.withOpacity(0.1),
              ),
              child: Icon(
                Icons.error_outline,
                size: 40,
                color: AppColors.red,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (subMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                subMessage!,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}