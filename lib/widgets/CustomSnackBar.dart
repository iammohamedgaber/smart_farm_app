import 'package:flutter/material.dart';

enum SnackStyle { info, success, error, warning }

class CustomSnackBar {
  static void _show(
    BuildContext context,
    String message, {
    required SnackStyle style,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
    IconData? icon,
    Color? backgroundColor,
  }) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    final defaultColor = {
      SnackStyle.info: Colors.blue.shade700,
      SnackStyle.success: Colors.green.shade600,
      SnackStyle.error: Colors.red.shade600,
      SnackStyle.warning: Colors.orange.shade700,
    }[style]!;

    final bg = backgroundColor ?? defaultColor;

    final ic =
        icon ??
        {
          SnackStyle.info: Icons.info_outline,
          SnackStyle.success: Icons.check_circle_outline,
          SnackStyle.error: Icons.error_outline,
          SnackStyle.warning: Icons.warning_amber_outlined,
        }[style]!;

    final snack = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: duration,
      content: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: bg.withOpacity(0.22),
                blurRadius: 8,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(ic, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // زرار Action (اختياري)
              if (actionLabel != null && onAction != null)
                TextButton(
                  onPressed: () {
                    onAction();
                    messenger.hideCurrentSnackBar();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 36),
                  ),
                  child: Text(
                    actionLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              IconButton(
                onPressed: () => messenger.hideCurrentSnackBar(),
                icon: const Icon(Icons.close, color: Colors.white, size: 18),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(snack);
  }

  static void showSuccess(BuildContext context, String message) =>
      _show(context, message, style: SnackStyle.success);

  static void showError(BuildContext context, String message) =>
      _show(context, message, style: SnackStyle.error);

  static void showWarning(BuildContext context, String message) =>
      _show(context, message, style: SnackStyle.warning);

  static void showInfo(BuildContext context, String message) =>
      _show(context, message, style: SnackStyle.info);
}
