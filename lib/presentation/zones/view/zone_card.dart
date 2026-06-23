import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      return DateFormat("dd/MM/yyyy • hh:mm a").format(date);
    } catch (_) {
      return rawDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF388E3C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Zone ${zone.zoneId}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.eco, color: Colors.lightGreenAccent, size: 20),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    (zone.cropName == null || zone.cropName!.isEmpty)
                        ? "No Crop Selected"
                        : zone.cropName!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.water_drop,
                  color: Colors.cyanAccent,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _formatIrrigationDate(zone.lastIrrigation),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ),
              ],
            ),

            const Spacer(),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _hasIrrigation
                    ? Colors.greenAccent.withOpacity(0.2)
                    : Colors.orangeAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _hasIrrigation ? "Irrigated ✓" : "Needs Care ⚠",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _hasIrrigation
                      ? Colors.greenAccent
                      : Colors.orangeAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
