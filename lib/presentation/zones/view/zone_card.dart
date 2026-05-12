import 'package:flutter/material.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';


class ZoneCard extends StatelessWidget {
  final ZoneModel zone;
  final VoidCallback? onTap;

  const ZoneCard({super.key, required this.zone, this.onTap});

  bool get _hasIrrigation => zone.lastIrrigation != null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(16),

      child: Container(
        padding: const EdgeInsets.all(16),

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
           
            Text(
              "Zone ${zone.zoneId}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            
            Row(
              children: [
                const Icon(Icons.eco, size: 18, color: Colors.green),

                const SizedBox(width: 6),

                Expanded(
                  child: Text(
                    zone.cropId == 0
                        ? "No Crop Selected"
                        : "Crop ID : ${zone.cropId}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.water_drop, size: 18, color: Colors.blue),

                const SizedBox(width: 6),

                Expanded(
                  child: Text(
                    zone.lastIrrigation == null
                        ? "No irrigation yet"
                        : "Last irrigation: ${zone.lastIrrigation}",
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),

            const Spacer(),

            
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
