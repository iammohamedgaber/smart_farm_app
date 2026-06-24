import 'package:smart_farm_app/core/api/api_service.dart';
import 'package:smart_farm_app/data/models/SensorModel.dart';

class SensorApi {
  final ApiService api = ApiService();

  Future<List<SensorModel>> getAllSensors() async {
    final data = await api.get(endpoint: "/api/Sensor/all");

    if (data == null || data is! List) {
      return [];
    }

    return data.map((e) => SensorModel.fromJson(e)).toList();
  }

  Future<SensorModel?> getSensorDetails(int sensorId) async {
    final data = await api.get(endpoint: "/api/Sensor/$sensorId");

    if (data == null) return null;

    return SensorModel.fromJson(data);
  }
}
