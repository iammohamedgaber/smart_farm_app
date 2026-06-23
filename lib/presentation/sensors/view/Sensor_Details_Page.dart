import 'package:flutter/material.dart';
import 'package:smart_farm_app/animations/app_colors.dart';
import 'package:smart_farm_app/animations/widgets/loading_widgets.dart';
import 'package:smart_farm_app/data/models/SensorModel.dart';
import 'package:smart_farm_app/presentation/sensors/view/SensorGauge.dart';

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
            _TopBar(sensor: sensor),
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
                          _SoilConditionBadge(value: sensor.soilMoisture),
                          const SizedBox(height: 24),

                          // Summary
                          _SummaryRow(sensor: sensor),
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

class _TopBar extends StatelessWidget {
  final SensorModel sensor;

  const _TopBar({required this.sensor});

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


class _SoilConditionBadge extends StatelessWidget {
  final double value;

  const _SoilConditionBadge({required this.value});

  String get _label {
    if (value < 20) return 'Dry';
    if (value < 40) return 'Low';
    if (value < 70) return 'Optimal';
    return 'Saturated';
  }

  Color get _color {
    if (value < 20) return AppColors.sensorOrange;
    if (value < 40) return AppColors.sensorOrange;
    if (value < 70) return AppColors.sensorGreen;
    return AppColors.sensorBlue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _color.withOpacity(0.3)),
      ),
      child: Text(
        _label,
        style: TextStyle(
          color: _color,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final SensorModel sensor;

  const _SummaryRow({required this.sensor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatItem(
          icon: Icons.thermostat_rounded,
          color: AppColors.sensorOrange,
          label: 'Temp',
          value: '${sensor.airTemperature.toStringAsFixed(1)}°',
        ),
        _StatItem(
          icon: Icons.water_drop_rounded,
          color: AppColors.sensorBlue,
          label: 'Humidity',
          value: '${sensor.airHumidity.toStringAsFixed(1)}%',
        ),
        _StatItem(
          icon: Icons.grass_rounded,
          color: AppColors.sensorGreen,
          label: 'Soil',
          value: '${sensor.soilMoisture.toStringAsFixed(1)}%',
        ),
      ],
    );
  }
}


class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.sensorTextLight,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: AppColors.sensorTextLight.withOpacity(0.4),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
