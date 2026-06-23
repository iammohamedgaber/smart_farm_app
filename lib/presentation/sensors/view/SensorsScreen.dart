import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/animations/app_colors.dart';
import 'package:smart_farm_app/animations/widgets/loading_widgets.dart';
import 'package:smart_farm_app/data/models/SensorModel.dart';
import 'package:smart_farm_app/presentation/sensors/view/SensorGauge.dart';
import 'package:smart_farm_app/presentation/sensors/cubit/sensor_cubit.dart';
import 'package:smart_farm_app/presentation/sensors/view/sensor_details_page.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({super.key});

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  @override
  void initState() {
    super.initState();
    context.read<SensorCubit>().loadSensors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sensorBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SensorCubit, SensorCubitState>(
                builder: (context, state) {
                  
                  if (state is SensorCubitLoading ||
                      state is SensorCubitInitial) {
                    return const AppLoading(
                      text: 'Loading sensors...',
                      color: AppColors.sensorGreen,
                    );
                  }

                  if (state is SensorCubitError) {
                    return ErrorState(
                      message: 'Failed to load sensors',
                      subMessage: state.message,
                      onRetry: () {
                        context.read<SensorCubit>().loadSensors();
                      },
                    );
                  }

                  if (state is SensorCubitLoaded) {
                    final sensors = state.sensors;

                    if (sensors.isEmpty) {
                      return const EmptyState(
                        message: 'No sensors found',
                        subMessage: 'Waiting for sensor data...',
                        icon: Icons.sensors_off_outlined,
                      );
                    }

                    return _buildSensorList(sensors);
                  }

                  return const AppLoading(
                    text: 'Loading sensors...',
                    color: AppColors.sensorGreen,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorList(List<SensorModel> sensors) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
      itemCount: sensors.length,
      itemBuilder: (context, index) {
        final sensor = sensors[index];
        return GestureDetector(
          onTap: () => _navigateToDetails(context, sensor),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.sensorGreen.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              
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
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // One sensor below
                SensorGauge(
                  value: sensor.soilMoisture,
                  maxValue: 100,
                  label: 'Soil Moisture',
                  unit: '%',
                  color: AppColors.sensorGreen,
                  icon: Icons.grass_rounded,
                  compact: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToDetails(BuildContext context, SensorModel sensor) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, animation, __) => FadeTransition(
          opacity: animation,
          child: SensorDetailsPage(sensor: sensor),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.eco_rounded,
                color: AppColors.sensorGreen,
                size: 22,
              ),
              const SizedBox(width: 12),
              const Text(
                'Smart Farm',
                style: TextStyle(
                  color: AppColors.sensorGreen,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(),
              const Text(
                'Live',
                style: TextStyle(
                  color: AppColors.sensorLightGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Sensor\nDashboard',
            style: TextStyle(
              color: AppColors.sensorTextLight,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Monitoring field conditions in real time',
            style: TextStyle(
              color: AppColors.sensorTextLight,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
