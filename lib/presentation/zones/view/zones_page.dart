import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/core/utils/app_theme.dart';
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

    /// تحميل الزونات أول ما الصفحة تفتح
    Future.microtask(() {
      if (mounted) {
        context.read<ZonesCubit>().loadZones();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ جلب الثيم الديناميكي (بيشتغل مع Light & Dark تلقائيًا)
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // ✅ خلفية ديناميكية من الثيم
      backgroundColor: colorScheme.surface,

      // ✅ AppBar منسّق بألوان من الثيم
      appBar: AppBar(
        title: Text(
          "Farm Zones",
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppThemes.primaryColor,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        scrolledUnderElevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),

      body: BlocBuilder<ZonesCubit, List<ZoneModel>>(
        builder: (context, zones) {
          /// لو لسه مفيش بيانات
          if (zones.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ✅ Loading Indicator بألوان من الثيم
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      color: AppThemes.primaryColor,
                      strokeWidth: 3,
                      backgroundColor: colorScheme.surfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Loading zones...",
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
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
                  /// لو الزون مفيهاش محصول
                  if (zone.cropId == 0) {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SelectCropPage(zone: zone),
                      ),
                    );

                    /// بعد ما المستخدم يزرع crop
                    if (result == true && mounted) {
                      context.read<ZonesCubit>().loadZones();
                    }
                  }
                  /// لو فيها محصول
                  else {
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
