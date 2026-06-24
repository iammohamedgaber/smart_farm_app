import 'package:smart_farm_app/core/api/api_service.dart';
import 'package:smart_farm_app/data/models/RobotSt_model.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';

class RobotApi {
  final ApiService api = ApiService();

  Future<bool> plantCrop(PlantCropRequest model) async {
    try {
      await api.post(endpoint: "/api/robot/plant", body: model.toJson());
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
      await api.post(endpoint: "/api/robot/irrigate", body: model.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> harvest(HarvestRequest model) async {
    try {
      await api.post(endpoint: "/api/robot/harvest", body: model.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> scan(ScanRequest model) async {
    try {
      await api.post(endpoint: "/api/robot/scan", body: model.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> plantFound(PlantFoundRequest model) async {
    try {
      await api.post(endpoint: "/api/robot/plant-found", body: model.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}


