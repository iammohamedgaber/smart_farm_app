import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/animations/app_colors.dart';
import 'package:smart_farm_app/data/models/operation_model.dart';
import 'package:smart_farm_app/presentation/operations/cubit/operations_cubit.dart';

class OperationCard extends StatelessWidget {
  final OperationModel op;
  final Map<String, dynamic>? meta;

  const OperationCard({super.key, required this.op, this.meta});

  @override
  Widget build(BuildContext context) {
    final title = meta?['title'] ?? 'Operation';
    final icon = meta?['icon'] as IconData? ?? Icons.build;
    final formattedDate = context.read<OperationsCubit>().formatDateTime(
      op.createdAt,
    );

    final cropDisplay = (op.operationType == 0 && op.cropName != null)
        ? op.cropName
        : (op.cropId?.toString() ?? "-");

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.green500.withOpacity(0.12),
          child: Icon(icon, color: AppColors.green500),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        subtitle: Text(
          'Zone ${op.zoneId} • $formattedDate',
          style: const TextStyle(color: Colors.grey),
        ),
        onTap: () {
          _showDetailsDialog(context, title, cropDisplay!, formattedDate);
        },
      ),
    );
  }

  void _showDetailsDialog(
    BuildContext context,
    String title,
    String cropDisplay,
    String formattedDate,
  ) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Zone', '${op.zoneId}'),
            const SizedBox(height: 8),
            _buildDetailRow('Crop', cropDisplay),
            const SizedBox(height: 8),
            _buildDetailRow(
              'Harmful Plant',
              op.harmfulPlantId?.toString() ?? "-",
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Duration', op.duration?.toString() ?? "-"),
            const SizedBox(height: 8),
            _buildDetailRow('Created', formattedDate),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text(
              'Close',
              style: TextStyle(color: AppColors.green500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        Expanded(
          child: Text(value, style: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}
