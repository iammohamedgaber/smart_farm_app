import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    Future.microtask(() {
      if (mounted) {
        context.read<ZonesCubit>().loadZones();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // خلفية ثابتة
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "Farm Zones",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),

      body: BlocBuilder<ZonesCubit, List<ZoneModel>>(
        builder: (context, zones) {
          if (zones.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      color: Colors.green,
                      strokeWidth: 3,
                      backgroundColor: Colors.black12,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Loading zones...",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: zones.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final zone = zones[index];

              return ZoneCard(
                zone: zone,
                onTap: () async {
                  if (zone.cropId == 0) {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SelectCropPage(zone: zone),
                      ),
                    );

                    if (result == true && mounted) {
                      context.read<ZonesCubit>().loadZones();
                    }
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ZoneDetailsPage(zone: zone),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
