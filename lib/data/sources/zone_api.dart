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
}
