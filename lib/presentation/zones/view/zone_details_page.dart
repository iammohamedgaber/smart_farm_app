// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_farm_app/data/models/zone_model.dart';
// import 'package:smart_farm_app/presentation/zones/cubit/zone_details_cubit.dart';
// import 'package:smart_farm_app/presentation/zones/cubit/zone_details_cubit_state.dart';
// import 'package:smart_farm_app/presentation/zones/cubit/zones_cubit.dart';
// import 'package:smart_farm_app/widgets/CustomSnackBar.dart';

// import 'select_crop_page.dart';

// class ZoneDetailsPage extends StatefulWidget {
//   final ZoneModel zone;

//   const ZoneDetailsPage({super.key, required this.zone});

//   @override
//   State<ZoneDetailsPage> createState() => _ZoneDetailsPageState();
// }

// class _ZoneDetailsPageState extends State<ZoneDetailsPage> {
//   int _duration = 5;

//   static const Color primary = Color(0xff27AE60);
//   static const Color secondary = Colors.blueAccent;
//   static const Color errorColor = Colors.red;
//   static const Color surfaceColor = Color(0xffF4F7FA);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ZoneDetailsCubit, ZoneDetailsState>(
//       listener: (context, state) {
//         if (state is ZoneSuccess) {
//           CustomSnackBar.showSuccess(context, state.message);
//           context.read<ZonesCubit>().loadZones();
//         } else if (state is ZoneFailure) {
//           CustomSnackBar.showError(context, state.error);
//         }
//       },
//       builder: (context, state) {
//         final loading = state is ZoneLoading;

//         return Scaffold(
//           backgroundColor: surfaceColor,
//           appBar: AppBar(
//             title: Text("Zone ${widget.zone.zoneId}"),
//             centerTitle: true,
//             backgroundColor: primary,
//           ),
//           body: Stack(
//             children: [
//               SingleChildScrollView(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _zoneInfoCard(),
//                     const SizedBox(height: 30),
//                     _irrigationCard(context, loading),
//                     const SizedBox(height: 20),
//                     _actionButton(
//                       "Plant Crop",
//                       Icons.agriculture,
//                       primary,
//                       () async {
//                         final planted = await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => SelectCropPage(zone: widget.zone),
//                           ),
//                         );
//                         if (planted == true) {
//                           context.read<ZoneDetailsCubit>().plantCrop(
//                             widget.zone.zoneId,
//                             widget.zone.cropId,
//                           );
//                           Navigator.pop(context, true);
//                         }
//                       },
//                       loading,
//                     ),
//                     const SizedBox(height: 20),
//                     _actionButton(
//                       "Remove Weed",
//                       Icons.delete,
//                       errorColor,
//                       () => context.read<ZoneDetailsCubit>().removeWeed(
//                         widget.zone.zoneId,
//                       ),
//                       loading,
//                     ),
//                     const SizedBox(height: 20),
//                     _actionButton(
//                       "Harvest",
//                       Icons.grass,
//                       Colors.orange,
//                       () => context.read<ZoneDetailsCubit>().harvest(
//                         widget.zone.zoneId,
//                       ),
//                       loading,
//                     ),
//                     const SizedBox(height: 20),
//                     _actionButton(
//                       "Scan Zone",
//                       Icons.qr_code_scanner,
//                       Colors.purple,
//                       () => context.read<ZoneDetailsCubit>().scan(
//                         widget.zone.zoneId,
//                       ),
//                       loading,
//                     ),
//                     const SizedBox(height: 20),
//                     _actionButton(
//                       "Plant Found",
//                       Icons.search,
//                       Colors.teal,
//                       () => context.read<ZoneDetailsCubit>().plantFound(
//                         widget.zone.zoneId,
//                         1, // plantId تجريبي
//                         0, // x تجريبي
//                         0, // y تجريبي
//                       ),
//                       loading,
//                     ),
//                   ],
//                 ),
//               ),
//               if (loading) const LinearProgressIndicator(minHeight: 3),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _zoneInfoCard() {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Icon(Icons.eco, color: primary),
//                 const SizedBox(width: 8),
//                 Text(
//                   (widget.zone.cropName == null ||
//                           widget.zone.cropName!.isEmpty)
//                       ? "No Crop Selected"
//                       : "Crop: ${widget.zone.cropName}",
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 const Icon(Icons.water_drop, color: secondary),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     widget.zone.lastIrrigation == null
//                         ? "No irrigation yet"
//                         : "Last irrigation: ${widget.zone.lastIrrigation}",
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _irrigationCard(BuildContext context, bool loading) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Irrigation Duration: $_duration min"),
//             Slider(
//               value: _duration.toDouble(),
//               min: 1,
//               max: 30,
//               divisions: 29,
//               label: "$_duration",
//               onChanged: (val) => setState(() => _duration = val.toInt()),
//             ),
//             _actionButton(
//               "Start Water",
//               Icons.water_drop,
//               secondary,
//               () => context.read<ZoneDetailsCubit>().irrigateZone(
//                 widget.zone.zoneId,
//                 _duration,
//               ),
//               loading,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _actionButton(
//     String text,
//     IconData icon,
//     Color color,
//     VoidCallback onPressed,
//     bool loading,
//   ) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: loading ? null : onPressed,
//         icon: Icon(icon),
//         label: Text(text),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: color,
//           padding: const EdgeInsets.symmetric(vertical: 14),
//         ),
//       ),
//     );
//   }
// }
//___________________________________________-

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zone_details_cubit.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zone_details_cubit_state.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zones_cubit.dart';
import 'package:smart_farm_app/widgets/CustomSnackBar.dart';

import 'select_crop_page.dart';

// ═══════════════════════════════════════════════════════════════════════
// Shared design tokens for this page. Centralized here (instead of on the
// State class) so every section of ZoneDetailsPage reads from one source
// of truth for color and spacing.
// ═══════════════════════════════════════════════════════════════════════
const Color _kGreen900 = Color(0xFF1B5E20);
const Color _kGreen700 = Color(0xFF2E7D32);
const Color _kGreen500 = Color(0xFF43A047);
const Color _kGreen100 = Color(0xFFE8F5E9);
const Color _kSurface = Color(0xFFF1F8F2);
const Color _kBlue = Color(0xFF1E88E5);
const Color _kOrange = Color(0xFFEF6C00);
const Color _kRed = Color(0xFFD32F2F);
const Color _kTeal = Color(0xFF00796B);
const Color _kPurple = Color(0xFF6A1B9A);
const Color _kTextDark = Color(0xFF1A3A2A);

const double _kGridSpacing = 14;

// ═══════════════════════════════════════════════════════════════════════
// PAGE
// ═══════════════════════════════════════════════════════════════════════

class ZoneDetailsPage extends StatefulWidget {
  final ZoneModel zone;

  const ZoneDetailsPage({super.key, required this.zone});

  @override
  State<ZoneDetailsPage> createState() => _ZoneDetailsPageState();
}

class _ZoneDetailsPageState extends State<ZoneDetailsPage>
    with SingleTickerProviderStateMixin {
  int _duration = 5;

  // ── Entrance animation. One controller drives both fade and slide, since
  // they always run together. ────────────────────────────────────────────
  late final AnimationController _entrance;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();

    _fade = CurvedAnimation(parent: _entrance, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entrance, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

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
          backgroundColor: _kSurface,
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(),
          body: Stack(
            children: [
              const FarmBackground(),
              SafeArea(child: _buildContent(context, loading)),
              if (loading) _buildLoadingBar(),
            ],
          ),
        );
      },
    );
  }

  // ── Layout composition ─────────────────────────────────────────────────

  Widget _buildContent(BuildContext context, bool loading) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: SingleChildScrollView(
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
                accentColor: _kGreen500,
                textColor: _kTextDark,
              ),
              const SizedBox(height: 14),
              _buildActionsGrid(context, loading),
            ],
          ),
        ),
      ),
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
            colors: [_kGreen900, _kGreen700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingBar() {
    return const Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: LinearProgressIndicator(
        minHeight: 3,
        backgroundColor: _kGreen100,
        color: _kGreen500,
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
          colors: [_kGreen700, _kGreen500],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _kGreen700.withOpacity(0.35),
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
            iconColor: _kGreen500,
            label: "Current Crop",
            value: hasCrop ? widget.zone.cropName! : "No crop planted",
            valueColor: hasCrop ? _kGreen700 : Colors.grey,
          ),
          InfoRow.divider,
          InfoRow(
            icon: Icons.water_drop_rounded,
            iconColor: _kBlue,
            label: "Last Irrigation",
            value: hasIrrigation
                ? widget.zone.lastIrrigation!
                : "Not irrigated yet",
            valueColor: hasIrrigation ? _kBlue : Colors.grey,
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
                  color: _kBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.water_drop_rounded,
                  color: _kBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Irrigation Control",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: _kTextDark,
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
                  color: _kBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "$_duration min",
                  style: const TextStyle(
                    color: _kBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: _kBlue,
              inactiveTrackColor: _kBlue.withOpacity(0.15),
              thumbColor: Colors.white,
              overlayColor: _kBlue.withOpacity(0.12),
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
            color: _kBlue,
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
              _kGreen500,
              () => _onPlantCrop(context),
            ),
            tile(
              "Remove Weed",
              Icons.delete_sweep_rounded,
              _kRed,
              () => context.read<ZoneDetailsCubit>().removeWeed(
                widget.zone.zoneId,
              ),
            ),
            tile(
              "Harvest",
              Icons.grass_rounded,
              _kOrange,
              () =>
                  context.read<ZoneDetailsCubit>().harvest(widget.zone.zoneId),
            ),
            tile(
              "Scan Zone",
              Icons.qr_code_scanner_rounded,
              _kPurple,
              () => context.read<ZoneDetailsCubit>().scan(widget.zone.zoneId),
            ),
            tile(
              "Plant Found",
              Icons.search_rounded,
              _kTeal,
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

  // ── Action handlers ──────────────────────────────────────────────────
  // Kept as a named method (rather than an inline closure) purely to keep
  // _buildActionsGrid readable — the logic itself is unchanged.

  Future<void> _onPlantCrop(BuildContext context) async {
    final newCropId = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SelectCropPage(zone: widget.zone)),
    );
    if (newCropId != null) {
      context.read<ZoneDetailsCubit>().plantCrop(
        widget.zone.zoneId,
        newCropId, // ✅ استخدم الكروب الجديد اللي رجع من SelectCropPage
      );
      context.read<ZonesCubit>().loadZones(); // ✅ علشان يتحدث بره كمان
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════
// CUSTOM WIDGETS
// Self-contained, parameter-driven components with no dependency on the
// page's private tokens above — kept that way intentionally so each class
// below can be lifted into its own file later with a simple copy/paste.
// ═══════════════════════════════════════════════════════════════════════

/// Visual style of an [ActionTile].
enum ActionTileVariant {
  /// Compact square tile with icon above label — used in action grids.
  grid,

  /// Full-width gradient button with icon beside label — used for a
  /// single primary action (e.g. "Start Irrigation").
  full,
}

/// A single tappable action used throughout the zone screen.
///
/// Owns its own press animation so every action — grid tiles and the
/// full-width irrigation button alike — shares identical, consistent
/// tactile feedback instead of each call site reimplementing it.
class ActionTile extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final bool loading;
  final ActionTileVariant variant;

  const ActionTile({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.loading = false,
    this.variant = ActionTileVariant.grid,
  });

  @override
  State<ActionTile> createState() => _ActionTileState();
}

class _ActionTileState extends State<ActionTile>
    with SingleTickerProviderStateMixin {
  static const double _pressedScale = 0.95;
  static const Color _textDark = Color(0xFF1A3A2A);

  late final AnimationController _scale;

  @override
  void initState() {
    super.initState();
    _scale = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: _pressedScale,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _scale.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails _) => _scale.reverse();

  void _handleTapUp(TapUpDetails _) {
    _scale.forward();
    if (!widget.loading) widget.onPressed();
  }

  void _handleTapCancel() => _scale.forward();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scale,
        child: switch (widget.variant) {
          ActionTileVariant.grid => _buildGrid(),
          ActionTileVariant.full => _buildFull(),
        },
      ),
    );
  }

  Widget _buildGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: widget.color.withOpacity(0.12), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _iconBadge(size: 52, iconSize: 26),
          const SizedBox(height: 12),
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.loading ? Colors.grey : _textDark,
              fontWeight: FontWeight.w600,
              fontSize: 13.5,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFull() {
    final colors = widget.loading
        ? [Colors.grey.shade300, Colors.grey.shade400]
        : [widget.color, Color.lerp(widget.color, Colors.black, 0.18)!];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: widget.loading
            ? []
            : [
                BoxShadow(
                  color: widget.color.withOpacity(0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBadge({required double size, required double iconSize}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(widget.icon, color: widget.color, size: iconSize),
    );
  }
}

/// A soft, frosted-glass style container used to group related content
/// (info rows, controls, etc.) on top of the dashboard background.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.88),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFCBE8CE), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D32).withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// A labeled row showing an icon badge, a small caption, and a value.
///
/// Used inside [GlassCard]s to present zone facts such as the current
/// crop or the last irrigation time.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color valueColor;

  const InfoRow({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  /// Shared hairline divider for separating stacked [InfoRow]s.
  static const Widget divider = Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Divider(height: 1, color: Color(0xFFDCEEDD)),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.10),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: valueColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Small pill indicating whether a zone currently has an active crop.
class StatusChip extends StatelessWidget {
  final bool hasCrop;

  const StatusChip({super.key, required this.hasCrop});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(hasCrop ? 0.22 : 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Text(
        hasCrop ? "Active" : "Empty",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// A small left-accented heading used to introduce a group of content,
/// e.g. "Zone Actions".
class SectionLabel extends StatelessWidget {
  final String text;
  final Color accentColor;
  final Color textColor;

  const SectionLabel(
    this.text, {
    super.key,
    required this.accentColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: textColor,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

/// Soft decorative background: a pale green gradient with faint arcs and
/// dot accents, giving the screen a dashboard-like atmosphere without
/// relying on image assets. Designed to sit as the first child of a [Stack].
class FarmBackground extends StatelessWidget {
  const FarmBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(painter: _FarmBackgroundPainter()),
    );
  }
}

class _FarmBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Soft gradient base.
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFECF7ED), Color(0xFFF4FAF5), Color(0xFFFAFFFB)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Offset.zero & size, bgPaint);

    // Decorative arcs, top-right.
    final arcPaint = Paint()
      ..color = const Color(0xFF43A047).withOpacity(0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 40;
    for (int i = 0; i < 3; i++) {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.width + 40, -40),
          width: 260.0 + i * 90,
          height: 260.0 + i * 90,
        ),
        math.pi * 0.55,
        math.pi * 0.45,
        false,
        arcPaint,
      );
    }

    // Decorative dot grid, bottom-left.
    final dotPaint = Paint()..color = const Color(0xFF81C784).withOpacity(0.14);
    for (int row = 0; row < 5; row++) {
      for (int col = 0; col < 4; col++) {
        canvas.drawCircle(
          Offset(16.0 + col * 22, size.height - 100 + row * 22),
          3,
          dotPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
