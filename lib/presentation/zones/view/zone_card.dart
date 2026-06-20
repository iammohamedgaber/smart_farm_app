// import 'package:flutter/material.dart';
// import 'package:smart_farm_app/data/models/zone_model.dart';

// class ZoneCard extends StatelessWidget {
//   final ZoneModel zone;
//   final VoidCallback? onTap;

//   const ZoneCard({super.key, required this.zone, this.onTap});

//   bool get _hasIrrigation => zone.lastIrrigation != null;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 8,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Zone ID (ممكن تخليه يظهر أو تخفيه حسب رغبتك)
//             Text(
//               "Zone ${zone.zoneId}",
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),

//             // Crop Name فقط
//             Row(
//               children: [
//                 const Icon(Icons.eco, size: 18, color: Colors.green),
//                 const SizedBox(width: 6),
//                 Expanded(
//                   child: Text(
//                     (zone.cropName == null || zone.cropName!.isEmpty)
//                         ? "No Crop Selected"
//                         : zone.cropName!, // ✅ يعرض الاسم فقط
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),

//             // Last Irrigation
//             Row(
//               children: [
//                 const Icon(Icons.water_drop, size: 18, color: Colors.blue),
//                 const SizedBox(width: 6),
//                 Expanded(
//                   child: Text(
//                     zone.lastIrrigation == null
//                         ? "Never irrigated"
//                         : "Last irrigation: ${zone.lastIrrigation}",
//                     style: const TextStyle(fontSize: 13),
//                   ),
//                 ),
//               ],
//             ),
//             const Spacer(),

//             // Irrigation Status
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 6,
//                 ),
//                 decoration: BoxDecoration(
//                   color: _hasIrrigation
//                       ? Colors.green.withOpacity(.15)
//                       : Colors.orange.withOpacity(.15),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   _hasIrrigation ? "Irrigated" : "Needs Irrigation",
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: _hasIrrigation ? Colors.green : Colors.orange,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // ✅ مكتبة لتنسيق التاريخ
import 'package:smart_farm_app/data/models/zone_model.dart';

class ZoneCard extends StatelessWidget {
  final ZoneModel zone;
  final VoidCallback? onTap;

  const ZoneCard({super.key, required this.zone, this.onTap});

  bool get _hasIrrigation => zone.lastIrrigation != null;

  String _formatIrrigationDate(String? rawDate) {
    if (rawDate == null) return "Never irrigated";
    try {
      final date = DateTime.parse(rawDate);
      return DateFormat("EEEE, dd/MM • HH:mm").format(date);
    } catch (_) {
      return rawDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(minHeight: 150),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Zone ID
            Text(
              "Zone ${zone.zoneId}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Crop Name
            Row(
              children: [
                const Icon(Icons.eco, size: 18, color: Colors.green),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    (zone.cropName == null || zone.cropName!.isEmpty)
                        ? "No Crop Selected"
                        : zone.cropName!,
                    style: const TextStyle(fontSize: 14),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Last Irrigation (منسق)
            Row(
              children: [
                const Icon(Icons.water_drop, size: 18, color: Colors.blue),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _formatIrrigationDate(zone.lastIrrigation),
                    style: const TextStyle(fontSize: 13),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Irrigation Status
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _hasIrrigation
                      ? Colors.green.withOpacity(.15)
                      : Colors.orange.withOpacity(.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _hasIrrigation ? "Irrigated" : "Needs Irrigation",
                  style: TextStyle(
                    fontSize: 12,
                    color: _hasIrrigation ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
