import 'package:smart_farm_app/core/api/api_service.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';

class RobotApi {
  final ApiService api = ApiService();

  Future<bool> plantCrop(PlantCropRequest model) async {
    try {
      await api.post(endpoint: "/api/Robot/plant", body: model.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeWeed(RemoveHarmfulPlantRequest model) async {
    try {
      await api.post(
        endpoint: "/api/robot/remove-harmful",
        body: model.toJson(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> irrigate(IrrigateRequest model) async {
    try {
      await api.post(endpoint: '/api/robot/irrigate', body: model.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
