import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/data/models/operation_model.dart';
import 'package:smart_farm_app/presentation/operations/cubit/operations_cubit.dart';
import 'package:smart_farm_app/presentation/operations/view/operations_page.dart';
class OperationCard extends StatelessWidget {
  final OperationModel op;
  final Map<String, dynamic>? meta;

  const OperationCard({super.key, required this.op, required this.meta});

  @override
  Widget build(BuildContext context) {
    final title = meta?['title'] ?? 'Operation';
    final icon = meta?['icon'] as IconData? ?? Icons.build;

    final formattedDate = context.read<OperationsCubit>().formatDateTime(
      op.createdAt,
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: OperationsPage.primaryColor.withOpacity(.12),
          child: Icon(icon, color: OperationsPage.primaryColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('Zone ${op.zoneId} • $formattedDate'),
        onTap: () {
          showDialog(
            context: context,
            builder: (c) => AlertDialog(
              title: Text(title),
              content: Text(
                'Operation ID: ${op.operationId}\n'
                'Zone: ${op.zoneId}\n'
                'User: ${op.userId}\n'
                'Crop: ${op.cropId ?? "-"}\n'
                'Harmful Plant: ${op.harmfulPlantId ?? "-"}\n'
                'Duration: ${op.duration ?? "-"}\n'
                'Created: $formattedDate',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(c),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
