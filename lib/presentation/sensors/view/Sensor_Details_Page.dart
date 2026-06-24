import 'package:flutter/material.dart';
import 'package:smart_farm_app/animations/app_colors.dart';
import 'package:smart_farm_app/animations/widgets/loading_widgets.dart';
import 'package:smart_farm_app/data/models/SensorModel.dart';
import 'package:smart_farm_app/presentation/sensors/view/SensorGauge.dart';
import 'package:smart_farm_app/presentation/sensors/widgets/SoilConditionBadge.dart';
import 'package:smart_farm_app/presentation/sensors/widgets/SummaryRow.dart';

class SensorDetailsPage extends StatelessWidget {
  final SensorModel sensor;
  final bool isLoading;

  const SensorDetailsPage({
    Key? key,
    required this.sensor,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sensorBackground,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(sensor: sensor),
            const SizedBox(height: 24),
            Expanded(
              child: isLoading
                  ? const _LoadingView()
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sensor Readings',
                            style: TextStyle(
                              color: AppColors.sensorTextLight,
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule_rounded,
                                size: 13,
                                color: AppColors.sensorLightGreen,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                sensor.formattedDate,
                                style: const TextStyle(
                                  color: AppColors.sensorLightGreen,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Gauges
                          Row(
                            children: [
                              Expanded(
                                child: SensorGauge(
                                  value: sensor.airTemperature,
                                  maxValue: 100,
                                  label: 'Air Temperature',
                                  unit: '°C',
                                  color: AppColors.sensorOrange,
                                  icon: Icons.thermostat_rounded,
                                  compact: false,
                                  isLoading: isLoading,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: SensorGauge(
                                  value: sensor.airHumidity,
                                  maxValue: 100,
                                  label: 'Air Humidity',
                                  unit: '%',
                                  color: AppColors.sensorBlue,
                                  icon: Icons.water_drop_rounded,
                                  compact: false,
                                  isLoading: isLoading,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SensorGauge(
                            value: sensor.soilMoisture,
                            maxValue: 100,
                            label: 'Soil Moisture',
                            unit: '%',
                            color: AppColors.sensorGreen,
                            icon: Icons.grass_rounded,
                            compact: false,
                            isLoading: isLoading,
                          ),
                          const SizedBox(height: 12),
                          SoilConditionBadge(value: sensor.soilMoisture),
                          const SizedBox(height: 24),

                          // Summary
                          SummaryRow(sensor: sensor),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final SensorModel sensor;

  const TopBar({required this.sensor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.sensorTextLight,
              size: 18,
            ),
          ),
          const Spacer(),
          Text(
            'Sensor #${sensor.sensorId}',
            style: const TextStyle(
              color: AppColors.sensorTextLight,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const AppLoading(
      text: 'Loading sensor data...',
      color: AppColors.sensorGreen,
    );
  }
}
