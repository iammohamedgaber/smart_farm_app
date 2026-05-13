import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zone_details_cubit.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zone_details_cubit_state.dart';
import 'package:smart_farm_app/widgets/CustomSnackBar.dart';

import 'select_crop_page.dart';

class ZoneDetailsPage extends StatefulWidget {
  final ZoneModel zone;

  const ZoneDetailsPage({super.key, required this.zone});

  @override
  State<ZoneDetailsPage> createState() => _ZoneDetailsPageState();
}

class _ZoneDetailsPageState extends State<ZoneDetailsPage> {
  int _duration = 5;

  static const Color primary = Color(0xff27AE60);
  static const Color secondary = Colors.blueAccent;
  static const Color errorColor = Colors.red;
  static const Color surfaceColor = Color(0xffF4F7FA);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ZoneDetailsCubit, ZoneDetailsState>(
      listener: (context, state) {
        if (state is ZoneSuccess) {
          CustomSnackBar.showSuccess(context, state.message);
        } else if (state is ZoneFailure) {
          CustomSnackBar.showError(context, state.error);
        }
      },
      builder: (context, state) {
        final loading = state is ZoneLoading;

        return Scaffold(
          backgroundColor: surfaceColor,
          appBar: AppBar(
            title: Text("Zone ${widget.zone.zoneId}"),
            centerTitle: true,
            backgroundColor: primary,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _zoneInfoCard(),
                    const SizedBox(height: 30),
                    _irrigationCard(context, loading),
                    const SizedBox(height: 20),
                    _actionButton(
                      "Plant Crop",
                      Icons.agriculture,
                      primary,
                      () async {
                        final planted = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SelectCropPage(zone: widget.zone),
                          ),
                        );
                        if (planted == true) {
                          context.read<ZoneDetailsCubit>().plantCrop(
                            widget.zone.zoneId,
                            widget.zone.cropId,
                          );
                          Navigator.pop(context, true);
                        }
                      },
                      loading,
                    ),
                    const SizedBox(height: 20),
                    _actionButton(
                      "Remove Weed",
                      Icons.delete,
                      errorColor,
                      () => context.read<ZoneDetailsCubit>().removeWeed(
                        widget.zone.zoneId,
                      ),
                      loading,
                    ),
                  ],
                ),
              ),
              if (loading) const LinearProgressIndicator(minHeight: 3),
            ],
          ),
        );
      },
    );
  }

  Widget _zoneInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.eco, color: primary),
                const SizedBox(width: 8),
                Text("Crop ID : ${widget.zone.cropId}"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.water_drop, color: secondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.zone.lastIrrigation == null
                        ? "No irrigation yet"
                        : "Last irrigation: ${widget.zone.lastIrrigation}",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _irrigationCard(BuildContext context, bool loading) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Irrigation Duration: $_duration min"),
            Slider(
              value: _duration.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              label: "$_duration",
              onChanged: (val) => setState(() => _duration = val.toInt()),
            ),
            _actionButton(
              "Start Water",
              Icons.water_drop,
              secondary,
              () => context.read<ZoneDetailsCubit>().irrigateZone(
                widget.zone.zoneId,
                _duration,
              ),
              loading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
    bool loading,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: loading ? null : onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
