import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/animations/app_colors.dart';
import 'package:smart_farm_app/animations/widgets/loading_widgets.dart';
import 'package:smart_farm_app/presentation/operations/widget/Caustom_Search.dart';
import 'package:smart_farm_app/presentation/operations/widget/OperationCard.dart';
import 'package:smart_farm_app/data/models/operation_model.dart';
import 'package:smart_farm_app/presentation/operations/cubit/operations_cubit.dart';

class OperationsPage extends StatelessWidget {
  const OperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OperationsCubit()..loadOperations(),
      child: const _OperationsView(),
    );
  }
}

class _OperationsView extends StatefulWidget {
  const _OperationsView();

  @override
  State<_OperationsView> createState() => _OperationsViewState();
}

class _OperationsViewState extends State<_OperationsView> {
  String _query = '';
  int? _filterType;
  final TextEditingController _searchController = TextEditingController();

  final Map<int, Map<String, dynamic>> _meta = {
    0: {'title': 'Agriculture', 'icon': Icons.grass},
    1: {'title': 'Harvest', 'icon': Icons.agriculture},
    2: {'title': 'Remove Harmful', 'icon': Icons.local_florist},
    3: {'title': 'Irrigation', 'icon': Icons.water_drop},
  };

  List<OperationModel> _applyFilters(List<OperationModel> list) {
    var filtered = list;
    if (_filterType != null) {
      filtered = filtered.where((e) => e.operationType == _filterType).toList();
    }
    if (_query.trim().isNotEmpty) {
      final q = _query.toLowerCase();
      filtered = filtered.where((e) {
        return e.zoneId.toString().contains(q) ||
            (e.cropId?.toString().contains(q) ?? false) ||
            e.operationId.toString().contains(q);
      }).toList();
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          TopBar(
            controller: _searchController,
            onSearch: (v) => setState(() => _query = v),
            onFilter: (v) {
              setState(() {
                _filterType = v;
                _query = '';
                _searchController.clear();
                context.read<OperationsCubit>().loadByType(v);
              });
            },
          ),
          Expanded(
            child: BlocBuilder<OperationsCubit, OperationsState>(
              builder: (context, state) {
                if (state is OperationsInitial || state is OperationsLoading) {
                  return const AppLoading(
                    text: 'Loading operations...',
                    color: AppColors.primary,
                  );
                }

                if (state is OperationsLoaded) {
                  final list = _applyFilters(state.operations);

                  if (list.isEmpty) {
                    return const EmptyState(
                      message: 'No operations found',
                      subMessage: 'Try adjusting your filters',
                      icon: Icons.filter_list_off,
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => context.read<OperationsCubit>().refresh(),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: list.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        final op = list[i];
                        return OperationCard(
                          op: op,
                          meta: _meta[op.operationType],
                        );
                      },
                    ),
                  );
                }

                if (state is OperationsError) {
                  return ErrorState(
                    message: 'Failed to load operations',
                    subMessage: state.message,
                    onRetry: () {
                      context.read<OperationsCubit>().loadOperations();
                    },
                  );
                }

                return const AppLoading(
                  text: 'Loading operations...',
                  color: AppColors.primary,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => context.read<OperationsCubit>().refresh(),
        child: const Icon(Icons.refresh, color: AppColors.white),
        tooltip: 'Refresh operations',
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Operations',
        style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w700),
      ),
      backgroundColor: AppColors.primary,
      centerTitle: true,
      elevation: 0,
    );
  }
}
