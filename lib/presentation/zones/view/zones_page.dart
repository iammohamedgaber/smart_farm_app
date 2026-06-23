import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/animations/animations.dart';
import 'package:smart_farm_app/animations/app_colors.dart';
import 'package:smart_farm_app/animations/widgets/loading_widgets.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zones_cubit.dart';
import 'package:smart_farm_app/presentation/zones/view/zone_card.dart';
import 'zone_details_page.dart';
import 'select_crop_page.dart';

class ZonesPage extends StatefulWidget {
  const ZonesPage({super.key});

  @override
  State<ZonesPage> createState() => _ZonesPageState();
}

class _ZonesPageState extends State<ZonesPage> {
  @override
  void initState() {
    super.initState();
    _loadZones();
  }

  void _loadZones() {
    Future.microtask(() {
      if (mounted) {
        context.read<ZonesCubit>().loadZones();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sensorBackground,
      appBar: _buildAppBar(),
      body: BlocBuilder<ZonesCubit, List<ZoneModel>>(
        builder: (context, zones) {
          if (zones.isEmpty) {
            return const _EmptyView();
          }

          return EntranceAnimation(
            duration: const Duration(milliseconds: 400),
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: zones.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final zone = zones[index];
                return ZoneCard(
                  zone: zone,
                  onTap: () => _onZoneTap(context, zone),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _onZoneTap(BuildContext context, ZoneModel zone) async {
    final hasCrop =
        zone.cropId != 0 && zone.cropName != null && zone.cropName!.isNotEmpty;

    if (!hasCrop) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SelectCropPage(zone: zone)),
      );

      if (result != null && result is String && mounted) {
        context.read<ZonesCubit>().loadZones();
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ZoneDetailsPage(zone: zone)),
      );
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        "Farm Zones",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A2E1F), Color(0xFF145C37), Color(0xFF27AE60)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      message: 'No zones found',
      subMessage: 'Start by adding a new zone',
      icon: Icons.grid_view_rounded,
    );
  }
}
