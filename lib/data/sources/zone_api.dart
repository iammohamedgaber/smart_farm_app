


import 'package:smart_farm_app/core/api/api_service.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';

class ZoneApi {
  final ApiService api = ApiService();

  
  Future<List<ZoneModel>> getZones() async {
    final data = await api.get(endpoint: "/api/Zone");

    if (data == null || data is! List) {
      return [];
    }

    return data.map((e) => ZoneModel.fromJson(e)).toList();
  }

  // ✅ تفاصيل Zone واحدة (crop + last irrigation)
  Future<ZoneModel?> getZoneDetails(int zoneId) async {
    final data = await api.get(endpoint: "/api/zone/$zoneId/crop");

    if (data == null) return null;

    return ZoneModel.fromJson(data);
  }

  
  Future<List<ZoneModel>> getZonesByCrop(int cropId) async {
    final data = await api.get(endpoint: "/api/zone/by-crop/$cropId");

    if (data == null || data is! List) {
      return [];
    }

    return data.map((e) => ZoneModel.fromJson(e)).toList();
  }
}
