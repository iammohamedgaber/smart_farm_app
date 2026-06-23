import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/animations/animations.dart';
import 'package:smart_farm_app/animations/app_colors.dart';
import 'package:smart_farm_app/animations/widgets/ActionTile.dart';
import 'package:smart_farm_app/animations/widgets/glass_card.dart';
import 'package:smart_farm_app/animations/widgets/info_row.dart';
import 'package:smart_farm_app/animations/widgets/loading_widgets.dart';
import 'package:smart_farm_app/animations/widgets/section_label.dart';
import 'package:smart_farm_app/animations/widgets/status_chip.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zone_details_cubit.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zone_details_cubit_state.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zones_cubit.dart';
import 'package:smart_farm_app/widgets/CustomSnackBar.dart';
import 'select_crop_page.dart';

const double _kGridSpacing = 14;

class ZoneDetailsPage extends StatefulWidget {
  final ZoneModel zone;

  const ZoneDetailsPage({super.key, required this.zone});

  @override
  State<ZoneDetailsPage> createState() => _ZoneDetailsPageState();
}

class _ZoneDetailsPageState extends State<ZoneDetailsPage> {
  int _duration = 5;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ZoneDetailsCubit, ZoneDetailsState>(
      listener: (context, state) {
        if (state is ZoneSuccess) {
          CustomSnackBar.showSuccess(context, state.message);
          context.read<ZonesCubit>().loadZones();
        } else if (state is ZoneFailure) {
          CustomSnackBar.showError(context, state.error);
        }
      },
      builder: (context, state) {
        final loading = state is ZoneLoading;

        return Scaffold(
          backgroundColor: AppColors.surface,
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(),
          body: Stack(
            children: [
              const FarmBackground(),
              SafeArea(
                child: EntranceAnimation(
                  child: _buildContent(context, loading),
                ),
              ),

              if (loading)
                const LoadingBar(
                  backgroundColor: AppColors.green100,
                  progressColor: AppColors.green500,
                  height: 3,
                ),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        "Zone ${widget.zone.zoneId}",
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.green900, AppColors.green700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool loading) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildZoneHeader(),
          const SizedBox(height: 20),
          _buildInfoCard(),
          const SizedBox(height: 20),
          _buildIrrigationCard(context, loading),
          const SizedBox(height: 24),
          const SectionLabel(
            "Zone Actions",
            accentColor: AppColors.green500,
            textColor: AppColors.textDark,
          ),
          const SizedBox(height: 14),
          _buildActionsGrid(context, loading),
        ],
      ),
    );
  }

  Widget _buildZoneHeader() {
    final hasCrop =
        widget.zone.cropName != null && widget.zone.cropName!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.green700, AppColors.green500],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.green700.withOpacity(0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.grid_view_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Zone Overview",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                "Zone #${widget.zone.zoneId}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const Spacer(),
          StatusChip(hasCrop: hasCrop),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    final hasCrop =
        widget.zone.cropName != null && widget.zone.cropName!.isNotEmpty;
    final hasIrrigation = widget.zone.lastIrrigation != null;

    return GlassCard(
      child: Column(
        children: [
          InfoRow(
            icon: Icons.eco_rounded,
            iconColor: AppColors.green500,
            label: "Current Crop",
            value: hasCrop ? widget.zone.cropName! : "No crop planted",
            valueColor: hasCrop ? AppColors.green700 : Colors.grey,
          ),
          InfoRow.divider,
          InfoRow(
            icon: Icons.water_drop_rounded,
            iconColor: AppColors.blue,
            label: "Last Irrigation",
            value: hasIrrigation
                ? widget.zone.lastIrrigation!
                : "Not irrigated yet",
            valueColor: hasIrrigation ? AppColors.blue : Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildIrrigationCard(BuildContext context, bool loading) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.water_drop_rounded,
                  color: AppColors.blue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Irrigation Control",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Duration",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "$_duration min",
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.blue,
              inactiveTrackColor: AppColors.blue.withOpacity(0.15),
              thumbColor: Colors.white,
              overlayColor: AppColors.blue.withOpacity(0.12),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              trackHeight: 5,
            ),
            child: Slider(
              value: _duration.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              label: "$_duration",
              onChanged: (val) => setState(() => _duration = val.toInt()),
            ),
          ),
          const SizedBox(height: 6),
          ActionTile(
            label: "Start Irrigation",
            icon: Icons.water_drop_rounded,
            color: AppColors.blue,
            loading: loading,
            variant: ActionTileVariant.full,
            onPressed: () => context.read<ZoneDetailsCubit>().irrigateZone(
              widget.zone.zoneId,
              _duration,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsGrid(BuildContext context, bool loading) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth = (constraints.maxWidth - _kGridSpacing) / 2;

        Widget tile(
          String label,
          IconData icon,
          Color color,
          VoidCallback onPressed,
        ) {
          return SizedBox(
            width: tileWidth,
            child: ActionTile(
              label: label,
              icon: icon,
              color: color,
              loading: loading,
              onPressed: onPressed,
            ),
          );
        }

        return Wrap(
          spacing: _kGridSpacing,
          runSpacing: _kGridSpacing,
          children: [
            tile(
              "Plant Crop",
              Icons.agriculture_rounded,
              AppColors.green500,
              () => _onPlantCrop(context),
            ),
            tile(
              "Remove Weed",
              Icons.delete_sweep_rounded,
              AppColors.red,
              () => context.read<ZoneDetailsCubit>().removeWeed(
                widget.zone.zoneId,
              ),
            ),
            tile(
              "Harvest",
              Icons.grass_rounded,
              AppColors.orange,
              () =>
                  context.read<ZoneDetailsCubit>().harvest(widget.zone.zoneId),
            ),
            tile(
              "Scan Zone",
              Icons.qr_code_scanner_rounded,
              AppColors.purple,
              () => context.read<ZoneDetailsCubit>().scan(widget.zone.zoneId),
            ),
            tile(
              "Plant Found",
              Icons.search_rounded,
              AppColors.teal,
              () => context.read<ZoneDetailsCubit>().plantFound(
                widget.zone.zoneId,
                1,
                0,
                0,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onPlantCrop(BuildContext context) async {
    final newCropName = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SelectCropPage(zone: widget.zone)),
    );

    if (newCropName != null && newCropName is String) {
      context.read<ZonesCubit>().loadZones();
    }
  }
}
