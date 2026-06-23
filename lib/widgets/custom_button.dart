import 'package:flutter/material.dart';
import 'package:smart_farm_app/animations/app_colors.dart';
import 'package:smart_farm_app/animations/widgets/loading_widgets.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool loading;
  final Color? color;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.loading = false,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingButton(
      isLoading: loading,
      onPressed: onTap,
      text: text,
      color: color ?? AppColors.primary,
      width: width ?? double.infinity,
      height: height ?? 50,
    );
  }
}
