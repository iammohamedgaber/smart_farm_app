import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/presentation/sensors/cubit/sensor_cubit.dart';
import 'package:smart_farm_app/presentation/sensors/view/SensorGauge.dart';
import 'package:smart_farm_app/data/models/SensorModel.dart';
import 'package:smart_farm_app/presentation/sensors/view/Sensor_Details_Page.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({super.key});

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  @override
  void initState() {
    super.initState();
    // ✅ استدعاء تحميل الحساسات مرة واحدة عند فتح الصفحة
    context.read<SensorCubit>().loadSensors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A2E1F),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SensorCubit, SensorCubitState>(
                builder: (context, state) {
                  if (state is SensorCubitLoading ||
                      state is SensorCubitInitial) {
                    return const _LoadingView();
                  } else if (state is SensorCubitError) {
                    return _ErrorView(message: state.message);
                  } else if (state is SensorCubitLoaded) {
                    final sensors = state.sensors;
                    if (sensors.isEmpty) return const _EmptyView();
                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
                      itemCount: sensors.length,
                      itemBuilder: (context, index) {
                        final sensor = sensors[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(
                                milliseconds: 400,
                              ),
                              pageBuilder: (_, animation, __) => FadeTransition(
                                opacity: animation,
                                child: SensorDetailsPage(sensor: sensor),
                              ),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.green.withOpacity(0.2),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // اتنين فوق
                                Row(
                                  children: [
                                    Expanded(
                                      child: SensorGauge(
                                        value: sensor.airTemperature,
                                        maxValue: 100,
                                        label: 'Air Temperature',
                                        unit: '°C',
                                        color: const Color(0xFFFF6B4A),
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
                                        color: const Color(0xFF4A9EFF),
                                        icon: Icons.water_drop_rounded,
                                        compact: false,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // واحدة تحت لوحدها
                                SensorGauge(
                                  value: sensor.soilMoisture,
                                  maxValue: 100,
                                  label: 'Soil Moisture',
                                  unit: '%',
                                  color: const Color(0xFF1DB860),
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
                  return const _EmptyView();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Header ──────────────────────────────────────────────
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(Icons.eco_rounded, color: Color(0xFF1DB860), size: 22),
              SizedBox(width: 12),
              Text(
                'Smart Farm',
                style: TextStyle(
                  color: Color(0xFF1DB860),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
              Spacer(),
              Text(
                'Live',
                style: TextStyle(
                  color: Color(0xFF6EE7A0),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Sensor\nDashboard',
            style: TextStyle(
              color: Color(0xFFF0F4F0),
              fontSize: 34,
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Monitoring field conditions in real time',
            style: TextStyle(
              color: Color(0xFFF0F4F0),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  @override
  Widget build(BuildContext context) => const Center(
    child: CircularProgressIndicator(
      color: Color(0xFF1DB860),
      strokeWidth: 2.5,
    ),
  );
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});
  @override
  Widget build(BuildContext context) => Center(
    child: Text(message, style: const TextStyle(color: Colors.redAccent)),
  );
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();
  @override
  Widget build(BuildContext context) => const Center(
    child: Text(
      'No sensors found',
      style: TextStyle(color: Color(0xFFF0F4F0), fontSize: 15),
    ),
  );
}
