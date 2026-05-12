// import 'package:flutter/material.dart';
// import 'package:smart_farm_app/data/models/zone_model.dart';
// import 'package:smart_farm_app/data/sources/robot_api.dart';
// import 'select_crop_page.dart';

// class ZoneDetailsPage extends StatefulWidget {
//   final ZoneModel zone;

//   const ZoneDetailsPage({super.key, required this.zone});

//   @override
//   State<ZoneDetailsPage> createState() => _ZoneDetailsPageState();
// }

// class _ZoneDetailsPageState extends State<ZoneDetailsPage> {
//   final RobotApi robotApi = RobotApi();

//   bool _loading = false;
//   bool _removingWeed = false;
//   int _duration = 5;

//   static const Color primary = Color(0xff27AE60);
//   static const Color secondary = Colors.blueAccent;
//   static const Color errorColor = Colors.red;
//   static const Color surfaceColor = Color(0xffF4F7FA);

//   void _showSnack(String msg, {bool success = true}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(msg),
//         backgroundColor: success ? primary : errorColor,
//       ),
//     );
//   }

//   Future<void> _perform(
//     Future<bool> Function() action,
//     String success,
//     String fail,
//   ) async {
//     setState(() => _loading = true);
//     try {
//       final ok = await action();
//       if (!mounted) return;
//       _showSnack(ok ? success : fail, success: ok);
//     } catch (_) {
//       if (!mounted) return;
//       _showSnack(fail, success: false);
//     } finally {
//       if (!mounted) return;
//       setState(() => _loading = false);
//     }
//   }

//   Future<void> _removeWeed() async {
//     setState(() => _removingWeed = true);

//     final model = RemoveHarmfulPlantRequest(
//       plantId: 1,
//       x: 0,
//       y: 0,
//       userId: 1,
//       zoneId: widget.zone.zoneId,
//     );

//     await _perform(
//       () => robotApi.removeWeed(model),
//       "تمت إزالة الأعشاب",
//       "فشل في إزالة الأعشاب",
//     );

//     setState(() => _removingWeed = false);
//   }

//   Future<void> _startIrrigation() async {
//     final model = IrrigateRequest(
//       userId: 1,
//       zoneId: widget.zone.zoneId,
//       duration: _duration,
//     );

//     await _perform(
//       () => robotApi.irrigate(model),
//       "تم بدء الري",
//       "فشل بدء الري",
//     );
//   }

//   Future<void> _openSelectCropPage() async {
//     final planted = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => SelectCropPage(zone: widget.zone),
//       ),
//     );

//     if (planted == true) {
//       _showSnack("تم زرع المحصول بنجاح");

//       // ✅ مهم عشان الصفحة اللي قبلها تعمل refresh
//       Navigator.pop(context, true);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: surfaceColor,
//       appBar: AppBar(
//         title: Text("Zone ${widget.zone.zoneId}"),
//         centerTitle: true,
//         backgroundColor: primary,
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _zoneInfoCard(),
//                 const SizedBox(height: 30),
//                 _irrigationCard(),
//                 const SizedBox(height: 20),
//                 _actionButton(
//                   "Plant Crop",
//                   Icons.agriculture,
//                   primary,
//                   _openSelectCropPage,
//                 ),
//                 const SizedBox(height: 20),
//                 _removeWeedButton(),
//               ],
//             ),
//           ),
//           if (_loading) const LinearProgressIndicator(minHeight: 3),
//         ],
//       ),
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
//                 Text("Crop ID : ${widget.zone.cropId}"),
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

//   Widget _irrigationCard() {
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
//               _startIrrigation,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _removeWeedButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: _removingWeed ? null : _removeWeed,
//         icon: _removingWeed
//             ? const SizedBox(
//                 height: 18,
//                 width: 18,
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                   strokeWidth: 2,
//                 ),
//               )
//             : const Icon(Icons.delete),
//         label: const Text("Remove Weed"),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: errorColor,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//         ),
//       ),
//     );
//   }

//   Widget _actionButton(
//     String text,
//     IconData icon,
//     Color color,
//     VoidCallback onPressed,
//   ) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: _loading ? null : onPressed,
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zone_details_cubit_cubit.dart';
import 'package:smart_farm_app/presentation/zones/cubit/zone_details_cubit_state.dart';

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: primary),
          );
        } else if (state is ZoneFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: errorColor),
          );
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
