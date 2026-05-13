import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final TextInputType keyboard;
  final IconData? icon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.keyboard = TextInputType.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Field required";
        }
        return null;
      },

      style: TextStyle(color: isDark ? Colors.white : Colors.black),

      decoration: InputDecoration(
        labelText: hint,

        labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),

        prefixIcon: icon != null
            ? Icon(icon, color: isDark ? Colors.white70 : Colors.black54)
            : null,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),

        filled: true,

        fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
      ),
    );
  }
}
