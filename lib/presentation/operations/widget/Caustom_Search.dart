import 'package:flutter/material.dart';
import 'package:smart_farm_app/animations/app_colors.dart';

class TopBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;
  final ValueChanged<int?> onFilter;

  const TopBar({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Search by zone, crop or id',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
              onChanged: onSearch,
              style: const TextStyle(color: AppColors.textDark),
            ),
          ),
          const SizedBox(width: 10),
          PopupMenuButton<int?>(
            tooltip: 'Filter',
            icon: const Icon(Icons.filter_list, color: AppColors.primary),
            onSelected: onFilter,
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: null,
                child: Text('All', style: TextStyle(color: AppColors.textDark)),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 0,
                child: Text(
                  'Agriculture',
                  style: TextStyle(color: AppColors.textDark),
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text(
                  'Harvest',
                  style: TextStyle(color: AppColors.textDark),
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text(
                  'Remove Harmful',
                  style: TextStyle(color: AppColors.textDark),
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text(
                  'Irrigation',
                  style: TextStyle(color: AppColors.textDark),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
