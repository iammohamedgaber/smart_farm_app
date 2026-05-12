import 'package:flutter/material.dart';

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
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: onSearch,
            ),
          ),
          const SizedBox(width: 10),
          PopupMenuButton<int?>(
            tooltip: 'Filter',
            icon: const Icon(Icons.filter_list),
            onSelected: onFilter,
            itemBuilder: (ctx) => [
              const PopupMenuItem(value: null, child: Text('All')),
              const PopupMenuDivider(),
              const PopupMenuItem(value: 0, child: Text('Agriculture')),
              const PopupMenuItem(value: 1, child: Text('Harvest')),
              const PopupMenuItem(value: 2, child: Text('Remove Harmful')),
              const PopupMenuItem(value: 3, child: Text('Irrigation')),
            ],
          ),
        ],
      ),
    );
  }
}
