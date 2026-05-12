import 'package:smart_farm_app/data/models/zone_model.dart';

import '../../core/api/api_service.dart';

class CropApi {
  final ApiService api = ApiService();

  Future<List<CropModel>> getCrops() async {
    final data = await api.get(endpoint: "/api/crop");

    if (data == null) return [];

    return List.from(data).map((e) => CropModel.fromJson(e)).toList();
  }
}
