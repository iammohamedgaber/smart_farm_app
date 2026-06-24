
import 'package:flutter/material.dart';
import 'package:smart_farm_app/animations/app_colors.dart';
import 'package:smart_farm_app/data/models/SensorModel.dart';
import 'package:smart_farm_app/presentation/sensors/widgets/StatItem.dart';

class SummaryRow extends StatelessWidget {
  final SensorModel sensor;

  const SummaryRow({required this.sensor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatItem(
          icon: Icons.thermostat_rounded,
          color: AppColors.sensorOrange,
          label: 'Temp',
          value: '${sensor.airTemperature.toStringAsFixed(1)}°',
        ),
        StatItem(
          icon: Icons.water_drop_rounded,
          color: AppColors.sensorBlue,
          label: 'Humidity',
          value: '${sensor.airHumidity.toStringAsFixed(1)}%',
        ),
        StatItem(
          icon: Icons.grass_rounded,
          color: AppColors.sensorGreen,
          label: 'Soil',
          value: '${sensor.soilMoisture.toStringAsFixed(1)}%',
        ),
      ],
    );
  }
}

